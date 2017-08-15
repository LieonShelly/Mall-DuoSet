//
//  SeckillProductListController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillProductListController.h"
#import "SeckillHeaderView.h"
#import "SeckillListTableView.h"
#import "RobSessionData.h"
#import "RobProductData.h"
#import "HomeTopBanner.h"
#import <EventKit/EventKit.h>
#import "FFCalendarReminderTool.h"
#import "SeckillRemindListController.h"
#import "SingleProductNewController.h"
#import "SubjectDetailController.h"
#import "ScreenProductController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"

@interface SeckillProductListController ()<UIScrollViewDelegate>

@property(nonatomic,strong) SeckillHeaderView *heardView;
@property(nonatomic,strong) NSMutableArray *robSessionDataArr;
@property(nonatomic,strong) UIScrollView *bgScrollView;
@property(nonatomic,strong) NSMutableArray *tableViews;
@property(nonatomic,assign) NSInteger currentIndex;
//所有列表的数组
@property(nonatomic,strong) NSMutableArray *allProductsArr;
//所有列表的page
@property(nonatomic,strong) NSMutableArray *allPageArr;
//所有列表上次请求回来的数据个数
@property(nonatomic,strong) NSMutableArray *allLastRequsetCountArr;
//
@property(nonatomic,strong) NSMutableArray *allTopBannerArr;
@property(nonatomic,retain) dispatch_source_t timer;
@property(nonatomic,copy) NSString *systemTime;

@end

@implementation SeckillProductListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"哆集秒杀";
    _currentIndex = 0;
    [self configUI];
    [self configRobSessions];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadSeckillData) name:@"ApplicationWillEnterForegroundNotify" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    dispatch_source_cancel(_timer);
    _timer = nil;
}

-(void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *remend = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [remend setImage:[UIImage imageNamed:@"seckill_nav_remend"] forState:UIControlStateNormal];
    [remend addTarget:self action:@selector(navRemend) forControlEvents:UIControlEventTouchUpInside];
    remend.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    UIBarButtonItem *remendBtn = [[UIBarButtonItem alloc]initWithCustomView:remend];
    self.navigationItem.rightBarButtonItem  = remendBtn;
    
    _heardView = [[SeckillHeaderView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(102.0))];
    __weak typeof(self) weakSelf = self;
    _heardView.btnViewHandle = ^(NSInteger index) {
        _currentIndex = index;
        [weakSelf.bgScrollView setContentOffset:CGPointMake(mainScreenWidth * index, 0) animated:true];
        [weakSelf configDataWithCurrentIndex:index andClearData:true];
    };
    [self.view addSubview:_heardView];
    
    _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _heardView.frame.origin.y + _heardView.frame.size.height, mainScreenWidth, mainScreenHeight - 64 - FitHeight(102.0))];
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.delegate = self;
    _bgScrollView.showsHorizontalScrollIndicator = false;
    [self.view addSubview:_bgScrollView];
}

-(void)configRobSessions{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/rob/rob-session" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _robSessionDataArr = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"robSessions"] && [[objDic objectForKey:@"robSessions"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"robSessions"];
                    _allProductsArr = [NSMutableArray array];
                    _allPageArr = [NSMutableArray array];
                    _allLastRequsetCountArr = [NSMutableArray array];
                    _allTopBannerArr = [NSMutableArray array];
                    for (NSDictionary *d in arr) {
                        RobSessionData *item = [RobSessionData dataForDictionary:d];
                        [_robSessionDataArr addObject:item];
                        //插入对应的空列表数组
                        NSMutableArray *emptyarr = [NSMutableArray array];
                        [_allProductsArr addObject:emptyarr];
                        //插入page
                        [_allPageArr addObject:@"0"];
                        //插入LastRequsetCount
                        [_allLastRequsetCountArr addObject:@"0"];
                        //插入对应的广告图数组
                        NSMutableArray *bannerEmptyarr = [NSMutableArray array];
                        [_allTopBannerArr addObject:bannerEmptyarr];
                    }
                }
                if (_robSessionDataArr.count > 0) {
                    RobSessionData *item = _robSessionDataArr[0];
                    if (item.countDown.length > 0) {
                        _systemTime = item.countDown;
                        [self handleSystime];
                    }
                }
                [_heardView setupInfoWithRobSessionDataArr:_robSessionDataArr];
                [self configTableViews];
                [self configDataWithCurrentIndex:_currentIndex andClearData:true];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

//处理倒计时 防止cell重用导致的倒计时混乱
-(void)handleSystime{
    if (_timer == nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            long long int nowSec = _systemTime.longLongValue;
            nowSec -= 1000;
            if (nowSec <= 1000) {
                dispatch_source_cancel(_timer);
                _timer = nil;
                _currentIndex = 0;
                [_bgScrollView setContentOffset:CGPointMake(0, 0) animated:true];
                [self configRobSessions];
            }
            _systemTime = [NSString stringWithFormat:@"%lld",nowSec];
            RobSessionData *item = _robSessionDataArr[0];
            item.countDown = _systemTime;
        });
        dispatch_resume(_timer);
    }
}

-(void)configTableViews{
    if (_tableViews.count > 0) {
        for (SeckillListTableView *tableView in _tableViews) {
            [tableView removeFromSuperview];
        }
        [_tableViews removeAllObjects];
    }
    _bgScrollView.contentSize = CGSizeMake(mainScreenWidth * _robSessionDataArr.count, 0);
    _tableViews = [NSMutableArray array];
    for (int i = 0; i < _robSessionDataArr.count; i++) {
        SeckillListTableView *tableView = [SeckillListTableView contentTableViewWithFrame:CGRectMake(mainScreenWidth * i, 0, mainScreenWidth, mainScreenHeight - 64 - FitHeight(102.0)) AndHeaderRefreshBlock:^{
            NSString *page = @"0";
            [_allPageArr replaceObjectAtIndex:_currentIndex withObject:page];
            [self configDataWithCurrentIndex:_currentIndex andClearData:true];
        } footRefreshBlock:^{
            NSString *lastCount = _allLastRequsetCountArr[_currentIndex];
            if (lastCount.integerValue < 10) {
                SeckillListTableView *table = _tableViews[_currentIndex];
                [table.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            NSString *page = _allPageArr[_currentIndex];
            NSString *newPage = [NSString stringWithFormat:@"%ld",page.integerValue + 1];
            [_allPageArr replaceObjectAtIndex:_currentIndex withObject:newPage];
            [self configDataWithCurrentIndex:_currentIndex andClearData:false];
        }];
        tableView.tag = i;
        __weak typeof(SeckillListTableView *) weakTableView = tableView;
        tableView.btnAction = ^(NSInteger index) {
            [self handleTableView:weakTableView.tag andBtnIndex:index];
        };
        tableView.cellSeletcedHandle = ^(NSIndexPath *indexPath) {
            [self handleTableView:weakTableView.tag andCellIndexPath:indexPath];
        };
        tableView.bannerTapHandle = ^(NSInteger index) {
            [self handleTableView:weakTableView.tag andBannerIndex:index];
        };
        [_bgScrollView addSubview:tableView];
        [_tableViews addObject:tableView];
        [tableView setupInfoWithRobSessionData:_robSessionDataArr[i]];
    }
}

-(void)configDataWithCurrentIndex:(NSInteger)index andClearData:(BOOL)clear{
    if (_robSessionDataArr.count == 0) {
        return;
    }
    RobSessionData *item = _robSessionDataArr[_currentIndex];
    NSString *page = _allPageArr[_currentIndex];
    NSString *urlStr = [NSString stringWithFormat:@"product/rob/new?robSession=%@&limit=10&page=%@&isCurrentDay=%@",item.robSession,page,item.isCurrentDay];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            SeckillListTableView *table = _tableViews[_currentIndex];
            [table.mj_header endRefreshing];
            [table.mj_footer endRefreshing];
            NSMutableArray *productListArr = _allProductsArr[index];
            NSMutableArray *topBannerArr = _allTopBannerArr[index];
            if (clear) {
                [productListArr removeAllObjects];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"robResponses"] && [[objDic objectForKey:@"robResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"robResponses"];
                    NSString *lastCount = [NSString stringWithFormat:@"%ld",arr.count];
                    [_allLastRequsetCountArr replaceObjectAtIndex:index withObject:lastCount];
                    for (NSDictionary *d in arr) {
                        RobProductData *item = [RobProductData dataForDictionary:d];
                        [productListArr addObject:item];
                    }
                    [_allProductsArr replaceObjectAtIndex:index withObject:productListArr];
                }
                if ([objDic objectForKey:@"robTopBanners"] && [[objDic objectForKey:@"robTopBanners"] isKindOfClass:[NSArray class]]) {
                    topBannerArr = [NSMutableArray array];
                    NSArray *arr = [objDic objectForKey:@"robTopBanners"];
                    for (NSDictionary *d in arr) {
                        HomeTopBanner *item = [HomeTopBanner dataForDictionary:d];
                        [topBannerArr addObject:item];
                    }
                    [_allTopBannerArr replaceObjectAtIndex:index withObject:topBannerArr];
                }
                if ([objDic objectForKey:@"robSessionResponse"] && [[objDic objectForKey:@"robSessionResponse"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *robSessionResponseDic = [objDic objectForKey:@"robSessionResponse"];
                    RobSessionData *item = [RobSessionData dataForDictionary:robSessionResponseDic];
                    [_robSessionDataArr replaceObjectAtIndex:index withObject:item];
                    
                }
                SeckillListTableView *tableView = (SeckillListTableView *)_tableViews[index];
//                RobSessionData *session = _robSessionDataArr[index];
//                [tableView setupInfoWithRobSessionData:session];
                [tableView setupInfoWithRobProductDataArr:productListArr];
                //配置banner图
                [tableView setupInfoWithTopBannerArr:topBannerArr];
            }
        }
    } fail:^(NSError *error) {
        SeckillListTableView *table = _tableViews[_currentIndex];
        [table.mj_header endRefreshing];
        [table.mj_footer endRefreshing];
    }];
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ mainScreenWidth;
    _currentIndex = index;
    [self configDataWithCurrentIndex:_currentIndex andClearData:true];
    [_heardView setupSeletcedWithIndex:_currentIndex];
}

#pragma mark - 按钮点击
-(void)handleTableView:(NSInteger)tableIndex andCellIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *productArr = _allProductsArr[tableIndex];
    RobProductData *item = productArr[indexPath.row];
    SingleProductNewController *singleVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.curDetailResponse.price];
    singleVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleVC animated:true];
}

-(void)handleTableView:(NSInteger)tableIndex andBannerIndex:(NSInteger)index{
    NSMutableArray *bannerArr = _allTopBannerArr[tableIndex];
    HomeTopBanner *banner = bannerArr[index];
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

-(void)handleTableView:(NSInteger)tableIndex andBtnIndex:(NSInteger)btnIndex{
    NSMutableArray *productArr = _allProductsArr[tableIndex];
    RobProductData *item = productArr[btnIndex];
    RobSessionData *session = _robSessionDataArr[tableIndex];
    if (session.isInRob) {//是秒杀
        SingleProductNewController *singleVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber];
        singleVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:singleVC animated:true];
    }else{
        if (![self checkLogin]) {
            [self userlogin];
            return;
        }
        if (item.isRemind) {
            [self cancelRemindWithRobProductData:item andTableIndex:tableIndex];
        }else{
            [self saveRemindWithRobSessionData:session andRobProductData:item andTableIndex:tableIndex];
        }
        
    }
}

-(void)navRemend{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    SeckillRemindListController *remindVC = [[SeckillRemindListController alloc]init];
    remindVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:remindVC animated:true];
}

//添加到系统日历增加提醒
-(void)saveRemindWithRobSessionData:(RobSessionData *)item andRobProductData:(RobProductData *)product andTableIndex:(NSInteger)tableIndex{
    NSDate *beginDate = [NSString dateDateStr:product.sessionStartTime FormateDateStr:nil];
    long long endDateStr = product.sessionStartTime.longLongValue + 1800000;
    NSDate *endDate = [NSString dateDateStr:[NSString stringWithFormat:@"%lld",endDateStr] FormateDateStr:nil];
    
    [FFCalendarReminderTool saveEventWithTitle:@"哆集：定阅商品即将抢购" notes:@"" location:nil
 startDate:beginDate endDate:endDate alarms:@[[EKAlarm alarmWithRelativeOffset:-180.0f]] URL:nil availability:EKEventAvailabilityNotSupported successBlock:^(NSString *eventIdentifier) {
     //上传服务器
     NSMutableDictionary *params = [NSMutableDictionary dictionary];
     [params setObject:eventIdentifier forKey:@"code"];
     [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"product/rob/%@/remind",product.curDetailResponse.robId] params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
         NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
         if ([resultCode isEqualToString:@"ok"]) {
             [self configDataWithCurrentIndex:_currentIndex andClearData:true];
             [MQToast showToast:@"将在开抢前3分钟提醒您，可在'我的提醒'中查看" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
             [self configDataWithCurrentIndex:tableIndex andClearData:true];
         }
     } fail:^(NSError *error) {
         //
     }];
        } failBlock:^(NSError *err) {
     //
    }];
}

-(void)cancelRemindWithRobProductData:(RobProductData *)product andTableIndex:(NSInteger)tableIndex{
    [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"product/rob/%@/remind?cancel",product.curDetailResponse.robId] params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [self configDataWithCurrentIndex:_currentIndex andClearData:true];
            [MQToast showToast:@"取消成功，您可能会错过这个心仪的商品哦" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        }
    } fail:^(NSError *error) {
        //
    }];
    [FFCalendarReminderTool deleteReminderWithIdentifer:product.remindCode];
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

-(void)reloadSeckillData{
    [self configRobSessions];
}

@end
