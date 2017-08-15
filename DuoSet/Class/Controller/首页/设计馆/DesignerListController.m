//
//  DesignerListController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerListController.h"
#import "DesignerCollectionCell.h"
#import "DesignerDetailsController.h"
#import "DesignerData.h"
#import "LoginViewController.h"
#import "CustomNavController.h"

@interface DesignerListController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *designerArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation DesignerListController

-(instancetype)initWithDesignerIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        _index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    if (_index == 0) {
        self.title = @"哆集设计师";
    }
    if (_index == 1) {
        self.title = @"特色设计师";
    }
    if (_index == 2) {
        self.title = @"品牌设计师";
    }
    [self configUI];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self configDesignerData:true showHud:true];
}

-(void)configDesignerData:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"designer/designer?page=%ld&limit=%ld&type=%ld",(long)_page,_limit,_index];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _designerArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *dic in objectArr) {
                    DesignerData *item = [DesignerData dataForDictionary:dic];
                    [_designerArr addObject:item];
                }
                [_collectionView reloadData];
            }
            if (_designerArr.count == 0) {
                [self showDefeatedView:true];
            }
            [_collectionView.mj_footer endRefreshing];
            [_collectionView.mj_header endRefreshing];
        }
    } fail:^(NSError *error) {
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    }];
}

- (void)configUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((mainScreenWidth-FitHeight(10.0))/2, FitHeight(610.0));
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = FitHeight(10.0);
    flowLayout.minimumInteritemSpacing = FitHeight(10.0);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = false;
    _collectionView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    [_collectionView registerClass:[DesignerCollectionCell class] forCellWithReuseIdentifier:@"DesignerCollectionCellID"];
    [flowLayout setHeaderReferenceSize:CGSizeMake(mainScreenWidth, FitHeight(10.0))];
    [flowLayout setFooterReferenceSize:CGSizeMake(mainScreenWidth, FitHeight(10.0))];
    _collectionView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page += 0;
        [self configDesignerData:true showHud:false];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configDesignerData:false showHud:false];
    }];
    [self.view addSubview:_collectionView];
}

-(void)showSingleItemDetailWithIndex:(NSInteger)index{
//    SingleProductNewController *detailVC = [[SingleProductNewController alloc]init];
//    detailVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detailVC animated:true];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _designerArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DesignerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DesignerCollectionCellID" forIndexPath:indexPath];
    DesignerData *item = _designerArr[indexPath.row];
    [cell setupInfoWithDesignerData:item];
    cell.likeHandle = ^(UIButton *btn){
        [self topDesignerLikeWithBtn:btn andIndexPath:indexPath];
    };
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DesignerData *item = _designerArr[indexPath.row];
    DesignerDetailsController *deserDetailsVC = [[DesignerDetailsController alloc]initWithDesignerId:item.designer_id];
    deserDetailsVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:deserDetailsVC animated:true];
}

#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((mainScreenWidth-FitHeight(10.0))/2, FitHeight(480.0));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)topDesignerLikeWithBtn:(UIButton *)btn andIndexPath:(NSIndexPath *)indexPath{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    DesignerData *item = _designerArr[indexPath.row];
    if (btn.selected) {//取消点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.designer_id forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/collectCancel" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.selected = false;
                btn.userInteractionEnabled = true;
                if ([responseDic objectForKey:@"object"]){
                    NSString *str = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"object"]];
                    [btn setTitle:str forState:UIControlStateNormal];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }else{//点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.designer_id forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/collect" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.selected = true;
                btn.userInteractionEnabled = true;
                if ([responseDic objectForKey:@"object"]){
                    NSString *str = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"object"]];
                    [btn setTitle:str forState:UIControlStateNormal];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(BOOL)checkLogin{
    UserInfo *info = [Utils getUserInfo];
    return info.token.length > 0;
}

-(void)userlogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_order" messageName:@"暂时没有设计师哦" backBlockBtnName:nil backBlock:^{
                [self.navigationController popViewControllerAnimated:true];
            }];
            [self.view addSubview:_defeatedView];
            [self.view bringSubviewToFront:_defeatedView];
        }else{
            _defeatedView.hidden = false;
        }
    }else{
        _defeatedView.hidden = true;
    }
}

@end
