//
//  PiazzaItemListController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaItemListController.h"
#import "CustomCollectionViewLayout.h"
#import "PiazzaContentItemCell.h"
#import "PiazzaDetailsController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "CommonDefeatedView.h"

@interface PiazzaItemListController ()<UICollectionViewDataSource,UICollectionViewDelegate,FFCollectionLayoutDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
//data
@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,copy)   NSString *requestTypeStr;//2 收藏 3 赞
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSTimer *likeTimer;
@property (nonatomic,strong) NSMutableArray<PiazzaItemData *> *dataArr;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation PiazzaItemListController

-(instancetype)initWithUserId:(NSString *)userId andRequestTypeStr:(NSString *)requestTypeStr{
    self = [super init];
    if (self) {
        _userId = userId;
        _requestTypeStr = requestTypeStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_requestTypeStr.integerValue == 2) {
        self.title = @"我的收藏";
    }else{
        self.title = @"我的赞";
    }
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self configUI];
    [self configData:true showHud:true];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    
    CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc]init];
    layout.columnMargin = FitWith(30.0);
    layout.rowMargin = FitHeight(20.0);
    layout.columnsCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(-FitHeight(20.0), FitWith(20.0), 0, FitWith(20.0));
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) collectionViewLayout:layout];
    [_collectionView registerClass:[PiazzaContentItemCell class] forCellWithReuseIdentifier:@"PiazzaContentItemCellIdentifier"];
    _collectionView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = false;
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page += 0;
        [self configData:true showHud:false];
    }];
    _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_collectionView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configData:false showHud:false];
    }];
    [self.view addSubview:_collectionView];
}

-(void)configData:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    if (_requestTypeStr.integerValue == 2) {
        urlStr = [NSString stringWithFormat:@"community/%@/collectList?page=%ld&limit=10",_userId,_page];
    }else{
        urlStr = [NSString stringWithFormat:@"community/%@/likeList?page=%ld&limit=10",_userId,_page];
    }
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _dataArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if (_requestTypeStr.integerValue == 2) {
                    if ([objectDic objectForKey:@"collect"] && [[objectDic objectForKey:@"collect"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = [objectDic objectForKey:@"collect"];
                        _lastRequsetCount = arr.count;
                        for (NSDictionary *d in arr) {
                            PiazzaItemData *item = [PiazzaItemData dataForDictionary:d];
                            [_dataArr addObject:item];
                        }
                    }
                    if (_dataArr.count == 0) {
                        [self showDefeatedView:true andRequestTypeStr:_requestTypeStr];
                    }
                    [_collectionView reloadData];
                }else{
                    if ([objectDic objectForKey:@"like"] && [[objectDic objectForKey:@"like"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = [objectDic objectForKey:@"like"];
                        _lastRequsetCount = arr.count;
                        for (NSDictionary *d in arr) {
                            PiazzaItemData *item = [PiazzaItemData dataForDictionary:d];
                            [_dataArr addObject:item];
                        }
                        if (_dataArr.count == 0) {
                            [self showDefeatedView:true andRequestTypeStr:_requestTypeStr];
                        }
                    }
                    [_collectionView reloadData];
                }
            }
        }
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_collectionView.mj_footer endRefreshing];
        [_collectionView.mj_header endRefreshing];
    }];
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
    cell.allowHandle = ^(UIButton *btn){
        if (_requestTypeStr.integerValue == 2) {//收藏
            [self collectBtnActionHandleWithButton:btn andInexPath:indexPath];
        }else{
            [self likeBtnActionHandleWithButton:btn andInexPath:indexPath];
        }
    };
    if (_requestTypeStr.integerValue == 2) {//收藏
        [cell setupInfoCollectWithPiazzaItemData:item];
    }else{
        [cell setupInfoWithPiazzaItemData:item imgVloadEndHandle:^{
            [collectionView reloadData];
        }];
    }
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
    detailsVC.likeHandle = ^(BOOL liked) {
        item.isLike = true;
        item.likeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
        [_collectionView reloadData];
    };
    [self.navigationController pushViewController:detailsVC animated:true];
}

#pragma mark - 点赞 延迟操作
-(void)collectBtnActionHandleWithButton:(UIButton *)btn andInexPath:(NSIndexPath *)indexPath{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    PiazzaItemData *item = _dataArr[indexPath.row];
    if (btn.selected) {
        item.isCollect = false;
        NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.collectNum.integerValue - 1];
        item.collectNum = newLikeCount;
        [btn setTitle:newLikeCount forState:UIControlStateNormal];
        
        btn.selected = false;
    }else{
        item.isCollect = false;
        NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.collectNum.integerValue + 1];
        item.collectNum = newLikeCount;
        [btn setTitle:newLikeCount forState:UIControlStateNormal];
        btn.selected = true;
    }
    if (_likeTimer == nil) {
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithCollectBtn:btn AndIndexPath:indexPath];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }else{
        [_likeTimer invalidate];
        _likeTimer = nil;
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithCollectBtn:btn AndIndexPath:indexPath];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }
}

-(void)delayTimeWithCollectBtn:(UIButton *)btn AndIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemData *item = _dataArr[indexPath.row];
    NSString *urlStr = @"";
    if (btn.selected) {
        urlStr = [NSString stringWithFormat:@"community/%@/collect/add",item.communityId];
    }else{
        urlStr = [NSString stringWithFormat:@"community/%@/collect/remove",item.communityId];
    }
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 点赞 延迟操作
-(void)likeBtnActionHandleWithButton:(UIButton *)btn andInexPath:(NSIndexPath *)indexPath{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    PiazzaItemData *item = _dataArr[indexPath.row];
    if (btn.selected) {
        [MQToast showToast:@"您已经点过赞了" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }else{
        item.isLike = true;
        NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
        item.likeCount = newLikeCount;
        [btn setTitle:newLikeCount forState:UIControlStateNormal];
        btn.selected = true;
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"community/%@/like",item.communityId];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithBool:true] forKey:@"likeCommunity"];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                NSLog(@"操作成功");
            }
        } fail:^(NSError *error) {
            //
        }];
    }
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


#pragma mark - 展示缺省页
-(void)showDefeatedView:(BOOL)show andRequestTypeStr:(NSString *)requestTypeStr{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:requestTypeStr.integerValue == 2 ? @"defeated_no_like" : @"defeated_no_likedata" messageName:requestTypeStr.integerValue == 2 ? @"您还没有任何收藏记录呢~" :  @"您暂时还没有赞哦~" backBlockBtnName:nil   backBlock:^{
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
