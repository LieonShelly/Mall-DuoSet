//
//  AllOrderViewController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AllOrderViewController.h"
#import "TodayRecommendSectionView.h"
#import "DuojiOrderData.h"

#import "NewAllOrderTableView.h"
#import "NewWaittingPayTableView.h"
#import "NewWaittingReceiveTableView.h"
#import "NewDoneOrderTableView.h"
#import "NewCancelOrderTableView.h"

#import "OrderDetailViewController.h"
#import "SingleProductNewController.h"
#import "PayViewController.h"
#import "ShoppingCartViewController.h"
#import "OrderSearchController.h"
#import "UserCenterController.h"
#import "OrderCategoryController.h"

typedef enum : NSUInteger {
    OrderClassTypeAll,
    OrderClassTypeWaitPay,
    OrderClassTypeWaitReceive,
    OrderClassTypeDone,
    OrderClassTypeCancel
} OrderClassType;

@interface AllOrderViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)  UIScrollView *bgScrollView;
@property (nonatomic,strong)  TodayRecommendSectionView *headerView;
@property (nonatomic, strong) NewAllOrderTableView *allTableView;
@property (nonatomic, strong) NSMutableArray *allOrderArr;
@property (nonatomic, strong) NSMutableArray *waitCommentOrderArr;
@property (nonatomic, strong) NewWaittingPayTableView *waitPayTableView;
@property (nonatomic, strong) NSMutableArray *waitPayOrderArr;
@property (nonatomic, strong) NewWaittingReceiveTableView *waitReceiveTableView;
@property (nonatomic, strong) NSMutableArray *waitReceiveOrderArr;
@property (nonatomic, strong) NewDoneOrderTableView *doneTableView;
@property (nonatomic, strong) NSMutableArray *doneOrderArr;
@property (nonatomic, strong) NewCancelOrderTableView *cancelTableView;
@property (nonatomic, strong) NSMutableArray *cancelOrderArr;
@property (nonatomic,strong)  CommonDefeatedView *defeatedView;
@property (nonatomic,assign)  OrderClassType classtype;

//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UIButton *rightBtn;
//Data
@property (nonatomic, copy) NSString *urlStr;
//全部订单
@property (nonatomic, assign) NSInteger allOrderPage;
@property (nonatomic, assign) NSInteger allOrderLastRequsetCount;
//待付款
@property (nonatomic, assign) NSInteger waitPayPage;
@property (nonatomic, assign) NSInteger waitPayLastRequsetCount;
//待收货
@property (nonatomic, assign) NSInteger waitRecivedPage;
@property (nonatomic, assign) NSInteger waitRecivedLastRequsetCount;
//已完成
@property (nonatomic, assign) NSInteger doneOrderPage;
@property (nonatomic, assign) NSInteger doneOrderLastRequsetCount;
//已取消
@property (nonatomic, assign) NSInteger cancelOrderPage;
@property (nonatomic, assign) NSInteger cancelOrderLastRequsetCount;

@property (nonatomic, assign) NSInteger limit;

@end

@implementation AllOrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.classtype = OrderClassTypeAll;
    [self configNav];
    [self configUI];
    _classtype = OrderClassTypeAll;
    _allOrderPage = 0;
    _allOrderLastRequsetCount = 0;
    
    _waitPayPage = 0;
    _waitPayLastRequsetCount = 0;
    
    _waitRecivedPage = 0;
    _waitRecivedLastRequsetCount = 0;
    
    _doneOrderPage = 0;
    _doneOrderLastRequsetCount = 0;
    
    _cancelOrderPage = 0;
    _cancelOrderLastRequsetCount = 0;
    
    _limit = 10;
    _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld",(long)_allOrderPage,(long)_limit];
    _allOrderArr = [NSMutableArray array];
    [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:0 andClear:true showHud:true];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceedResultHandle) name:@"OrderListOrDetailPayHandle" object:nil];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftItemHandle) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_leftBtn];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.text = @"全部订单";
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_navView addSubview:_titleLable];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [_rightBtn setImage:[UIImage imageNamed:@"order_search"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(navSearch) forControlEvents:UIControlEventTouchUpInside];
//    _rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    [_navView addSubview:_rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

-(void)leftItemHandle{
    NSArray *vcArr = self.navigationController.viewControllers;
    NSMutableArray *vcshortArr = [NSMutableArray array];
    for (int i = vcArr.count - 1; i >= 0; i--) {
        UIViewController *vc = vcArr[i];
        [vcshortArr addObject:vc];
    }
    for (UIViewController *vc in vcshortArr) {
        if ([vc isKindOfClass:[OrderDetailViewController class]]) {
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
        if ([vc isKindOfClass:[OrderCategoryController class]]) {
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
        if ([vc isKindOfClass:[OrderSearchController class]]) {
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
        if ([vc isKindOfClass:[SingleProductNewController class]]) {
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
        if ([vc isKindOfClass:[ShoppingCartViewController class]]) {
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
        if ([vc isKindOfClass:[UserCenterController class]]) {
            [self.navigationController popToViewController:vc animated:true];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:true];
}

-(void)navSearch{
    OrderSearchController *searchVC = [[OrderSearchController alloc]init];
    searchVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:searchVC animated:true];
}

-(void)configUI{
    NSMutableArray *nameArr = [NSMutableArray arrayWithObjects:@"全部",@"待付款",@"待收货",@"已完成",@"已取消", nil];
    _headerView = [[TodayRecommendSectionView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(80.0)) andBtnNameArr:nameArr];
    __weak typeof(self) weakSelf = self;
    _headerView.btnActionHandle = ^(NSInteger index) {
        [weakSelf.bgScrollView setContentOffset:CGPointMake(mainScreenWidth * index, 0) animated:true];
        switch (index) {
            case 0:{
                weakSelf.classtype = OrderClassTypeAll;
                weakSelf.allOrderArr = [NSMutableArray array];
                weakSelf.allOrderPage = 0;
                weakSelf.urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld",(long)weakSelf.allOrderPage,(long)(long)weakSelf.limit];
                [weakSelf getAllOrderNetDataWithUrlStr:weakSelf.urlStr andIndex:0 andClear:true showHud:true];
            }
                break;
            case 1:{
                weakSelf.classtype = OrderClassTypeWaitPay;
                weakSelf.waitPayOrderArr = [NSMutableArray array];
                weakSelf.waitPayPage = 0;
                weakSelf.urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=0",(long)weakSelf.waitPayPage,(long)weakSelf.limit];
                [weakSelf getAllOrderNetDataWithUrlStr:weakSelf.urlStr andIndex:1 andClear:true showHud:true];
            }
                break;
            case 2:{
                weakSelf.classtype = OrderClassTypeWaitReceive;
                weakSelf.waitReceiveOrderArr = [NSMutableArray array];
                weakSelf.waitRecivedPage = 0;
                weakSelf.urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=20",(long)weakSelf.waitRecivedPage,(long)weakSelf.limit];
                [weakSelf getAllOrderNetDataWithUrlStr:weakSelf.urlStr andIndex:2 andClear:true showHud:true];
            }
                break;
            case 3:{
                weakSelf.classtype = OrderClassTypeDone;
                weakSelf.doneOrderArr = [NSMutableArray array];
                weakSelf.doneOrderPage = 0;
                _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=30",(long)weakSelf.doneOrderPage,(long)weakSelf.limit];
                [weakSelf getAllOrderNetDataWithUrlStr:weakSelf.urlStr andIndex:3 andClear:true showHud:true];
            }
                break;
            case 4:{
                weakSelf.classtype = OrderClassTypeCancel;
                weakSelf.cancelOrderArr = [NSMutableArray array];
                weakSelf.cancelOrderPage = 0;
                _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=40",(long)weakSelf.cancelOrderPage,(long)weakSelf.limit];
                [weakSelf getAllOrderNetDataWithUrlStr:weakSelf.urlStr andIndex:4 andClear:true showHud:true];
            }
                break;
                
            default:
                break;
        }
    };
    [self.view addSubview:_headerView];
    
    _bgScrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, _headerView.frame.origin.y + _headerView.frame.size.height, mainScreenWidth, mainScreenHeight - 64 - FitHeight(80.0))];
    _bgScrollView.pagingEnabled = YES;
    _bgScrollView.delegate = self;
    _bgScrollView.showsHorizontalScrollIndicator = false;
    _bgScrollView.contentSize = CGSizeMake(mainScreenWidth * 5, 0);
    [self.view addSubview:_bgScrollView];
    
    __weak typeof(self) weekSelf = self;
    //全部订单
    _allTableView = [NewAllOrderTableView contentTableViewAndHeaderRefreshBlock:^{
        _allOrderPage = 0;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld",(long)_allOrderPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:0 andClear:true showHud:false];
    } footRefreshBlock:^{
        if (_allOrderLastRequsetCount < 10) {
            [_allTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _allOrderPage += 1;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld",(long)_allOrderPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:0 andClear:false showHud:false];
    }];
    _allTableView.cellBtnAction = ^(DuojiOrderData *order,NSInteger index){
        [weekSelf handleOrderCellBtnActionWithDuojiOrderData:order andBtnTag:index];
    };
    _allTableView.cellSeletcedAction = ^(DuojiOrderData *order){
        [weekSelf handleOrderCellGotoDetailsWithDuoSetOrder:order];
    };
    _allTableView.cellProductAction =^(DuojiOrderData *order,NSInteger index){//跳转到商品详情
        [weekSelf handleOrderProductActionWithDuojiOrderData:order andIndex:index];;
    };
    _allTableView.deleteHandle = ^(DuojiOrderData *order) {
        [weakSelf handleTableViewCellDeleteHandle:order];
    };
    [_bgScrollView addSubview:_allTableView];
    
    //待付款
    _waitPayTableView = [NewWaittingPayTableView contentTableViewAndHeaderRefreshBlock:^{
        _waitPayPage = 0;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=0",(long)_waitPayPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:1 andClear:true showHud:false];
    } footRefreshBlock:^{
        if (_waitPayLastRequsetCount < 10) {
            [_waitPayTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _waitPayPage += 1;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=0",(long)_waitPayPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:1 andClear:false showHud:false];
    }];
    _waitPayTableView.cellBtnAction = ^(DuojiOrderData *order,NSInteger index){
        [weekSelf handleOrderCellBtnActionWithDuojiOrderData:order andBtnTag:index];
    };
    _waitPayTableView.productTapAction = ^(DuojiOrderData *order, NSInteger index) {
        [weekSelf handleOrderProductActionWithDuojiOrderData:order andIndex:index];
    };
    _waitPayTableView.cellSeletcedAction = ^(DuojiOrderData *order){
        [weekSelf handleOrderCellGotoDetailsWithDuoSetOrder:order];
    };
    _waitPayTableView.deleteHandle = ^(DuojiOrderData *order) {
        [weakSelf handleTableViewCellDeleteHandle:order];
    };
    [_bgScrollView addSubview:_waitPayTableView];
    
    //待收货
    _waitReceiveTableView = [NewWaittingReceiveTableView contentTableViewAndHeaderRefreshBlock:^{
        _waitRecivedPage = 0;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=20",(long)_waitRecivedPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:3 andClear:true showHud:false];
    } footRefreshBlock:^{
        if (_waitRecivedLastRequsetCount < 10) {
            [_waitReceiveTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _waitRecivedPage += 1;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=20",(long)_waitRecivedPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:3 andClear:false showHud:false];
    }];
    _waitReceiveTableView.cellBtnAction = ^(DuojiOrderData *order, NSInteger index) {
        [weekSelf handleOrderCellBtnActionWithDuojiOrderData:order andBtnTag:index];
    };
    _waitReceiveTableView.productTapAction = ^(DuojiOrderData *order, NSInteger index) {
        [weekSelf handleOrderProductActionWithDuojiOrderData:order andIndex:index];
    };
    _waitReceiveTableView.cellSeletcedAction = ^(DuojiOrderData *order){
        [weekSelf handleOrderCellGotoDetailsWithDuoSetOrder:order];
    };
    _waitReceiveTableView.deleteHandle = ^(DuojiOrderData *order) {
        [weakSelf handleTableViewCellDeleteHandle:order];
    };
    [_bgScrollView addSubview:_waitReceiveTableView];
    
    //已完成
    _doneTableView = [NewDoneOrderTableView contentTableViewAndHeaderRefreshBlock:^{
        _doneOrderPage = 0;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=30",(long)_doneOrderPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:3 andClear:true showHud:false];
    } footRefreshBlock:^{
        if (_doneOrderLastRequsetCount < 10) {
            [_doneTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _doneOrderPage += 1;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=30",(long)_doneOrderPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:3 andClear:false showHud:false];
    }];
    _doneTableView.cellSeletcedAction = ^(DuojiOrderData *order){
        [weekSelf handleOrderCellGotoDetailsWithDuoSetOrder:order];
    };
    _doneTableView.cellBtnAction = ^(DuojiOrderData *order, NSInteger index) {
        [weekSelf handleOrderCellBtnActionWithDuojiOrderData:order andBtnTag:index];
    };
    _doneTableView.productTapAction = ^(DuojiOrderData *order, NSInteger index) {
        [weekSelf handleOrderProductActionWithDuojiOrderData:order andIndex:index];
    };
    _doneTableView.deleteHandle = ^(DuojiOrderData *order) {
        [weakSelf handleTableViewCellDeleteHandle:order];
    };
    [_bgScrollView addSubview:_doneTableView];
    
    //取消
    _cancelTableView = [NewCancelOrderTableView contentTableViewAndHeaderRefreshBlock:^{
        _cancelOrderPage = 0;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=40",(long)_cancelOrderPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:4 andClear:true showHud:false];
    } footRefreshBlock:^{
        if (_cancelOrderLastRequsetCount < 10) {
            [_cancelTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _cancelOrderPage += 1;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=40",(long)_cancelOrderPage,(long)_limit];
        [weekSelf getAllOrderNetDataWithUrlStr:_urlStr andIndex:4 andClear:false showHud:false];
    }];
    _cancelTableView.cellSeletcedAction = ^(DuojiOrderData *order){
        [weekSelf handleOrderCellGotoDetailsWithDuoSetOrder:order];
    };
    _cancelTableView.cellBtnAction = ^(DuojiOrderData *order, NSInteger index) {
        [weekSelf handleOrderCellBtnActionWithDuojiOrderData:order andBtnTag:index];
    };
    _cancelTableView.productTapAction = ^(DuojiOrderData *order, NSInteger index) {
        [weekSelf handleOrderProductActionWithDuojiOrderData:order andIndex:index];
    };
    _cancelTableView.deleteHandle = ^(DuojiOrderData *order) {
        [weakSelf handleTableViewCellDeleteHandle:order];
    };
    [_bgScrollView addSubview:_cancelTableView];
}

- (void)getAllOrderNetDataWithUrlStr:(NSString *)urlStr andIndex:(NSInteger)index andClear:(BOOL)clear showHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [_allTableView.mj_header endRefreshing];
            [_allTableView.mj_footer endRefreshing];
            [_waitPayTableView.mj_header endRefreshing];
            [_waitPayTableView.mj_footer endRefreshing];
            [_waitReceiveTableView.mj_header endRefreshing];
            [_waitReceiveTableView.mj_footer endRefreshing];
            [_doneTableView.mj_header endRefreshing];
            [_doneTableView.mj_footer endRefreshing];
            [_cancelTableView.mj_header endRefreshing];
            [_cancelTableView.mj_footer endRefreshing];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [responseDic objectForKey:@"object"];
                if (clear) {
                    if (index == 0) {
                        _allOrderArr = [NSMutableArray array];
                    }
                    if (index == 1) {
                        _waitPayOrderArr = [NSMutableArray array];
                    }
                    if (index == 2) {
                        _waitReceiveOrderArr = [NSMutableArray array];
                    }
                    if (index == 3) {
                        _doneOrderArr = [NSMutableArray array];
                    }
                    if (index == 4) {
                        _cancelOrderArr = [NSMutableArray array];
                    }
                }
                for (NSDictionary *d in arr) {
                    DuojiOrderData *item = [DuojiOrderData dataForDictionary:d];
                    if (index == 0) {
                        _allOrderLastRequsetCount = arr.count;
                        [_allOrderArr addObject:item];
                    }
                    if (index == 1) {
                        _waitPayLastRequsetCount = arr.count;
                        [_waitPayOrderArr addObject:item];
                    }
                    if (index == 2) {
                        _waitRecivedLastRequsetCount = arr.count;
                        [_waitReceiveOrderArr addObject:item];
                    }
                    if (index == 3) {
                        _doneOrderLastRequsetCount = arr.count;
                        [_doneOrderArr addObject:item];
                    }
                    if (index == 4) {
                        _cancelOrderLastRequsetCount = arr.count;
                        [_cancelOrderArr addObject:item];
                    }
                }
                if (index == 0) {
                    if (_allOrderArr.count == 0) {
                        [self showDefeatedView:true withIndex:index];
                    }
                    [_allTableView setupInfoWithDuoSetOrderArr:_allOrderArr];
                }
                if (index == 1) {
                    if (_waitPayOrderArr.count == 0) {
                        [self showDefeatedView:true withIndex:index];
                    }
                    [_waitPayTableView setupInfoWithDuoSetOrderArr:_waitPayOrderArr];
                }
                if (index == 2) {
                    if (_waitReceiveOrderArr.count == 0) {
                        [self showDefeatedView:true withIndex:index];
                    }
                    [_waitReceiveTableView setupInfoWithDuoSetOrderArr:_waitReceiveOrderArr];
                }
                if (index == 3) {
                    if (_doneOrderArr.count == 0) {
                        [self showDefeatedView:true withIndex:index];
                    }
                    [_doneTableView setupInfoWithDuoSetOrderArr:_doneOrderArr];
                }
                if (index == 4) {
                    if (_cancelOrderArr.count == 0) {
                        [self showDefeatedView:true withIndex:index];
                    }
                    [_cancelTableView setupInfoWithDuoSetOrderArr:_cancelOrderArr];
                }
            }
        }
    } fail:^(NSError *error) {
        [_allTableView.mj_header endRefreshing];
        [_allTableView.mj_footer endRefreshing];
        [_waitPayTableView.mj_header endRefreshing];
        [_waitPayTableView.mj_footer endRefreshing];
        [_waitReceiveTableView.mj_header endRefreshing];
        [_waitReceiveTableView.mj_footer endRefreshing];
        [_doneTableView.mj_header endRefreshing];
        [_doneTableView.mj_footer endRefreshing];
        [_cancelTableView.mj_header endRefreshing];
        [_cancelTableView.mj_footer endRefreshing];
    }];
}

-(void)handleOrderCellBtnActionWithDuojiOrderData:(DuojiOrderData *)order andBtnTag:(NSInteger)index{
    if (order.orderState == OrderStatesCancel) {
        if (index == 1) {
            [self buyProductsWithDuojiOrderData:order];
        }
    }
    if (order.orderState == OrderStatesCreate) {
        if (index == 1) {
            [self gotoPayOrderWithDuojiOrderData:order];
        }
    }
    if (order.orderState == OrderStatesPaid) {
        [self buyProductsWithDuojiOrderData:order];
    }
    if (order.orderState == OrderStatesSend) {
        if (index == 0) {
            [self buyProductsWithDuojiOrderData:order];
        }
        if (index == 1) {
            [self gotoLogisticsInfoWithDuojiOrderData:order];
        }
    }
    if (order.orderState == OrderStatesBeforSendCancel) {
        if (index == 1) {
            [self buyProductsWithDuojiOrderData:order];
        }
    }
    if (order.orderState == OrderStatesWaitComment) {
        if (index == 0) {
            [self buyProductsWithDuojiOrderData:order];
        }
        if (index == 1) {
            [self gotoCommentWithDuojiOrderData:order];
        }
    }
    if (order.orderState == OrderStatesDone) {
        if (index == 0) {
            [self gotoCommentWithDuojiOrderData:order];
        }
        if (index == 1) {
            [self buyProductsWithDuojiOrderData:order];
        }
    }
}

#pragma mark - 评价晒单
-(void)gotoCommentWithDuojiOrderData:(DuojiOrderData *)order{
    UserInfo *info = [Utils getUserInfo];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/order/commentPage?userId=%@&orderNo=%@",BaseUrl,info.userId,order.no];
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:true];
}

#pragma mark - 去支付
-(void)gotoPayOrderWithDuojiOrderData:(DuojiOrderData *)order{
    PayViewController *payVC = [[PayViewController alloc]initWithPayWayStatus:PayWayStatusByOrderList orderId:order.no];
    payVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:payVC animated:true];
}

#pragma mark - 再次购买
-(void)buyProductsWithDuojiOrderData:(DuojiOrderData *)order{
    [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"user/order/%@/again-buy",order.no] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [MQToast showToast:@"已加入购物车，可再次购买" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NewAddProductIntoSHopCart" object:nil];
            ShoppingCartViewController *shopCartVC = [[ShoppingCartViewController alloc]init];
            shopCartVC.isFromPrudoctDetail = true;
            shopCartVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:shopCartVC animated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 查看物流
-(void)gotoLogisticsInfoWithDuojiOrderData:(DuojiOrderData *)order{
    UserInfo *info = [Utils getUserInfo];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/order/%@/trace-log?userId=%@",BaseUrl,order.no,info.userId];
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:true];
}

#pragma mark - 订单点击处理(跳转商品详情)
-(void)handleOrderProductActionWithDuojiOrderData:(DuojiOrderData *)order andIndex:(NSInteger)index{
    DuojiOrderProductData *product = order.orderDetailResponses[index];
    SingleProductNewController *singleVC = [[SingleProductNewController alloc]initWithProductId:product.productNumber andCover:product.cover productTitle:product.productName productPrice:product.price];
    singleVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleVC animated:true];
}

#pragma mark - 跳转订单详情
-(void)handleOrderCellGotoDetailsWithDuoSetOrder:(DuojiOrderData *)order{
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]initWithOrderNum:order.no];
    detailVC.hidesBottomBarWhenPushed = true;
    detailVC.cancelOrDeletedHandle = ^{
        if (_classtype == OrderClassTypeAll) {
            _allOrderPage = 0;
            _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld",(long)_allOrderPage,(long)_limit];
            [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:0 andClear:true showHud:false];
        }
        if (_classtype == OrderClassTypeWaitPay) {
            _waitPayPage = 0;
            _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=0",(long)_waitPayPage,(long)_limit];
            [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:1 andClear:true showHud:false];
        }
        if (_classtype == OrderClassTypeWaitReceive) {
            _waitRecivedPage = 0;
            _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=20",(long)_waitRecivedPage,(long)_limit];
            [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:2 andClear:true showHud:false];
        }
        if (_classtype == OrderClassTypeDone) {
            _doneOrderPage = 0;
            _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=30",(long)_doneOrderPage,(long)_limit];
            [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:3 andClear:true showHud:false];
        }
        if (_classtype == OrderClassTypeCancel) {
            _cancelOrderPage = 0;
            _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=30",(long)_cancelOrderPage,(long)_limit];
            [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:4 andClear:true showHud:false];
        }
    };
    [self.navigationController pushViewController:detailVC animated:true];
}

#pragma mark - 删除订单处理
-(void)handleTableViewCellDeleteHandle:(DuojiOrderData *)order{
    [RequestManager showAlertFrom:self title:@"" mesaage:@"确定删除订单吗？" doneActionTitle:@"确定删除" handle:^{
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"user/order/%@?delete",order.no];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if (_classtype == OrderClassTypeAll) {
                    _allOrderPage = 0;
                    _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld",(long)_allOrderPage,(long)_limit];
                    [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:0 andClear:true showHud:false];
                }
                if (_classtype == OrderClassTypeWaitPay) {
                    _waitPayPage = 0;
                    _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=0",(long)_waitPayPage,(long)_limit];
                    [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:1 andClear:true showHud:false];
                }
                if (_classtype == OrderClassTypeWaitReceive) {
                    _waitRecivedPage = 0;
                    _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=20",(long)_waitRecivedPage,(long)_limit];
                    [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:2 andClear:true showHud:false];
                }
                if (_classtype == OrderClassTypeDone) {
                    _doneOrderPage = 0;
                    _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=30",(long)_doneOrderPage,(long)_limit];
                    [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:3 andClear:true showHud:false];
                }
                if (_classtype == OrderClassTypeCancel) {
                    _cancelOrderPage = 0;
                    _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=40",(long)_cancelOrderPage,(long)_limit];
                    [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:4 andClear:true showHud:false];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }];
}

#pragma mark - 显示没订单界面
-(void)showDefeatedView:(BOOL)show withIndex:(NSInteger)index{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(index * mainScreenWidth, 0, mainScreenWidth, _bgScrollView.frame.size.height) andDefeatedImageName:@"defeated_no_order" messageName:@"您暂时还没有订单记录哦~" backBlockBtnName:@"" backBlock:^{
            }];
            [_bgScrollView addSubview:_defeatedView];
        }else{
            CGRect frame = _defeatedView.frame;
            frame.origin.x = index * mainScreenWidth;
            _defeatedView.frame = frame;
            _defeatedView.hidden = false;
        }
    }else{
        _defeatedView.hidden = true;
    }
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ mainScreenWidth;
    [_headerView setBtnChangeWithIndex:index];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"");
}

-(void)paySucceedResultHandle{
    if (_classtype == OrderClassTypeAll) {
        _allOrderPage = 0;
        _allOrderArr = [NSMutableArray array];
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld",(long)_allOrderPage,(long)(long)_limit];
        [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:0 andClear:true showHud:false];
    }
    if (_classtype == OrderClassTypeWaitPay) {
        _waitPayOrderArr = [NSMutableArray array];
        _waitPayPage = 0;
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=0",(long)_waitPayPage,(long)(long)_limit];
        [self getAllOrderNetDataWithUrlStr:_urlStr andIndex:1 andClear:true showHud:false];
    }
}


@end
