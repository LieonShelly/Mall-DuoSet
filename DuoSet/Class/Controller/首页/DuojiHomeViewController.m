//
//  DuojiHomeViewController.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiHomeViewController.h"
//Views
#import "ActivityCell.h"
#import "HomeHeaderView.h"
#import "HomeSeckillCell.h"
#import "CommonTitleImageCell.h"
#import "CommonAdCell.h"
#import "HomeDressUpCell.h"
#import "CommonRecommendForYouCell.h"
#import "HomeFullPicCell.h"
#import "HomeFashionCell.h"
#import "HomeMatchNewCell.h"
#import "NetWorkFailView.h"
//Controllers
#import "DesigningController.h"
#import "GlobalBuyController.h"
#import "TadayBargainPriceController.h"
#import "SingleProductNewController.h"
#import "ScreenProductController.h"
#import "HomeDressUpStyleOneCell.h"
#import "ScreenProductController.h"
#import "SubjectDetailController.h"
#import "GarmentMatchDetailsController.h"
#import "HaveGoodProductController.h"
#import "SeckillProductListController.h"
#import "ProductForListData.h"
#import "MustBuyListController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "MQChatViewManager.h"
#import "SpecialPerformanceController.h"

//data
#import "HomeMainData.h"
#import "RecommendListData.h"
#import "SeckillData.h"
#import "TopNewVersion.h"
#import "RobSessionData.h"
#import "RobProductData.h"

@interface DuojiHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UIImageView *navBackImgView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) HomeHeaderView *headerView;

@property (nonatomic,strong) UIImageView *navView;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *searchButton;
@property (nonatomic,strong) UIButton *rightMessageCenterButton;
@property (nonatomic,strong) UIView *navline;
@property (nonatomic,strong) UILabel *hotWordLable;

@property (nonatomic,strong) UIView *srcrollToTopView;
@property (nonatomic,strong) CommonDefeatedView *defeatedView;
@property (nonatomic,strong) UIView *unredView;

@property (nonatomic,strong) HomeMainData *homeData;
@property (nonatomic,copy)   NSString *recommendIconStr;
@property (nonatomic,strong) NSMutableArray *recommendArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,strong) SeckillData *seckillData;
@property (nonatomic,strong) TopNewVersion *versionData;
//秒杀
@property (nonatomic,strong) NSMutableArray *robSessionArr;
@property (nonatomic,strong) RobSessionData *robSession;
@property (nonatomic,strong) NSMutableArray *RobProductArr;
@property(nonatomic,retain) dispatch_source_t timer;

@end

@implementation DuojiHomeViewController

#pragma mark - viewWillAppear & viewWillDisappear & viewDidLoad
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getHotWordData];
    [self getSeckillDataShowHud:false];
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
    [self configUI];
    [self configNavView];
    _recommendArr = [NSMutableArray array];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self getHomePageData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkFailHandle) name:@"netWorkFailNotify" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSeckillData) name:@"ApplicationWillEnterForegroundNotify" object:nil];
}

-(void)getHomePageData{
    [self configDataShowHud:true];
    [self configRecommendDataClear:true showHud:true];
    [self getSeckillDataShowHud:true];
    if ([self checkLogin]) {
        [self getSopCartNumber];
    }
    [self getHotWordData];
    [self checkAppVersion];
    
}

#pragma mark - configData(首页) & configRecommendData(为你推荐) & 秒杀 & 热词 & 版本检查 & 购物车未付款数量
//获取首页数据
-(void)configDataShowHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:@"homepage" params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [self showDefeatedView:false];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                _homeData = [HomeMainData dataForDictionary:objectDic];
            }
            [_headerView setupInfoWithHomeMainData:_homeData];
            [_tableView reloadData];
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}

- (void)getSeckillDataShowHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/rob/rob-session" params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                _robSessionArr = [NSMutableArray array];
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"robSessions"] && [[objDic objectForKey:@"robSessions"] isKindOfClass:[NSArray class]]) {
                    NSArray *robSessionsArr = [objDic objectForKey:@"robSessions"];
                    for (NSDictionary *d in robSessionsArr) {
                        RobSessionData *robSession = [RobSessionData dataForDictionary:d];
                        [_robSessionArr addObject:robSession];
                        if (robSession.isInRob) {
                            _robSession = robSession;
                        }
                    }
                    if (_robSession) {
                        if (_robSession.countDown.length > 0) {
                            [self handleSystime];
                        }
                        [self getSeckillDataArrWithRobSessionId:_robSession.robSession];
                    }
                }
            }
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
    return;
}

//处理倒计时 防止cell重用导致的倒计时混乱
-(void)handleSystime{
    if (_timer != nil) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            long long int nowSec = _robSession.countDown.longLongValue;
            nowSec -= 1000;
            if (nowSec <= 1000) {
                dispatch_source_cancel(_timer);
                _timer = nil;
                [self getSeckillDataShowHud:false];
            }
            _robSession.countDown = [NSString stringWithFormat:@"%lld",nowSec];
        });
        dispatch_resume(_timer);
    }
}

-(void)getSeckillDataArrWithRobSessionId:(NSString *)robSessionId{
    NSString *urlStr = [NSString stringWithFormat:@"product/rob/new?robSession=%@&limit=10&page=0",robSessionId];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _RobProductArr = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"robResponses"] && [[objDic objectForKey:@"robResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *robResponsesArr = [objDic objectForKey:@"robResponses"];
                    for (NSDictionary *d in robResponsesArr) {
                        RobProductData *item = [RobProductData dataForDictionary:d];
                        [_RobProductArr addObject:item];
                    }
                }
            }
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

//获取推荐商品
-(void)configRecommendDataClear:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"homepage/0/recommend?page=%ld&limit=%ld",(long)_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if (clear) {
                _recommendArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"productResponses"] && [[objDic objectForKey:@"productResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *productArr = [objDic objectForKey:@"productResponses"];
                    _lastRequsetCount = productArr.count;
                    for (NSDictionary *d in productArr) {
                        ProductForListData *item = [ProductForListData dataForDictionary:d];
                        [_recommendArr addObject:item];
                    }
                    [_tableView reloadData];
                }
                if ([objDic objectForKey:@"adResponse"] && [[objDic objectForKey:@"adResponse"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *adDic = [objDic objectForKey:@"adResponse"];
                    _recommendIconStr = [adDic objectForKey:@"titleIcon"] != nil ? [NSString stringWithFormat:@"%@%@",BaseImgUrl,[adDic objectForKey:@"titleIcon"]] : @"";
                }
            }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}

-(void)getSopCartNumber{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/cart/count" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"count"]) {//_footView
                    NSString *count = [objDic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"count"]] : @"0";
                    if (count.integerValue > 0) {
                        NSArray *tabBarItems = self.navigationController.tabBarController.tabBar.items;
                        UITabBarItem *shopCartItem = [tabBarItems objectAtIndex:3];
                        shopCartItem.badgeValue = count.integerValue > 99 ? @"99+" : count;
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

-(void)checkAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *urlStr = [NSString stringWithFormat:@"homepage/app-version?deviceType=ios&currentVersion=%@",app_Version];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] &&[[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]] ) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"status"]) {
                    NSString *statusStr = [objDic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"status"]] : @"0";
                    if (statusStr.integerValue == 1) {
                        if ([objDic objectForKey:@"topNewVersion"] &&[[objDic objectForKey:@"topNewVersion"] isKindOfClass:[NSDictionary class]] ) {
                            NSDictionary *versionDic = [objDic objectForKey:@"topNewVersion"];
                            _versionData = [TopNewVersion dataForDictionary:versionDic];
                            [self handleVersionWithTopNewVersionData:_versionData];
                        }
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - configUI
-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, mainScreenWidth, mainScreenHeight + 20 - 50) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        [self configDataShowHud:false];
        [self getSeckillDataShowHud:false];
        _page = 0;
        _lastRequsetCount = 0;
        [self configRecommendDataClear:true showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configRecommendDataClear:false showHud:false];
    }];
    
    [self.view addSubview:_tableView];
    
    _headerView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(760.0))];
    __weak typeof(self) weakSelf = self;
    _headerView.bannerHandle = ^(NSInteger index){
        [weakSelf homeBannerClickWithIndex:index];
    };
    _headerView.adTapHandle = ^(){
        [weakSelf headerViewAdTapAction];
    };
    _headerView.classChickHandle = ^(NSInteger index){
        [weakSelf headerViewClassClickActionWithIndex:index];
    };
    _tableView.tableHeaderView = _headerView;
    
    UIImage *img = [UIImage imageNamed:@"home_footLine"];
    UIImageView *footLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - img.size.height - 42, mainScreenWidth, img.size.height)];
    footLineView.image = [UIImage imageNamed:@"home_footLine"];
    [self.view addSubview:footLineView];
    
    _srcrollToTopView = [[UIView alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(100.0) - FitWith(40.0), mainScreenHeight - 50 - FitWith(120.0), FitWith(100.0), FitWith(100.0))];
    [self.view addSubview:_srcrollToTopView];
    _srcrollToTopView.layer.borderColor = [UIColor colorFromHex:0xe5e5e5].CGColor;
    _srcrollToTopView.layer.borderWidth = 1;
    _srcrollToTopView.layer.cornerRadius = FitWith(100.0) * 0.5;
    _srcrollToTopView.layer.masksToBounds = true;
    _srcrollToTopView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollToTopAction)];
    [_srcrollToTopView addGestureRecognizer:tap];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc]initWithEffect:blur];
    blurView.frame = CGRectMake(0, 0, FitWith(100.0), FitWith(100.0));
    [_srcrollToTopView addSubview:blurView];
    
    UIImageView *totopImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FitWith(100.0), FitWith(100.0))];
    totopImgV.image = [UIImage imageNamed:@"home_scroll_top"];
    totopImgV.contentMode = UIViewContentModeCenter;
    [_srcrollToTopView addSubview:totopImgV];
    _srcrollToTopView.hidden = true;
}

-(void)configNavView{
    _navView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.image = [UIImage imageNamed:@"home_nav_bgImage"];
    _navView.userInteractionEnabled = true;
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    _leftBtn.titleLabel.font = CUSFONT(10);
    [_leftBtn setTitle:@"签到" forState:UIControlStateNormal];
    _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, -15, 0);
    _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -30);
    [_leftBtn setImage:[UIImage imageNamed:@"home_nav_sgin"] forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_leftBtn];
    
     _searchButton = [[UIButton alloc]initWithFrame:CGRectMake(44, 26, mainScreenWidth - 44 - 44, 31)];
    _searchButton.backgroundColor = [UIColor whiteColor];
    _searchButton.layer.cornerRadius = 16;
    _searchButton.layer.masksToBounds = true;
    [_searchButton addTarget:self action:@selector(progressClassificationsearchButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_searchButton];
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 9, 13, 13)];
    leftView.image = [UIImage imageNamed:@"home_nav_search"];
    leftView.contentMode = UIViewContentModeScaleAspectFill;
    [_searchButton addSubview:leftView];
    
    _hotWordLable = [[UILabel alloc]initWithFrame:CGRectMake(37, 0, FitWith(300.0), 31)];
    _hotWordLable.textColor = [UIColor colorFromHex:0x808080];
    _hotWordLable.font = [UIFont systemFontOfSize:13];
    _hotWordLable.textAlignment = NSTextAlignmentLeft;
    [_searchButton addSubview:_hotWordLable];
    
    _rightMessageCenterButton = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    _rightMessageCenterButton.titleLabel.font = CUSFONT(10);
    _rightMessageCenterButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, -15, 0);
    _rightMessageCenterButton.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -30);
    [_rightMessageCenterButton setTitle:@"消息" forState:UIControlStateNormal];
    [_rightMessageCenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightMessageCenterButton setImage:[UIImage imageNamed:@"home_nav_message_01"] forState:UIControlStateNormal];
    [_rightMessageCenterButton addTarget:self action:@selector(progressRightMessageCenterButton) forControlEvents:UIControlEventTouchUpInside];
    _rightMessageCenterButton.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_rightMessageCenterButton];
    
    //未读消息提醒标识
    _unredView = [[UIView alloc]initWithFrame:CGRectMake(30, 5, 8, 8)];
    _unredView.backgroundColor = [UIColor mainColor];
    _unredView.layer.masksToBounds = true;
    _unredView.layer.cornerRadius = 4;
    _unredView.hidden = true;
    [_rightMessageCenterButton addSubview:_unredView];
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
    [_navView addSubview:_navline];
    
    [self.view bringSubviewToFront:_navView];
}

#pragma mark - UItableViewDataSource & Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {//秒杀
        if (_RobProductArr.count == 0){
            return 0;
        }
        return 1;
    }
    if (section == 1) {//有好货
        return 1;
    }
    if (section == 2) {//必买清单
        return 1;
    }
    if (section == 3) {//流行时尚专区
        return 1;
    }
    if (section == 4) {//穿搭课堂
        return 1;
    }
    if (section == 5) {//各种专题
        return _homeData.appSpecialIcons.count;
    }
    if (section == 6) {//推荐商品
        return _recommendArr == nil ? 1 : 2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//秒杀
        static NSString *HomeSeckillCellID = @"HomeSeckillCellID";
        HomeSeckillCell * cell = [_tableView dequeueReusableCellWithIdentifier:HomeSeckillCellID];
        if (cell == nil) {
            cell = [[HomeSeckillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeSeckillCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        [cell setupInfoWithRobSessionData:_robSession andRobProductDataArr:_RobProductArr showCutDown:_robSessionArr.count > 1];
        cell.singleItemTapHandle = ^(NSInteger index){
            [weakSelf singleSeckillItemClickActionWithIndex:index];
        };
        return cell;
    }
    if (indexPath.section == 1) {//有好货
        static NSString *HomeFullPicCell_notFull = @"HomeFullPicCell_notFull";
        HomeFullPicCell * cell = [_tableView dequeueReusableCellWithIdentifier:HomeFullPicCell_notFull];
        if (cell == nil) {
            cell = [[HomeFullPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeFullPicCell_notFull isFull:false];
        }
        [cell setupInfoWithTitleImageUrlStr:_homeData.homePageGoodsProductTitleIcon andCoverUrlStr:_homeData.homePageGoodsProductCover];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {//必买清单
        static NSString *HomeFullPicCell_notFull = @"HomeFullPicCell_notFull";
        HomeFullPicCell * cell = [_tableView dequeueReusableCellWithIdentifier:HomeFullPicCell_notFull];
        if (cell == nil) {
            cell = [[HomeFullPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeFullPicCell_notFull isFull:false];
        }
        [cell setupInfoWithTitleImageUrlStr:_homeData.homePageMustShopProductTitleIcon andCoverUrlStr:_homeData.homePageMustShopProductCover];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 3) {//流行时尚专区
        static NSString *HomeFashionCellID = @"HomeFashionCellID";
        HomeFashionCell * cell = [_tableView dequeueReusableCellWithIdentifier:HomeFashionCellID];
        if (cell == nil) {
            cell = [[HomeFashionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeFashionCellID];
        }
        [cell setupInfoWithHomeMainData:_homeData];
        cell.imgVTapHandle = ^(NSInteger index) {
            [self nowHotSellProDuctActionWithIndex:index];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 4) {//穿搭课堂
        static NSString *HomeMatchNewCellID = @"HomeMatchNewCellID";
        HomeMatchNewCell * cell = [_tableView dequeueReusableCellWithIdentifier:HomeMatchNewCellID];
        if (cell == nil) {
            cell = [[HomeMatchNewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeMatchNewCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_homeData.matchList.count > 0) {
            HomeMatchData *item = _homeData.matchList[0];
            [cell SetupInfoWithHomeMatchData:item];
        }
        cell.imgVTapHandle = ^(NSInteger index) {
            [self dressUpClassItemWithIndex:index];
        };
        return cell;
    }
    if (indexPath.section == 5) {//各种专场
        static NSString *HomeFullPicCell_isFull = @"HomeFullPicCell_isFull";
        HomeFullPicCell * cell = [_tableView dequeueReusableCellWithIdentifier:HomeFullPicCell_isFull];
        if (cell == nil) {
            cell = [[HomeFullPicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HomeFullPicCell_isFull isFull:true];
        }
        AppSpecialIconData *item = _homeData.appSpecialIcons[indexPath.row];
        [cell setupInfoWithAppSpecialIconData:item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 6) {//为你推荐
        if (indexPath.row == 0) {
            static NSString *CommonTipsCellID = @"CommonTipsCellID";
            CommonTitleImageCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommonTipsCellID];
            if (cell == nil) {
                cell = [[CommonTitleImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonTipsCellID];
            }
            if (_recommendIconStr.length > 0) {
                [cell setupInfoWithTitleImageUrlStr:_recommendIconStr];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *CommonRecommendForYouCellID = @"CommonRecommendForYouCellID";
            CommonRecommendForYouCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommonRecommendForYouCellID];
            if (cell == nil) {
                cell = [[CommonRecommendForYouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonRecommendForYouCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf = self;
            [cell setupInfoWithRecommendListDataArr:_recommendArr];
            
            cell.recommendHandle = ^(NSInteger index){
                [weakSelf RecommendForYouProductItem:index];
            };
            return cell;
        }
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//秒杀
        if (_RobProductArr.count == 0){
            return 0;
        }
        return FitHeight(390.0);
    }
    if (_homeData == nil) {
        return 0;
    }
    if (indexPath.section == 1) {//有好货
        return FitHeight(506.0);
    }
    if (indexPath.section == 2) {//必买清单
        return FitHeight(506.0);
    }
    if (indexPath.section == 3) {//时尚专区
        return FitHeight(336.0);
    }
    if (indexPath.section == 4) {//穿搭课堂
        return FitHeight(600.0);
    }
    if (indexPath.section == 5) {//各种专场
        return FitHeight(600.0);
    }
    if (indexPath.section == 6) {
        if (indexPath.row == 0) {
            return FitHeight(110.0);
        }
        if (indexPath.row == 1) {
            return (FitHeight(600.0) + 3) * ((_recommendArr.count + 1) / 2);
        }
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self seckillCellAction];
    }
    if (indexPath.section == 1) {//有好货
        HaveGoodProductController *haveGoodVC = [[HaveGoodProductController alloc]init];
        haveGoodVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:haveGoodVC animated:true];
        return;
    }
    if (indexPath.section == 2) {//必买清单
        MustBuyListController *listVC = [[MustBuyListController alloc]init];
        listVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:true];
        return;
    }
    if (indexPath.section == 3) {//时尚专区
        
    }
    if (indexPath.section == 4) {//穿搭课堂
        
    }
    if (indexPath.section == 5) {//各种专题
        AppSpecialIconData *item = _homeData.appSpecialIcons[indexPath.row];
        SpecialPerformanceController *specalVC = [[SpecialPerformanceController alloc]initWithAppSpecialIconData:item];
        specalVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:specalVC animated:true];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _navView.hidden = scrollView.contentOffset.y <= -30;
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:1];
    UIColor *textColor = [[UIColor colorFromHex:0x222222] colorWithAlphaComponent:1];
    CGFloat offset = scrollView.contentOffset.y;
    if (offset <= 0) {
        _navView.image = [UIImage imageNamed:@"home_nav_bgImage"];
        _navView.backgroundColor = [color colorWithAlphaComponent:0];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
        [_leftBtn setImage:[UIImage imageNamed:@"home_nav_sgin_white"] forState:UIControlStateNormal];
        [_rightMessageCenterButton setImage:[UIImage imageNamed:@"home_nav_message_01_white"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightMessageCenterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchButton.backgroundColor = [UIColor whiteColor];
    }else{
        _navView.image = nil;
        CGFloat alpha = 1 - ((100 - offset)/100);
        _navView.backgroundColor = [color colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:alpha];
        [_leftBtn setImage:[UIImage imageNamed:@"home_nav_sgin"] forState:UIControlStateNormal];
        [_rightMessageCenterButton setImage:[UIImage imageNamed:@"home_nav_message_01"] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:textColor forState:UIControlStateNormal];
        [_rightMessageCenterButton setTitleColor:textColor forState:UIControlStateNormal];
        _searchButton.backgroundColor = [UIColor colorFromHex:0xf5f5f5];
    }
    _srcrollToTopView.hidden = scrollView.contentOffset.y < mainScreenHeight;
}

#pragma mark - buttonAction
-(void)progressClassificationsearchButton{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:searchVC animated:true];
}

- (void)progressLeftSignInButton{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    UserInfo *info = [Utils getUserInfo];
    WebPageController *siginVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@user/sign/html?userId=%@",BaseUrl,info.userId] NavTitle:@""];
    siginVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:siginVC animated:true];
    
    
//    SignInViewController *signInVC = [[SignInViewController alloc] init];
//    signInVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:signInVC animated:true];
}

- (void)progressRightMessageCenterButton{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc] init];
    messageCenterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageCenterVC animated:true];
}

- (void)progresssearchButton{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:true];
}

//最顶部滚动图
-(void)homeBannerClickWithIndex:(NSInteger)index{
    [UMengStatisticsUtils event:@"banner_ad_event"];
    if (_homeData) {
        HomeTopBanner *banner = _homeData.homePageTopBanner[index];
        if (banner.bannerType == BannerProduct) {//跳转到商品
            SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:banner.typeValue];
            singleItemVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:singleItemVC animated:true];
        }
        if (banner.bannerType == BannerWeb) {//跳转到网站
            WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:banner.typeValue NavTitle:@""];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:true];
        }
        if (banner.bannerType == BannerSubObject) {//跳转到专题
            SubjectDetailController *subJectVC = [[SubjectDetailController alloc]initWithSubjectId:banner.typeValue];
            subJectVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subJectVC animated:true];
        }
        if (banner.bannerType == BannerClsaaify) {
            ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andclassifyLevel:banner.classifyLevel andItemId:banner.typeValue];
            listVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:listVC animated:true];
        }
    }
}

//顶部广告图
-(void)headerViewAdTapAction{
    [UMengStatisticsUtils event:@"banner_design_event"];
    DesigningController *designVC = [[DesigningController alloc] init];
    designVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:designVC animated:true];
}

//分类选择
-(void)headerViewClassClickActionWithIndex:(NSInteger)index{
    NavIconData *it = _homeData.appNavIcons[index];
    if (it.navIconStatus == AppNavIconClassification) {
        ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andItemId:it.classifyId];
        listVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:listVC animated:true];
        return;
    }
    if (it.navIconStatus == AppNavIconTodayNewItem) {//今日新品
        [UMengStatisticsUtils event:@"home_tadayBargainPrice_event"];
        TadayBargainPriceController *todayVC = [[TadayBargainPriceController alloc] init];
        todayVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:todayVC animated:true];
        return;
    }
    if (it.navIconStatus == AppNavIconDesigning) {//设计馆
        [UMengStatisticsUtils event:@"home_design_event"];
        DesigningController *designVC = [[DesigningController alloc] init];
        designVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:designVC animated:true];
        return;
    }
    if (it.navIconStatus == AppNavIconGlobalBuy) {//全球购
        [UMengStatisticsUtils event:@"home_globalBuy_event"];
        GlobalBuyController *quanqiugouVC = [[GlobalBuyController alloc] init];
        quanqiugouVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:quanqiugouVC animated:true];
        return;
    }
    if (it.navIconStatus == AppNavIconService) {//客服中心
        if (![self checkLogin]) {
            [self userlogin];
            return;
        }
        [self chatWithServer];
        return;
    }
}

//秒杀列表
-(void)seckillCellAction{
    SeckillProductListController *seckillVC = [[SeckillProductListController alloc]init];
    seckillVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:seckillVC animated:true];
    
//    SeckillBasicListController *duoSetSecondsKillVC = [[SeckillBasicListController alloc] init];
//    duoSetSecondsKillVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:duoSetSecondsKillVC animated:true];
}

//秒杀单品
-(void)singleSeckillItemClickActionWithIndex:(NSInteger)index{
    if (index >= _RobProductArr.count) {
        return;
    }
    RobProductData *item = _RobProductArr[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.curDetailResponse.price];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

//流行时尚专区
-(void)nowHotSellProDuctActionWithIndex:(NSInteger)index{
    if (_homeData) {
        CurrentFashionData *currentFashion = _homeData.homePageCurrentFashion[index];
        if (currentFashion.type == BannerProduct) {//跳转到商品
            SingleProductNewController *singleItemVC = [[SingleProductNewController alloc] initWithProductId:currentFashion.typeValue];
            singleItemVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:singleItemVC animated:true];
        }
        if (currentFashion.type == BannerWeb) {//跳转到网站
            WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:currentFashion.typeValue NavTitle:@""];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:true];
        }
        if (currentFashion.type == BannerSubObject) {//跳转到专题
            SubjectDetailController *subJectVC = [[SubjectDetailController alloc]initWithSubjectId:currentFashion.typeValue];
            subJectVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subJectVC animated:true];
        }
        if (currentFashion.type == BannerClsaaify) {
            ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andclassifyLevel:currentFashion.classifyLevel andItemId:currentFashion.typeValue];
            listVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:listVC animated:true];
        }
    }
}

//穿搭课堂
-(void)dressUpClassItemWithIndex:(NSInteger)index{
    if (index <= 3) {
        if (_homeData.matchList.count < 1) {return;}
        HomeMatchData *item = _homeData.matchList[0];
        if (index == 0) {
            WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@match/%@/html",BaseUrl,item.match_id] NavTitle:@""];
            webVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:webVC animated:true];
        }
    }
}

//为你推荐
-(void)RecommendForYouProductItem:(NSInteger)index{
    ProductForListData *item = _recommendArr[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.picture productTitle:item.productName productPrice:item.price];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

-(void)progressLeftReturnButton{
    [self.navigationController popViewControllerAnimated:true];
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

-(void)scrollToTopAction{
    [_tableView setContentOffset:CGPointMake(0, 0) animated:true];
}

#pragma mark - 美洽(客服聊天)
-(void)chatWithServer{
    UserInfo *info = [Utils getUserInfo];
    if (info.token) {
        NSDictionary* clientCustomizedAttrs = @{
                                                @"name"        : info.name,
                                                @"avatar"      : [NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar],
                                                };
        [MQManager setClientInfo:clientCustomizedAttrs completion:^(BOOL success, NSError *error) {
            if (success) {
                NSLog(@"资料上传成功");
            }
        }];
    }
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    chatViewManager.chatViewStyle.incomingBubbleColor = [UIColor colorFromHex:0xffffff];
    chatViewManager.chatViewStyle.incomingMsgTextColor = [UIColor colorFromHex:0x222222];
    chatViewManager.chatViewStyle.outgoingBubbleColor = [UIColor colorFromHex:0xffffff];
    chatViewManager.chatViewStyle.outgoingMsgTextColor = [UIColor colorFromHex:0x222222];
    chatViewManager.chatViewStyle.eventTextColor = [UIColor mainColor];
    chatViewManager.chatViewStyle.navBackButtonImage = [UIImage imageNamed:@"new_nav_arrow_black"];
    chatViewManager.chatViewStyle.enableIncomingAvatar = true;
    chatViewManager.chatViewStyle.enableRoundAvatar = true;
    chatViewManager.chatViewStyle.enableOutgoingAvatar = true;
    chatViewManager.chatViewStyle.btnTextColor = [UIColor mainColor];
    chatViewManager.chatViewStyle.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    chatViewManager.chatViewStyle.navBarTintColor = [UIColor colorFromHex:0x808080];
    [chatViewManager enableSendVoiceMessage:false];
    [chatViewManager enableChatWelcome:true];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"server_right_btn"] forState:UIControlStateNormal];
    chatViewManager.chatViewStyle.navBarRightButton = btn;
    
    [chatViewManager pushMQChatViewControllerInViewController:self];
}

#pragma mark - 版本更新检查
-(void)handleVersionWithTopNewVersionData:(TopNewVersion *)versionData{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"发现新版本" message:versionData.appExplain preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *update = [UIAlertAction actionWithTitle:@"马上更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (!isDebug) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id1216153232"]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/app/id1216153232"]];
                [self presentViewController:alertController animated:true completion:nil];
            }
        }else{
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:versionData.url]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionData.url]];
            }
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:update];
    if (!versionData.forcedUpdating) {
        [alertController addAction:cancel];
    }
    [self presentViewController:alertController animated:true completion:nil];
}

//网络加载失败
-(void)netWorkFailHandle{
    [self showDefeatedView:true];
}

-(void)reloadSeckillData{
    [self getSeckillDataShowHud:true];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64 - 50) andDefeatedImageName:@"defeated_net_fail" messageName:@"请尝试再次加载或检查网络设置" backBlockBtnName:@"重新加载" backBlock:^{
                [self getHomePageData];
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
