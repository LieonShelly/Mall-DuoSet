//
//  OrderSearchController.m
//  DuoSet
//
//  Created by fanfans on 2017/4/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSearchController.h"
#import "OrderListMainCell.h"
#import "OrderDetailViewController.h"
#import "PayViewController.h"
#import "SingleProductNewController.h"
#import "CommentDetailsController.h"
#import "ShoppingCartViewController.h"

@interface OrderSearchController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>
{
    UITableView *_tableView;
}
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIImageView *bgImgV;
@property(nonatomic,strong) UITextField *navInputTF;
@property(nonatomic,strong) UIButton *rightCancelBtn;
@property(nonatomic,strong) UIView *line;
//Data
@property(nonatomic,strong) CommonDefeatedView *defeatedView;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSMutableArray *orderArr;
@property(nonatomic,copy) NSString *keywords;

@end

@implementation OrderSearchController

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
    _limit = 10;
    _lastRequsetCount = 0;
    _orderArr = [NSMutableArray array];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceedResultHandle) name:@"OrderListOrDetailPayHandle" object:nil];
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
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self serchOrderWithKeyWord:_keywords andClear:false showHud:false];
    }];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        _lastRequsetCount = 0;
        [self serchOrderWithKeyWord:_keywords andClear:true showHud:false];
    }];
    [self.view addSubview:_tableView];
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
    
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(16.0), 0, FitWith(50.0), 26)];
    leftView.image = [UIImage imageNamed:@"common_search_left"];
    leftView.contentMode = UIViewContentModeCenter;
    [_bgImgV addSubview:leftView];
    
    _navInputTF = [[UITextField alloc]initWithFrame:CGRectMake(leftView.frame.origin.x + leftView.frame.size.width, 0, FitWith(520.0), 26)];
    _navInputTF.font = CUSFONT(13);
    _navInputTF.placeholder = @"输入商品名称、订单号";
    _navInputTF.textColor = [UIColor colorFromHex:0x222222];
    _navInputTF.tintColor = [UIColor mainColor];
    _navInputTF.returnKeyType = UIReturnKeySearch;
    _navInputTF.delegate = self;
    [_navInputTF becomeFirstResponder];
//    [_navInputTF addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DuojiOrderData *item = _orderArr[indexPath.section];
    return item.mainCellHight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DuojiOrderData *item = _orderArr[indexPath.section];
    OrderDetailViewController *detailVC = [[OrderDetailViewController alloc]initWithOrderNum:item.no];
    detailVC.hidesBottomBarWhenPushed = true;
    detailVC.cancelOrDeletedHandle = ^{
        _page = 0;
        [self serchOrderWithKeyWord:_keywords andClear:true showHud:false];
    };
    [self.navigationController pushViewController:detailVC animated:true];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(20.0))];
    view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length <= 1) {
        [MQToast showToast:@"关键字必须大于一个字" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return true;
    }
    if (textField.text.length > 1) {
        [self serchOrderWithKeyWord:textField.text andClear:true showHud:true];
        _keywords = textField.text;
    }
    [_navInputTF resignFirstResponder];
    return true;
}

-(void)rightClearHandle{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)serchOrderWithKeyWord:(NSString *)keywords andClear:(BOOL)clear showHud:(BOOL)showHud{
    NSString *str = [NSString stringWithFormat:@"user/order?keywords=%@&page=%ld&limit=%ld",keywords,(long)_page,_limit];
    NSString *urlStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [_tableView.mj_footer endRefreshing];
            [_tableView.mj_header endRefreshing];
            if (clear) {
                _orderArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in arr) {
                    DuojiOrderData *item = [DuojiOrderData dataForDictionary:d];
                    [_orderArr addObject:item];
                }
            }
            [_tableView reloadData];
            [self showDefeatedView:_orderArr.count == 0];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
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

#pragma mark - 订单单个商品点击处理
-(void)handleTableViewCellDeleteHandle:(DuojiOrderData *)order{
    [RequestManager showAlertFrom:self title:@"" mesaage:@"确定删除订单吗？" doneActionTitle:@"确定删除" handle:^{
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"user/order/%@?delete",order.no];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [_orderArr removeObject:order];
                [_tableView reloadData];
            }
        } fail:^(NSError *error) {
            //
        }];
    }];
}

#pragma mark - 订单单个商品点击处理
-(void)handleOrderProductActionWithDuojiOrderData:(DuojiOrderData *)order andIndex:(NSInteger)index{
    DuojiOrderProductData *product = order.orderDetailResponses[index];
    SingleProductNewController *singleVC = [[SingleProductNewController alloc]initWithProductId:product.productNumber andCover:product.cover productTitle:product.productName productPrice:product.price];
    singleVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleVC animated:true];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_order" messageName:@"您暂时还没有订单记录哦~" backBlockBtnName:nil backBlock:^{
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
