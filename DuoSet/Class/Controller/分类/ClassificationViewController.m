//
//  ClassificationViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ClassificationViewController.h"
#import "ClassificationTypeCollectionViewCell.h"
#import "ClassificationCollectionReusableView.h"
#import "SingleProductNewController.h"
#import "ScreenProductController.h"
#import "CategoryItem.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "FirstHeaderdReusableView.h"

@interface ClassificationViewController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger isSelectedClassificationType; // 是否选中左侧导航
}

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UIView *navline;
@property (nonatomic,strong) UILabel *hotWordLable;
@property (nonatomic,strong) UIView *unredView;

@property (nonatomic, copy) UITableView *classificationTypeTableView; // 左侧导航TableView
@property (nonatomic, copy) UICollectionView *classificationTypeCollectionView; // 内容CollectionView
//Datas
@property (nonatomic,strong) NSMutableArray *subCategorys;
@property (nonatomic,assign) NSInteger tableViewSelectedIndex;

@end

@implementation ClassificationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (_subCategorys.count == 0) {
        [self configData];
    }
    if ([self checkLogin]) {
        if ([self checkRefreshToken]) {
            [self getvalidateNewMessage];
        }else{
            [RequestManager refershTokenSuccess:^{
                [self getvalidateNewMessage];
            }];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LGBgColor;
    [self configNavView];
    [self initView];
    _tableViewSelectedIndex = 0;
    [self configData];
    [self getHotWordData];
}

-(void)configNavView{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navView];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    leftBtn.titleLabel.font = CUSFONT(10);
    [leftBtn setImage:[UIImage imageNamed:@"home_nav_sgin"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(progressClassificationLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:leftBtn];
    
    UIButton *centerSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(44, 26, mainScreenWidth - 44 - 44, 31)];
    centerSearchButton.backgroundColor = [UIColor colorFromHex:0xf5f5f5];
    centerSearchButton.layer.cornerRadius = 16;
    centerSearchButton.layer.masksToBounds = true;
    [centerSearchButton addTarget:self action:@selector(progressClassificationCenterSearchButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:centerSearchButton];
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 9, 13, 13)];
    leftView.image = [UIImage imageNamed:@"home_nav_search"];
    leftView.contentMode = UIViewContentModeScaleAspectFill;
    [centerSearchButton addSubview:leftView];
    
    _hotWordLable = [[UILabel alloc]initWithFrame:CGRectMake(37, 0, FitWith(300.0), 31)];
    _hotWordLable.textColor = [UIColor colorFromHex:0x808080];
    _hotWordLable.font = [UIFont systemFontOfSize:13];
    _hotWordLable.textAlignment = NSTextAlignmentLeft;
    [centerSearchButton addSubview:_hotWordLable];
    
    UIButton *rightMessageCenterButton = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [rightMessageCenterButton setImage:[UIImage imageNamed:@"home_nav_message_01"] forState:UIControlStateNormal];
    [rightMessageCenterButton addTarget:self action:@selector(progressClassificationRightMessageCenterButton) forControlEvents:UIControlEventTouchUpInside];
    rightMessageCenterButton.contentMode = UIViewContentModeCenter;
    [_navView addSubview:rightMessageCenterButton];
    //未读消息提醒标识
    _unredView = [[UIView alloc]initWithFrame:CGRectMake(30, 5, 8, 8)];
    _unredView.backgroundColor = [UIColor mainColor];
    _unredView.layer.masksToBounds = true;
    _unredView.layer.cornerRadius = 4;
    _unredView.hidden = true;
    [rightMessageCenterButton addSubview:_unredView];
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:1];
    [_navView addSubview:_navline];
    
    [self.view bringSubviewToFront:_navView];
}

- (void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/classify/basic" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                _subCategorys = [NSMutableArray array];
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objectArr) {
                    CategoryItem *item = [CategoryItem dataForDictionary:d];
                    [_subCategorys addObject:item];
                }
                [_classificationTypeTableView reloadData];
                [_classificationTypeCollectionView reloadData];
            }
        }
        } fail:^(NSError *error) {
            //
        }];
}

-(void)getHotWordData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/keyword" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] &&[[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"hot"] && [[objDic objectForKey:@"hot"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *hotDic = [objDic objectForKey:@"hot"];
                    if ([hotDic objectForKey:@"word"]) {
                        _hotWordLable.text = [NSString stringWithFormat:@"%@",[hotDic objectForKey:@"word"]];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)getvalidateNewMessage{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/message/validateNewMessage" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"count"]) {//_footView
                    NSString *count = [objDic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"count"]] : @"0";
                    _unredView.hidden = count.integerValue == 0;
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

/**初始化视图*/
- (void)initView {
    self.view.backgroundColor = LGBgColor;
    
    [self.view addSubview:self.classificationTypeTableView];
    [self.view addSubview:self.classificationTypeCollectionView];
    
    UIImage *img = [UIImage imageNamed:@"home_footLine"];
    UIImageView *footLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - img.size.height - 42, mainScreenWidth, img.size.height)];
    footLineView.image = [UIImage imageNamed:@"home_footLine"];
    [self.view addSubview:footLineView];
}

- (void)progressClassificationLeftSignInButton{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    SignInViewController *signInVC = [[SignInViewController alloc] init];
    signInVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:signInVC animated:true];
}

- (void)progressClassificationRightMessageCenterButton{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc] init];
    messageCenterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageCenterVC animated:true];
}

- (void)progressClassificationCenterSearchButton{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:searchVC animated:true];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subCategorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ClassificationViewControllerCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    CategoryItem *item = _subCategorys[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = item.name;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (indexPath.row == isSelectedClassificationType) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.contentView.backgroundColor = LGBgColor;
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14*AdapterWidth()];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = LGBgColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _tableViewSelectedIndex = indexPath.row;
    isSelectedClassificationType = indexPath.row;
    [_classificationTypeTableView reloadData];
    [_classificationTypeCollectionView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(100.0);
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    CategoryItem *item = _subCategorys[_tableViewSelectedIndex];
    return item != nil ? item.childs.count : 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CategoryItem *item = _subCategorys[_tableViewSelectedIndex];
    CategoryItem *childitem = item.childs[section];
    return childitem.childs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassificationTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassificationTypeCollectionViewCellIdentifier" forIndexPath:indexPath];
    CategoryItem *item = _subCategorys[_tableViewSelectedIndex];
    CategoryItem *childitem = item.childs[indexPath.section];
    CategoryItem *subChileItem = childitem.childs[indexPath.row];
    cell.imageViewLabel.text = subChileItem.name;
    [cell.imageViewButton sd_setImageWithURL:[NSURL URLWithString:subChileItem.picture] forState:UIControlStateNormal placeholderImage:placeholderImage_226_256];
    return cell;
}


//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(mainScreenWidth - 120 *AdapterWidth(), 175 *AdapterHeight());
    }else{
        return CGSizeMake(mainScreenWidth - 120 *AdapterWidth(), 40 *AdapterHeight());
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UICollectionReusableView *reusableView = nil;
        if (kind == UICollectionElementKindSectionHeader) { // 定制头部视图的内容
            FirstHeaderdReusableView *headCollectionReusableViews = (FirstHeaderdReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FirstHeaderdReusableViewID" forIndexPath:indexPath];
            CategoryItem *item = _subCategorys[_tableViewSelectedIndex];
            CategoryItem *childitem = item.childs[indexPath.section];
            headCollectionReusableViews.classificationCollectionTitleLabel.text = childitem.name;
            [headCollectionReusableViews.headerImgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImage_702_420 options:0];
            reusableView = headCollectionReusableViews;
        }
        return reusableView;
    }else{
        UICollectionReusableView *reusableView = nil;
        if (kind == UICollectionElementKindSectionHeader) { // 定制头部视图的内容
            ClassificationCollectionReusableView *headCollectionReusableViews = (ClassificationCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassificationCollectionReusableViewID" forIndexPath:indexPath];
            CategoryItem *item = _subCategorys[_tableViewSelectedIndex];
            CategoryItem *childitem = item.childs[indexPath.section];
            headCollectionReusableViews.classificationCollectionTitleLabel.text = childitem.name;
            reusableView = headCollectionReusableViews;
        }
        return reusableView;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryItem *item = _subCategorys[_tableViewSelectedIndex];
    CategoryItem *childitem = item.childs[indexPath.section];
    CategoryItem *subChileItem = childitem.childs[indexPath.row];
    ScreenProductController *popularVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andItemId:subChileItem.categoryId];
    popularVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:popularVC  animated:YES];
}

#pragma mark - 懒加载
//分类左侧导航
- (UITableView *)classificationTypeTableView{
    if (!_classificationTypeTableView) {
        _classificationTypeTableView = ({
            UITableView *classificationTypeTableViews = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 100 *AdapterWidth(), mainScreenHeight - 64 - 50)];
            classificationTypeTableViews.backgroundColor = LGBgColor;
            classificationTypeTableViews.delegate = self;
            classificationTypeTableViews.dataSource = self;
            classificationTypeTableViews.scrollEnabled = true;
            classificationTypeTableViews.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [classificationTypeTableViews setSeparatorColor:[UIColor colorFromHex:0xe5e5e5]];
            classificationTypeTableViews;
        });
    }
    return _classificationTypeTableView;
}

//内容Collection
- (UICollectionView *)classificationTypeCollectionView{
    if (!_classificationTypeCollectionView) {
        _classificationTypeCollectionView = ({
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.itemSize = CGSizeMake(mainScreenWidth / 5 - 10 *AdapterWidth(), 90 *AdapterHeight());
            [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            
            
            UICollectionView *classificationTypeCollectionViews = [[UICollectionView alloc] initWithFrame:CGRectMake(110 *AdapterWidth(), 64, mainScreenWidth - 120 *AdapterWidth(), mainScreenHeight - 50 - 64) collectionViewLayout:flowLayout];
            classificationTypeCollectionViews.showsHorizontalScrollIndicator = false;
            classificationTypeCollectionViews.showsVerticalScrollIndicator = false;
            classificationTypeCollectionViews.backgroundColor = LGBgColor;
            classificationTypeCollectionViews.dataSource = self;
            classificationTypeCollectionViews.delegate = self;
            classificationTypeCollectionViews.backgroundColor = [UIColor whiteColor];
            [classificationTypeCollectionViews registerClass:[ClassificationTypeCollectionViewCell class] forCellWithReuseIdentifier:@"ClassificationTypeCollectionViewCellIdentifier"];
            [flowLayout setHeaderReferenceSize:CGSizeMake(classificationTypeCollectionViews.frame.size.width, 40 *AdapterHeight())];
            [classificationTypeCollectionViews registerClass:[ClassificationCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ClassificationCollectionReusableViewID"]; // 注册头部视图
            
            [flowLayout setHeaderReferenceSize:CGSizeMake(classificationTypeCollectionViews.frame.size.width, 140 *AdapterHeight())];
            [classificationTypeCollectionViews registerClass:[FirstHeaderdReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FirstHeaderdReusableViewID"]; // 注册头部视图
            
            classificationTypeCollectionViews;
        });
    }
    return _classificationTypeCollectionView;
}

#pragma mark - 判断登录
-(BOOL)checkLogin{
    UserInfo *info = [Utils getUserInfo];
    return info.token.length > 0;
}

-(void)userlogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

-(BOOL)checkRefreshToken{
    if ([Utils getUserInfo].token.length > 0) {
        UserInfo *info = [Utils getUserInfo];
        NSDate *now = [NSDate date];
        NSInteger tmp = [now timeIntervalSinceDate:info.refreshTokenDate];
        if (tmp < (info.expiresIn.integerValue)/1000) {//还没过期了
            return true;
        }
    }
    return false;
}

@end
