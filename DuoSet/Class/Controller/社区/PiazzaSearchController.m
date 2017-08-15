//
//  PiazzaSearchController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/26.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaSearchController.h"
#import "MKJTagViewTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SearchHistoryCell.h"
#import "SearchData.h"
#import "SearchPiazzaDataDB.h"
#import "CustomCollectionViewLayout.h"
#import "PiazzaContentItemCell.h"
#import "PiazzaDetailsController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "CommonDefeatedView.h"

@interface PiazzaSearchController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,FFCollectionLayoutDelegate>
{
    UITableView *_tableView;
    UICollectionView *_collectionView;
}

//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIImageView *bgImgV;
@property(nonatomic,strong) UITextField *navInputTF;
@property(nonatomic,strong) UIButton *rightCancelBtn;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;
//data
@property(nonatomic,strong) NSMutableArray *hotWords;
@property(nonatomic,strong) NSArray *historyArr;
@property(nonatomic,strong) SearchPiazzaDataDB *dataDb;
@property(nonatomic,copy)   NSString *hotStr;
@property(nonatomic,copy)   NSString *keyWords;
//Data
@property (nonatomic,strong) NSMutableArray<PiazzaItemData *> *dataArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,strong) NSTimer *likeTimer;

@end

static NSString *identyfy = @"MKJTagViewTableViewCell";

@implementation PiazzaSearchController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataDb = [SearchPiazzaDataDB shareManager];
    _historyArr = [_dataDb allData];
    [self configUI];
    [self configNav];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    _hotWords = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    [self configData];
    [self configPiazzaDataWithKeyWord:_keyWords clear:true showHud:true];
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/keyword?type=1" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] &&[[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"hot"] && [[objDic objectForKey:@"hot"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *hotDic = [objDic objectForKey:@"hot"];
                    if ([hotDic objectForKey:@"word"]) {
                        _navInputTF.placeholder = [NSString stringWithFormat:@"%@",[hotDic objectForKey:@"word"]];
                        _hotStr = [NSString stringWithFormat:@"%@",[hotDic objectForKey:@"word"]];
                    }
                }
                if ([objDic objectForKey:@"list"] && [[objDic objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                    NSArray *listArr = [objDic objectForKey:@"list"];
                    for (NSDictionary *d in listArr) {
                        if ([d objectForKey:@"word"]) {
                            [_hotWords addObject:[NSString stringWithFormat:@"%@",[d objectForKey:@"word"]]];
                        }
                        [_tableView reloadData];
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configPiazzaDataWithKeyWord:(NSString *)keyWords clear:(BOOL)clear showHud:(BOOL)showHud{
    _navInputTF.text = keyWords;
    NSString *urlStr = [NSString stringWithFormat:@"community?page=0&limit=10&keyword=%@",keyWords];
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [RequestManager requestWithMethod:GET WithUrlPath:encodedString params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _dataArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"newCommunitys"] && [[objectDic objectForKey:@"newCommunitys"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objectDic objectForKey:@"newCommunitys"];
                    _lastRequsetCount = arr.count;
                    if (arr.count > 0) {
                        SearchData *itme = [[SearchData alloc]init];
                        itme.obj_id = @"-1";
                        itme.name = keyWords;
                        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
                        NSString *create_time = [NSString stringWithFormat:@"%f",interval];
                        itme.create_time = create_time;
                        [_dataDb insertDataWithModel:itme];
                        _historyArr = [_dataDb allData];
                        [_tableView reloadData];
                        _collectionView.hidden = false;
                    }
                    _lastRequsetCount = arr.count;
                    for (NSDictionary *d in arr) {
                        PiazzaItemData *item = [PiazzaItemData dataForDictionary:d];
                        [_dataArr addObject:item];
                    }
                }
                [_collectionView reloadData];
            }
        }
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    }];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, mainScreenWidth, mainScreenHeight - 44) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [_tableView registerNib:[UINib nibWithNibName:identyfy bundle:nil] forCellReuseIdentifier:identyfy];
    [self.view addSubview:_tableView];
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *hotlabel = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), 0, mainScreenWidth - FitWith(24.0), FitHeight(90.0))];
    hotlabel.text = @"热搜";
    hotlabel.textColor = [UIColor colorFromHex:0x222222];
    hotlabel.font = CUSFONT(14);
    [headerView addSubview:hotlabel];
    _tableView.tableHeaderView = headerView;
    
    CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc]init];
    layout.columnMargin = FitWith(30.0);
    layout.rowMargin = FitHeight(20.0);
    layout.columnsCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(-FitHeight(20.0), FitWith(20.0), 0, FitWith(20.0));
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) collectionViewLayout:layout];
    [_collectionView registerClass:[PiazzaContentItemCell class] forCellWithReuseIdentifier:@"PiazzaContentItemCellIdentifier"];
    _collectionView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = false;
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.mj_header = [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self configPiazzaDataWithKeyWord:_keyWords clear:true showHud:false];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configPiazzaDataWithKeyWord:_keyWords clear:false showHud:false];
    }];
    [self.view addSubview:_collectionView];
    
    _collectionView.hidden = true;
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _bgImgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(24.0), 27, mainScreenWidth - FitWith(24.0) - 44, 26)];
    _bgImgV.image = [UIImage imageNamed:@"common_search_bg"];
    _bgImgV.contentMode = UIViewContentModeScaleAspectFill;
    _bgImgV.userInteractionEnabled = true;
    [_navView addSubview:_bgImgV];
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(24.0), 5, 15, 15)];
    leftView.image = [UIImage imageNamed:@"home_nav_search"];
    leftView.contentMode = UIViewContentModeScaleAspectFill;
    [_bgImgV addSubview:leftView];
    
    _navInputTF = [[UITextField alloc]initWithFrame:CGRectMake(leftView.frame.origin.x + leftView.frame.size.width + FitWith(20.0), 0, FitWith(520.0), 26)];
    _navInputTF.font = CUSFONT(13);
    _navInputTF.textColor = [UIColor colorFromHex:0x222222];
    _navInputTF.tintColor = [UIColor mainColor];
    _navInputTF.returnKeyType = UIReturnKeySearch;
    _navInputTF.delegate = self;
    [_navInputTF becomeFirstResponder];
    [_navInputTF addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    [_bgImgV addSubview:_navInputTF];
    
    _rightCancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth -44, 20, 44, 44)];
    _rightCancelBtn.titleLabel.font = CUSFONT(13);
    [_rightCancelBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [_rightCancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_rightCancelBtn addTarget:self action:@selector(rightClearHandle) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightCancelBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

#pragma mark - UiTableViewDaraSource & UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _hotWords.count == 0 ? 0 : 1;
    }
    if (section == 1) {
        return _historyArr.count == 0 ? 0 : _historyArr.count + 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MKJTagViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfy forIndexPath:indexPath];
        [self configCell:cell indexpath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *SearchHistoryCellID = @"SearchHistoryCellID";
        SearchHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:SearchHistoryCellID];
        if (cell == nil) {
            cell = [[SearchHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SearchHistoryCellID];
        }
        if (indexPath.row == 0 ) {
            cell.titleLable.text = @"历史搜索";
        }else{
            SearchData *item = _historyArr[indexPath.row - 1];
            cell.titleLable.text = item.name;
        }
        cell.titleLable.textColor = indexPath.row == 0 ? [UIColor colorFromHex:0x222222] : [UIColor colorFromHex:0x808080];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)configCell:(MKJTagViewTableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    [cell.tagView removeAllTags];
    cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
    cell.tagView.padding = UIEdgeInsetsMake(5, FitWith(20), FitHeight(20), FitWith(20));
    cell.tagView.lineSpacing = 10;
    cell.tagView.interitemSpacing = FitWith(28.0);
    cell.tagView.singleLine = NO;
    NSMutableArray *nameArr = _hotWords;
    
    [nameArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SKTag *tag = [[SKTag alloc] initWithText:nameArr[idx]];
        tag.font = [UIFont systemFontOfSize:13];
        tag.textColor = [UIColor colorFromHex:0x222222];
        tag.bgColor =[UIColor colorFromHex:0xf2f2f2];
        tag.cornerRadius = 3;
        tag.enable = true;
        tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        [cell.tagView addTag:tag];
    }];
    
    cell.tagView.didTapTagAtIndex = ^(NSUInteger index,UIButton *btn,NSArray *tagBtns)
    {
        NSLog(@"btn.title:%@",btn.titleLabel.text);
        SearchData *itme = [[SearchData alloc]init];
        itme.obj_id = @"-1";
        itme.name = btn.titleLabel.text;
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        NSString *create_time = [NSString stringWithFormat:@"%f",interval];
        itme.create_time = create_time;
        [_dataDb insertDataWithModel:itme];
        _historyArr = [_dataDb allData];
        [_tableView reloadData];
        _keyWords = btn.titleLabel.text;
        [self configPiazzaDataWithKeyWord:btn.titleLabel.text clear:true showHud:true];
    };
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        if (_historyArr.count == 0) {
            return [[UIView alloc]initWithFrame:CGRectZero];
        }else{
            UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(210.0))];
            sectionView.backgroundColor = [UIColor whiteColor];
            UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0), FitHeight(60.0), mainScreenWidth - FitWith(48.0), FitHeight(90.0))];
            deleteBtn.titleLabel.font = CUSFONT(12);
            deleteBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
            deleteBtn.layer.borderWidth = 0.5;
            deleteBtn.layer.cornerRadius = 3;
            deleteBtn.layer.masksToBounds = true;
            [deleteBtn setTitle:@"清空历史搜索" forState:UIControlStateNormal];
            [deleteBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
            [deleteBtn addTarget:self action:@selector(deleteAllHistoryData) forControlEvents:UIControlEventTouchUpInside];
            [sectionView addSubview:deleteBtn];
            return sectionView;
        }
    }
    return [[UIView alloc]initWithFrame:CGRectZero];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 1 && indexPath.row >= 1;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SearchData *item = _historyArr[indexPath.row - 1];
        [_dataDb deleteDataWithModel:item];
        _historyArr = [_dataDb allData];
        [_tableView reloadData];
    }
}

-(void)deleteAllHistoryData{
    [_dataDb deleteAllData];
    _historyArr = [_dataDb allData];
    [_tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        if (_historyArr.count == 0) {
            return 0.1;
        }
        return FitHeight(210.0);
    }
    return 0.1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:identyfy configuration:^(id cell) {
            [self configCell:cell indexpath:indexPath];
        }];
    }
    return FitHeight(100.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView) {//历史记录
        if (indexPath.section == 1 && indexPath.row != 0) {
            SearchData *item = _historyArr[indexPath.row - 1];
            _keyWords = item.name;
            [self configPiazzaDataWithKeyWord:item.name clear:true showHud:true];
        }
    }
}

#pragma mark - textFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    _dataArr = [NSMutableArray array];
    NSString *keyWords = textField.text.length > 0 ? textField.text : _hotStr;
    _keyWords = keyWords;
    NSString *urlStr = [NSString stringWithFormat:@"community?page=0&limit=10&keyword=%@",keyWords];
    NSString *encodedString = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [RequestManager requestWithMethod:GET WithUrlPath:encodedString params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"newCommunitys"] && [[objectDic objectForKey:@"newCommunitys"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objectDic objectForKey:@"newCommunitys"];
                    _lastRequsetCount = arr.count;
                    if (arr.count > 0) {
                        SearchData *itme = [[SearchData alloc]init];
                        itme.obj_id = @"-1";
                        itme.name = keyWords;
                        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
                        NSString *create_time = [NSString stringWithFormat:@"%f",interval];
                        itme.create_time = create_time;
                        [_dataDb insertDataWithModel:itme];
                        _historyArr = [_dataDb allData];
                        [_tableView reloadData];
                        _collectionView.hidden = false;
                    }
                    _lastRequsetCount = arr.count;
                    for (NSDictionary *d in arr) {
                        PiazzaItemData *item = [PiazzaItemData dataForDictionary:d];
                        [_dataArr addObject:item];
                    }
                }
            }
            if (_dataArr.count == 0) {
                [self showDefeatedView:true];
            }
            [_collectionView reloadData];
        }
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    }];
    return true;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return true;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return true;
}

-(void)textFieldValueChange:(UITextField *)textField{
    _collectionView.hidden = true;
    [self showDefeatedView:false];
}

#pragma mark - right Cancle
-(void)rightClearHandle{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:true];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemData *item = _dataArr[indexPath.row];
    PiazzaContentItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PiazzaContentItemCellIdentifier" forIndexPath:indexPath];
    [cell setupInfoWithPiazzaItemData:item imgVloadEndHandle:^{
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }];
    cell.allowHandle = ^(UIButton *btn){
        [self likeBtnActionHandleWithButton:btn andInexPath:indexPath];
    };
    return cell;
}

- (CGFloat)flowLayout:(CustomCollectionViewLayout *)flowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemData *item = _dataArr[indexPath.row];
    return item.cellHight;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemData *item = _dataArr[indexPath.row];
    PiazzaDetailsController *detailsVC = [[PiazzaDetailsController alloc]initWithCommunityId:item.communityId];
    detailsVC.hidesBottomBarWhenPushed = true;
    detailsVC.deletedHandle = ^(NSString *itemId) {
        [_dataArr removeObject:item];
        [_collectionView reloadData];
    };
    [self.navigationController pushViewController:detailsVC animated:true];
}

#pragma mark - 点赞 延迟操作
-(void)likeBtnActionHandleWithButton:(UIButton *)btn andInexPath:(NSIndexPath *)indexPath{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    PiazzaItemData *item = _dataArr[indexPath.row];
    if (btn.selected) {
        item.isLike = false;
        NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue - 1];
        item.likeCount = newLikeCount;
        [btn setTitle:newLikeCount forState:UIControlStateNormal];
        
        btn.selected = false;
    }else{
        item.isLike = true;
        NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
        item.likeCount = newLikeCount;
        [btn setTitle:newLikeCount forState:UIControlStateNormal];
        btn.selected = true;
    }
    if (underiOS10) {
        [self delayTimeWithLikeBtn:btn AndIndexPath:indexPath];
        return;
    }
    if (_likeTimer == nil) {
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithLikeBtn:btn AndIndexPath:indexPath];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }else{
        [_likeTimer invalidate];
        _likeTimer = nil;
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithLikeBtn:btn AndIndexPath:indexPath];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }
}

-(void)delayTimeWithLikeBtn:(UIButton *)btn AndIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemData *item = _dataArr[indexPath.row];
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/%@/like",item.communityId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:btn.selected] forKey:@"likeCommunity"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
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

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_comment" messageName:@"没有数据哦~" backBlockBtnName:nil   backBlock:^{
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
