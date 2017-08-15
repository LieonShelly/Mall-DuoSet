//
//  PiazzaMainController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaMainController.h"
#import "YFRollingLabel.h"
#import "CustomCollectionViewLayout.h"
#import "PiazzaContentItemCell.h"
#import "PiazzaPublishController.h"
#import "PiazzaDetailsController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "PiazzaSearchController.h"
#import "FFGifHeader.h"
//Data
#import "PiazzaItemData.h"
#import "RewardListData.h"

@interface PiazzaMainController ()<UICollectionViewDataSource,UICollectionViewDelegate,FFCollectionLayoutDelegate>
//nav
@property(nonatomic,strong) UIImageView *navView;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIButton *uploadBtn;
@property(nonatomic,strong) UIView *line;
//View
@property(nonatomic,strong) UIView *fiashBgView;
@property(nonatomic,strong) YFRollingLabel *flashLable;
@property(nonatomic,strong) UICollectionView *collectionView;
//Data
@property (nonatomic,strong) NSMutableArray<PiazzaItemData *> *dataArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,strong) NSTimer *likeTimer;
@property (nonatomic,assign) NSInteger currentRewardIndex;
@property (nonatomic,strong) NSMutableArray<RewardListData *> *rewardListArr;
@property (nonatomic,strong) NSTimer *rewardTimer;

@end

@implementation PiazzaMainController

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
    [self configUI];
    [self configNav];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self configRewardListData];
    [self configData:true showHud:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessRefreshData) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccessRefreshData) name:@"LogoutSuccess" object:nil];
}


-(void)loginSuccessRefreshData{
    _page = 0;
    [self configData:true showHud:true];
}

-(void)logoutSuccessRefreshData{
    _page = 0;
    [self configData:true showHud:true];
}

-(void)configData:(BOOL)clear showHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community?page=%ld&limit=10",(long)_page] params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
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

-(void)configRewardListData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"community/rewardList" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _rewardListArr = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"reward"] && [[objectDic objectForKey:@"reward"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objectDic objectForKey:@"reward"];
                    for (NSDictionary *d in arr) {
                        RewardListData *item = [RewardListData dataForDictionary:d];
                        [_rewardListArr addObject:item];
                    }
                }
                [self scrollLableHandle];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)scrollLableHandle{
    if (_rewardListArr.count == 0) {
        return;
    }
    if (_flashLable) {
        [_flashLable removeFromSuperview];
    }
    NSMutableArray *textArr = [NSMutableArray array];
    NSMutableArray *beeArr = [NSMutableArray array];
    for (RewardListData *item in _rewardListArr) {
        [textArr addObject:item.showContent];
        [beeArr addObject:item.rewarCount];
    }
    _flashLable = [[YFRollingLabel alloc]initWithFrame:CGRectMake(FitWith(80.0), 0, mainScreenWidth - FitWith(40.0) - FitWith(120.0) , FitHeight(62.0)) textArray:textArr font:CUSNEwFONT(12) textColor:[UIColor colorFromHex:0x222222]];
    
    _flashLable.speed = 1;
    _flashLable.beeCountArr = beeArr;
    [_flashLable setOrientation:RollingOrientationLeft];
    [_flashLable setInternalWidth:_flashLable.frame.size.width / 3];;
    
    __weak typeof(self) weakSelf = self;
    _flashLable.labelClickBlock = ^(NSInteger index){
        RewardListData *item = weakSelf.rewardListArr[index];
        PiazzaDetailsController *detailsVC = [[PiazzaDetailsController alloc]initWithCommunityId:item.communityId];
        detailsVC.hidesBottomBarWhenPushed = true;
        [weakSelf.navigationController pushViewController:detailsVC animated:true];
    };
    [_fiashBgView addSubview:_flashLable];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xffffff];
    
    _fiashBgView = [[UIView alloc]initWithFrame:CGRectMake(FitWith(20.0), 64 + 3, mainScreenWidth - FitWith(40.0), FitHeight(62.0))];
    _fiashBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_fiashBgView];
    
    UIImageView *notifyImgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(40.0), FitHeight(20.0), FitWith(28.0), FitHeight(22.0))];
    notifyImgV.image = [UIImage imageNamed:@"piazza_nitify"];
    [_fiashBgView addSubview:notifyImgV];
    
    CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc]init];
    layout.columnMargin = FitWith(30.0);
    layout.rowMargin = FitHeight(20.0);
    layout.columnsCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(-FitHeight(20.0), FitWith(20.0), 0, FitWith(20.0));
    layout.delegate = self;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, _fiashBgView.frame.origin.y + _fiashBgView.frame.size.height + FitHeight(16.0), mainScreenWidth, mainScreenHeight - 64 - 50 - FitHeight(80.0)) collectionViewLayout:layout];
    [_collectionView registerClass:[PiazzaContentItemCell class] forCellWithReuseIdentifier:@"PiazzaContentItemCellIdentifier"];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = false;
    _collectionView.showsHorizontalScrollIndicator = false;
    _collectionView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        [self configRewardListData];
        _page = 0;
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

-(void)configNav{
    
    _navView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.userInteractionEnabled = true;
    _navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navView];
    
    UIButton *centerSearchButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 26, mainScreenWidth - 44 - 20, 31)];
    centerSearchButton.backgroundColor = [UIColor colorFromHex:0xf5f5f5];
    [centerSearchButton addTarget:self action:@selector(progressClassificationCenterSearchButton) forControlEvents:UIControlEventTouchUpInside];
    centerSearchButton.layer.cornerRadius = 16;
    centerSearchButton.layer.masksToBounds = true;
    [_navView addSubview:centerSearchButton];
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 9, 13, 13)];
    leftView.image = [UIImage imageNamed:@"home_nav_search"];
    leftView.contentMode = UIViewContentModeScaleAspectFill;
    [centerSearchButton addSubview:leftView];
    
    _tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(37, 0, FitWith(300.0), 31)];
    _tipsLable.textColor = [UIColor colorFromHex:0x808080];
    _tipsLable.text = @"搜索文章、作者";
    _tipsLable.font = [UIFont systemFontOfSize:13];
    _tipsLable.textAlignment = NSTextAlignmentLeft;
    [centerSearchButton addSubview:_tipsLable];
    
    _uploadBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    _uploadBtn.titleLabel.font = CUSFONT(10);
    _uploadBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, -15, 0);
    [_uploadBtn setImage:[UIImage imageNamed:@"piazza_nav_uplaod"] forState:UIControlStateNormal];
    _uploadBtn.contentMode = UIViewContentModeCenter;
    [_uploadBtn addTarget:self action:@selector(uploadBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_navView addSubview:_uploadBtn];
}

-(void)progressClassificationCenterSearchButton{
    PiazzaSearchController *searchVC = [[PiazzaSearchController alloc]init];
    searchVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:searchVC animated:true];
}

-(void)uploadBtnAction{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    PiazzaPublishController *publishVC = [[PiazzaPublishController alloc]init];
    publishVC.hidesBottomBarWhenPushed = true;
    publishVC.uploadSuccessHandle = ^{
        //首页最新提交不需要刷新
//        [self configData:true];
    };
    [self.navigationController pushViewController:publishVC animated:true];
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
    
//    CGRect originalRec;
//    UIImageView *imageView = nil;
//    PiazzaContentItemCell *firstCell = (PiazzaContentItemCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    originalRec = [firstCell.cover convertRect:firstCell.cover.frame toView:self.view];
//    imageView = firstCell.cover;
    
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

#pragma mark - 点赞
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

@end
