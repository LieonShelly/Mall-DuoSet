//
//  OrderCategoryController.m
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "OrderCategoryController.h"
#import "DuojiOrderData.h"
#import "OrderListMainCell.h"
#import "OrderDetailViewController.h"
#import "PayViewController.h"
#import "SingleProductNewController.h"
#import "ReturnAndChangeData.h"
#import "MessageListController.h"
#import "OrderSearchController.h"
#import "CommentDetailsController.h"
#import "ShoppingCartViewController.h"

@interface OrderCategoryController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,assign) OrderStates state;
@property(nonatomic,strong) UITableView *orderTableView;
@property(nonatomic,strong) NSMutableArray *orderArr;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;
//Data
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;

@end

@implementation OrderCategoryController

-(instancetype)initWithOrderStates:(OrderStates)state{
    self = [super init];
    if (self) {
        _state = state;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightButton];
    [self creatUI];
    _page = 0;
    _limit = 10;
    _orderArr = [NSMutableArray array];
    [self configData:true showHud:true];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceedResultHandle) name:@"OrderListOrDetailPayHandle" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configData:(BOOL)clear showHud:(BOOL)showHud{
    if (_state == OrderStatesCreate) {
        self.title = @"待付款";
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=0",(long)_page,_limit];
    };
    if (_state == OrderStatesSend) {
        self.title = @"待收货";
        _urlStr = [NSString stringWithFormat:@"user/order?page=%ld&limit=%ld&status=20",(long)_page,_limit];
    }
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:GET WithUrlPath:_urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                weakSelf.orderArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in arr) {
                    DuojiOrderData *item = [DuojiOrderData dataForDictionary:d];
                    [weakSelf.orderArr addObject:item];                }
                if (_orderArr.count == 0) {
                    [weakSelf showDefeatedView:true];
                }
                [weakSelf.orderTableView reloadData];
            }
        }
        [weakSelf.orderTableView.mj_footer endRefreshing];
        [_orderTableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [weakSelf.orderTableView.mj_footer endRefreshing];
        [weakSelf.orderTableView.mj_header endRefreshing];
        //
    }];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _orderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _orderTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _orderTableView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _orderTableView.dataSource = self;
    _orderTableView.delegate = self;
    _orderTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    __weak typeof(self) weakSelf = self;
    _orderTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.lastRequsetCount < weakSelf.limit) {
            [weakSelf.orderTableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        weakSelf.page += 1;
        [weakSelf configData:false showHud:false];
    }];
    _orderTableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        weakSelf.page = 0;
        weakSelf.lastRequsetCount = 0;
        [weakSelf configData:true showHud:false];
    }];
    [self.view addSubview:_orderTableView];
}

-(void)setRightButton{
    UIButton *search = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [search setImage:[UIImage imageNamed:@"order_search"] forState:UIControlStateNormal];
    [search addTarget:self action:@selector(navSearch) forControlEvents:UIControlEventTouchUpInside];
    search.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc]initWithCustomView:search];
    
//    UIButton *message = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
//    [message setImage:[UIImage imageNamed:@"order_message"] forState:UIControlStateNormal];
//    [message addTarget:self action:@selector(navMessage) forControlEvents:UIControlEventTouchUpInside];
//    message.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
//    UIBarButtonItem *messageBtn = [[UIBarButtonItem alloc]initWithCustomView:message];
    
//    NSArray *arr = @[messageBtn,searchBtn];
//    self.navigationItem.rightBarButtonItems = arr;
    self.navigationItem.rightBarButtonItem = searchBtn;
}

-(void)navSearch{
    OrderSearchController *searchVC = [[OrderSearchController alloc]init];
    searchVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:searchVC animated:true];
}

-(void)navMessage{
    MessageListController *messageListVc = [[MessageListController alloc]initWithMessageType:MessageTypeOrder andTypeName:@"订单消息" andTypeId:@"1"];
    messageListVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:messageListVc animated:true];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _orderArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    DuojiOrderData *item = _orderArr[indexPath.section];
    NSString *OrderListMainCellID = [NSString stringWithFormat:@"OrderListMainCellID-%ld",(unsigned long)item.orderDetailResponses.count];
    OrderListMainCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderListMainCellID];
    if (cell == nil) {
        cell = [[OrderListMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderListMainCellID andDuoSetOrder:item];
    }
    cell.btnActionHandle = ^(DuojiOrderData *order, NSInteger index) {
        [weakSelf handleOrderCellBtnActionWithDuojiOrderData:order andBtnTag:index];
    };
    cell.productTapHandle = ^(DuojiOrderData *order, NSInteger index) {
        [weakSelf handleOrderProductActionWithDuojiOrderData:order andIndex:index];
    };
    cell.cellDeletedHandle = ^(DuojiOrderData *order) {
        [weakSelf handleTableViewCellDeleteHandle:order];
    };
    [cell setupInfoWithDuoSetOrder:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 订单点击按钮处理
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
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"user/order/%@/again-buy",order.no] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [MQToast showToast:@"已加入购物车，可再次购买" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NewAddProductIntoSHopCart" object:nil];
            ShoppingCartViewController *shopCartVC = [[ShoppingCartViewController alloc]init];
            shopCartVC.isFromPrudoctDetail = true;
            shopCartVC.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController pushViewController:shopCartVC animated:true];
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

#pragma mark - 订单单个商品点击处理
-(void)handleOrderProductActionWithDuojiOrderData:(DuojiOrderData *)order andIndex:(NSInteger)index{
    DuojiOrderProductData *product = order.orderDetailResponses[index];
    SingleProductNewController *singleVC = [[SingleProductNewController alloc]initWithProductId:product.productNumber andCover:product.cover productTitle:product.productName productPrice:product.price];
    singleVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleVC animated:true];
}

#pragma mark - 订单单个商品点击处理
-(void)handleTableViewCellDeleteHandle:(DuojiOrderData *)order{
    __weak typeof(self) weakSelf = self;
    [RequestManager showAlertFrom:self title:@"" mesaage:@"确定删除订单吗？" doneActionTitle:@"确定删除" handle:^{
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"user/order/%@?delete",order.no];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [weakSelf.orderArr removeObject:order];
                [weakSelf.orderTableView reloadData];
            }
        } fail:^(NSError *error) {
            //
        }];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DuojiOrderData *item = _orderArr[indexPath.section];
    return  item.mainCellHight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    DuojiOrderData *item = _orderArr[indexPath.section];
    OrderDetailViewController *detailsVC = [[OrderDetailViewController alloc]initWithOrderNum:item.no];
    detailsVC.hidesBottomBarWhenPushed = true;
    detailsVC.cancelOrDeletedHandle = ^{
        [weakSelf configData:true showHud:false];
    };
    [self.navigationController pushViewController:detailsVC animated:true];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_order" messageName:@"您暂时还没有订单记录哦~" backBlockBtnName:@"" backBlock:^{
//                GoHomeBlock block = _gohomeHandle;
//                if (block) {
//                    block();
//                }
//                [self.navigationController popViewControllerAnimated:true];
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

-(void)paySucceedResultHandle{
    _page = 0;
    [self configData:true showHud:false];
}

@end
