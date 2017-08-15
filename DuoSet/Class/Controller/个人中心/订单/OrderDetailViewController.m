//
//  OrderDetailViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/6.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailNumCell.h"
#import "OrderDetailsNextActionCell.h"
#import "OrderDetailProductCell.h"
#import "OrderDetailPayWayCell.h"
#import "OrderDetailLogisticCell.h"
#import "OrderDetailAmountCell.h"
#import "OrderDetailBottomView.h"
#import "OrderCategoryController.h"
#import "CommentDetailsController.h"
#import "OrderCategoryController.h"
#import "OrderTetailsInvoiceCell.h"
#import "OrderDetailGlobalAmountCell.h"

#import "OrderCancelResionView.h"
#import "CancelResionData.h"

#import "ShoppingCartViewController.h"
#import "SingleProductNewController.h"
#import "OrderSearchController.h"
#import "AllOrderViewController.h"
#import "MQChatViewManager.h"
#import "DuojiOrderModel.h"
#import "OrderInvoice.h"
#import "OrderRefundController.h"

@interface OrderDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) DuojiOrderData *order;
@property(nonatomic,copy) NSString *no;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) OrderDetailBottomView *bottomView;
@property(nonatomic,strong) OrderInvoice *invoiceInfo;

@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) OrderCancelResionView *resionView;
@property(nonatomic,strong) NSMutableArray *cancelResionArr;
@property(nonatomic,strong) NSMutableArray *refundResionArr;

@end

@implementation OrderDetailViewController

#pragma mark - init & viewDidLoad

-(instancetype)initWithOrderNum:(NSString *)no{
    self = [super init];
    if (self) {
        _no = no;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self creatUI];
    [self configData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceedResultHandle) name:@"OrderListOrDetailPayHandle" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_bottomView relessTimer];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - creatUI
- (void) creatUI{
    UIBarButtonItem *leftReturnButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_nav_arrow_black"] style:UIBarButtonItemStylePlain target:self action:@selector(progressLeftReturnButton)];
    leftReturnButton.tintColor = [UIColor darkGrayColor];
    self.navigationItem.leftBarButtonItem = leftReturnButton;
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - FitHeight(100.0)) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(void)configBottomView{
    __weak typeof(self) weakSelf = self;
    _bottomView = [[OrderDetailBottomView alloc]initWithFrame:CGRectMake(0, mainScreenHeight - FitHeight(100.0), mainScreenWidth, FitHeight(100.0))];
    _bottomView.btnActionHandle = ^(UIButton *btn){
        [weakSelf bottomBtnAcitonHanleWithIndex:btn];
    };
    _bottomView.cutdownEndHandle = ^{
        [weakSelf configData];
    };
    [self.view addSubview:_bottomView];
}

-(void)configData{
    __weak typeof(self) weakSelf = self;
    NSString *urlStr = [NSString stringWithFormat:@"user/order/%@",_no];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//OrderInvoice *invoiceInfo
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"order"] && [[objectDic objectForKey:@"order"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [objectDic objectForKey:@"order"];
                    weakSelf.order = [DuojiOrderData dataForDictionary:objDic];
                }
                if ([objectDic objectForKey:@"invoice"] && [[objectDic objectForKey:@"invoice"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [objectDic objectForKey:@"invoice"];
                    weakSelf.invoiceInfo = [OrderInvoice dataForDictionary:objDic];
                }
                [weakSelf configBottomView];
                [weakSelf.bottomView setupInfoWithDuojiOrderData:weakSelf.order];
                [weakSelf.tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_order == nil) {
        return 0;
    }
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0://订单号 感谢购买 查看物流
            return _order.orderState == OrderStatesCreate ? 1 : 2;
            break;
        case 1://配送信息
            return 1;
            break;
        case 2://商品展示
            return 1;
            break;
            
        case 3://付款方式
            return (_order.orderState == OrderStatesCreate || _order.orderState == OrderStatesCancel) ? 0 : 1;
            break;
        case 4://发票信息
            return _invoiceInfo == nil ? 0 : 1;
            break;
        case 5://商品价格信息
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *OrderDetailNumCellID = @"OrderDetailNumCellID";
            OrderDetailNumCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailNumCellID];
            if (cell == nil) {
                cell = [[OrderDetailNumCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNumCellID];
            }
            cell.orderNumLable.text = _order.no;
            cell.orderStatusLable.text = _order.statusName;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        static NSString *OrderDetailsNextActionCellID = @"OrderDetailsNextActionCellID";
        OrderDetailsNextActionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailsNextActionCellID];
        if (cell == nil) {
            cell = [[OrderDetailsNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailsNextActionCellID];
        }
        if (_order.orderState == OrderStatesCancel || _order.orderState == OrderStatesBeforSendCancel) {
            cell.tipsLable.text = @"取消/退款进度";
            cell.imageView.image = [UIImage imageNamed:@"order_details_time"];
        }
        if (_order.orderState == OrderStatesPaid || _order.orderState == OrderStatesSend ) {
            cell.tipsLable.text = @"查看物流";
            cell.imageView.image = [UIImage imageNamed:@"order_details_ogistic"];
        }
        if (_order.orderState == OrderStatesWaitComment || _order.orderState == OrderStatesDone) {
            cell.tipsLable.text = @"感谢您在哆集购物，欢迎您再次光临!";
            cell.imageView.image = [UIImage imageNamed:@"order_details_ogistic"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *OrderDetailLogisticCellID = @"OrderDetailLogisticCellID";
        OrderDetailLogisticCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailLogisticCellID];
        if (cell == nil) {
            cell = [[OrderDetailLogisticCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailLogisticCellID];
        }
        [cell setupInfoWithDuojiOrderData:_order];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *OrderDetailProductCellID = @"OrderDetailProductCellID";
        OrderDetailProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailProductCellID];
        if (cell == nil) {
            cell = [[OrderDetailProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailProductCellID andDuoSetOrder:_order];
        }
        __weak typeof(self) weakSelf = self;
        [cell setupInfoWithDuoSetOrder:_order];
        cell.chatHandle = ^(){
            [weakSelf chatWithServer];
        };
        cell.productTapHandle = ^(NSInteger index) {
            [weakSelf gotoProductDetailsWithIndex:index];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 3) {
        static NSString *OrderDetailPayWayCellID = @"OrderDetailPayWayCellID";
        OrderDetailPayWayCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailPayWayCellID];
        if (cell == nil) {
            cell = [[OrderDetailPayWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailPayWayCellID];
        }
        cell.payWayLable.text = _order.payType;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 4) {
        static NSString *OrderTetailsInvoiceCellID = @"OrderTetailsInvoiceCellID";
        OrderTetailsInvoiceCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderTetailsInvoiceCellID];
        if (cell == nil) {
            cell = [[OrderTetailsInvoiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderTetailsInvoiceCellID];
        }
        cell.nameLable.text = _invoiceInfo.title;
        cell.rightLable.text = _invoiceInfo.type.integerValue >=3 ? @"电子发票" : @"纸质发票";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 5) {
        if (_order.isGlobal) {
            static NSString *OrderDetailGlobalAmountCellID = @"OrderDetailGlobalAmountCellID";
            OrderDetailGlobalAmountCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailGlobalAmountCellID];
            if (cell == nil) {
                cell = [[OrderDetailGlobalAmountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailGlobalAmountCellID];
            }
            [cell setupDuojiOrderData:_order];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        static NSString *OrderDetailProductCellID = @"OrderDetailAmountCellID";
        OrderDetailAmountCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailProductCellID];
        if (cell == nil) {
            cell = [[OrderDetailAmountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailProductCellID];
        }
        [cell setupDuojiOrderData:_order];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FitHeight(90.0);
    }
    if (indexPath.section == 1) {
        return _order.LogisticCellHight;
    }
    if (indexPath.section == 2) {
        return _order == nil ? 0 : _order.detailsCellHight;
    }
    if (indexPath.section == 3) {
        return FitHeight(90.0);
    }
    if (indexPath.section == 4) {
        return _invoiceInfo == nil ? 0 : _invoiceInfo.invoiceHight;
    }
    if (indexPath.section == 5) {
        if (_order.isGlobal) {
            return FitHeight(350.0);
        }
        return FitHeight(300.0);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UserInfo *info = [Utils getUserInfo];
        NSString *urlStr = @"";
        if (_order.orderState == OrderStatesCancel) {
            urlStr = [NSString stringWithFormat:@"%@user/order/%@/trace-return?userId=%@",BaseUrl,_order.no,info.userId];
        }else{
            urlStr = [NSString stringWithFormat:@"%@user/order/%@/trace-log?userId=%@",BaseUrl,_order.no,info.userId];
        }
        WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:true];
    }
}

#pragma mark - 跳转商品详情
-(void)gotoProductDetailsWithIndex:(NSInteger)index{
    DuojiOrderProductData *item = _order.orderDetailResponses[index];
    SingleProductNewController *singleVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price];
    singleVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleVC animated:true];
}

#pragma mark - bottomViewbuttonAction
-(void)bottomBtnAcitonHanleWithIndex:(UIButton *)btn{
    NSInteger index = btn.tag;
    if (_order.orderState == OrderStatesCreate) {
        if (index == 2) {
            [self cancelOrderHandle];
            return;
        }
        if (index == 3) {
            [self gotoPayOrder];
        }
        return;
    }
    if (_order.orderState == OrderStatesBeforSendCancel) {
        if (index == 3) {
            [self buyProductsWithOrder];
        }
        return;
    }
    if (_order.orderState == OrderStatesPaid) {
        if (index == 2) {
            btn.userInteractionEnabled = false;
            [self refundOrderWithBtn:btn];
            return;
        }
        if (index == 3) {
            [self buyProductsWithOrder];
        }
        return;
    }
    if (_order.orderState == OrderStatesSend) {
        if (_order.isGlobal) {
            if (index == 3) {
                [self buyProductsWithOrder];
            }
        }else{
            if (index == 2) {
                [self gotoAfterBuyService];
                return;
            }
            if (index == 3) {
                [self buyProductsWithOrder];
            }
        }
        return;
    }
    if (_order.orderState == OrderStatesWaitComment) {
        if (_order.isGlobal) {
            if (index == 1) {
                [self deleteOrderHandle];
                return;
            }
            if (index == 2) {
                [self buyProductsWithOrder];
                return;
            }
            if (index == 3) {
                [self gotoCommentWithOrderProduct];
                return;
            }
        }else{
            if (index == 0) {
                [self deleteOrderHandle];
                return;
            }
            if (index == 1) {
                [self gotoAfterBuyService];
                return;
            }
            if (index == 2) {
                [self buyProductsWithOrder];
                return;
            }
            if (index == 3) {
                [self gotoCommentWithOrderProduct];
            }
        }
        return;
    }
    if (_order.orderState == OrderStatesDone) {
        if (_order.isGlobal) {
            if (index == 2) {
                [self deleteOrderHandle];
                return;
            }
            if (index == 3) {
                [self buyProductsWithOrder];
            }
        }else{
            if (index == 1) {
                [self deleteOrderHandle];
                return;
            }
            if (index == 2) {
                [self gotoAfterBuyService];
                return;
            }
            if (index == 3) {
                [self buyProductsWithOrder];
            }
        }
        return;
    }
    if (_order.orderState == OrderStatesCancel) {
        if (index == 2) {
            [self deleteOrderHandle];
            return;
        }
        if (index == 3) {
            [self buyProductsWithOrder];
        }
        return;
    }}

#pragma mark - 退款
-(void)refundOrderWithBtn:(UIButton *)btn{
    OrderRefundController *refundVC = [[OrderRefundController alloc]initWithDuojiOrderData:_order];
    refundVC.hidesBottomBarWhenPushed = true;
    __weak typeof(self) weakSelf = self;
    refundVC.refundHandle = ^{
        OrderCancelOrDeletedBlock block = weakSelf.cancelOrDeletedHandle;
        if (block) {
            block();
        }
        [weakSelf configData];
    };
    [self.navigationController pushViewController:refundVC animated:true];
    btn.userInteractionEnabled = true;
    return;
}

#pragma mark - 取消订单
-(void)cancelOrderHandle{
    [self getCancelOrderResion];
    return;
}

#pragma mark - 去支付
-(void)gotoPayOrder{
    PayViewController *payVC = [[PayViewController alloc]initWithPayWayStatus:PayWayStatusByOrderDetails orderId:_order.no];
    payVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:payVC animated:true];
}

#pragma mark - 删除订单
-(void)deleteOrderHandle{
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定删除订单吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"user/order/%@?delete",_order.no];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:weakSelf showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [MQToast showToast:@"订单删除成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                OrderCancelOrDeletedBlock block = weakSelf.cancelOrDeletedHandle;
                if (block) {
                    block();
                }
                for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[AllOrderViewController class]]) {
                        [weakSelf.navigationController popToViewController:vc animated:true];
                        return ;
                    }
                    if ([vc isKindOfClass:[OrderCategoryController class]]) {
                        [weakSelf.navigationController popToViewController:vc animated:true];
                        return ;
                    }
                    if ([vc isKindOfClass:[OrderSearchController class]]) {
                        [weakSelf.navigationController popToViewController:vc animated:true];
                        return ;
                    }
                    if ([vc isKindOfClass:[SingleProductNewController class]]) {
                        [weakSelf.navigationController popToViewController:vc animated:true];
                        return ;
                    }
                    if ([vc isKindOfClass:[ShoppingCartViewController class]]) {
                        [weakSelf.navigationController popToViewController:vc animated:true];
                        return ;
                    }
                }
                [weakSelf.navigationController popViewControllerAnimated:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

#pragma mark - 再次购买
-(void)buyProductsWithOrder{
    [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"user/order/%@/again-buy",_order.no] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
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

#pragma mark - 申请售后
-(void)gotoAfterBuyService{
    UserInfo *info = [Utils getUserInfo];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/order/changePage?userId=%@&orderNo=%@",BaseUrl,info.userId,_order.no];
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:true];
}

#pragma mark - 评价晒单
-(void)gotoCommentWithOrderProduct{
    UserInfo *info = [Utils getUserInfo];
    NSString *urlStr = [NSString stringWithFormat:@"%@user/order/commentPage?userId=%@&orderNo=%@",BaseUrl,info.userId,_order.no];
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)progressLeftReturnButton{
    if (_isPopToTop) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[ShoppingCartViewController class]]) {
                [self.navigationController popToViewController:controller animated:true];
                return;
            }
            if ([controller isKindOfClass:[SingleProductNewController class]]) {
                [self.navigationController popToViewController:controller animated:true];
                return;
            }
            if ([controller isKindOfClass:[OrderCategoryController class]]) {
                [self.navigationController popToViewController:controller animated:true];
                return;
            }
        }
    }
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - 美洽(客服聊天)
-(void)chatWithServer{
    UserInfo *info = [Utils getUserInfo];
    NSDictionary* clientCustomizedAttrs = @{
                                            @"orderNo"            : _order.no,
                                            @"orderPrice"      : _order.totalPrice != nil ? _order.totalPrice :_order.amountPrice,
                                            @"status"    : _order.statusName
                                            };
    NSMutableDictionary *clientInfo = [NSMutableDictionary dictionaryWithDictionary:clientCustomizedAttrs];
    
    if (info.token) {
        [clientInfo setObject:info.name forKey:@"name"];
        [clientInfo setObject:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar] forKey:@"avatar"];
    }
    DuojiOrderMessage *meaasge = [[DuojiOrderMessage alloc]initWithProductDetailsData:_order];
    DuojiOrderModel *model = [[DuojiOrderModel alloc]initCellModelWithMessage:meaasge cellWidth:FitWith(630.0) delegate:nil];
    MQChatViewManager *chatViewManager = [[MQChatViewManager alloc] init];
    chatViewManager.orderModel = model;
    [chatViewManager setClientInfo:clientInfo override:true];
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

#pragma mark - 显示取消/退款原因
-(void)getCancelOrderResion{
    NSString *urlStr = @"";
    if (_order.orderState == OrderStatesPaid) {//已付款 - 退款
        if (_refundResionArr.count > 0) {
            [self showTipsView];
            return;
        }
        urlStr = @"services/reason?type=2";
    }
    if (_order.orderState == OrderStatesCreate) {//创建 - 直接取消
        if (_cancelResionArr.count > 0) {
            [self showTipsView];
            return;
        }
        urlStr = @"services/reason?type=3";
    }
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (_order.orderState == OrderStatesPaid) {
                _refundResionArr = [NSMutableArray array];
            }
            if (_order.orderState == OrderStatesCreate) {
                _cancelResionArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    CancelResionData *item = [CancelResionData dataForDictionary:d];
                    if (_order.orderState == OrderStatesPaid) {
                        [_refundResionArr addObject:item];
                    }
                    if (_order.orderState == OrderStatesCreate) {
                        [_cancelResionArr addObject:item];
                    }
                }
                [self showTipsView];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)showTipsView{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.markView];
    if (_resionView == nil){
        _resionView = [[OrderCancelResionView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(542.0))];
        [window addSubview:_resionView];
    }
    if (_order.orderState == OrderStatesPaid) {
        _resionView.titleLable.text = @"申请退款";
        _resionView.tipsLable.text = @"申请退款后，本单所享用的优惠可能会一并取消，是否继续？";
        _resionView.resiontipsLable.text = @"请选择申请退款的原因（必选）：";
        [_resionView setupInfoWithCancelResionDataArr:_refundResionArr];
    }
    if (_order.orderState == OrderStatesCreate) {
        [_resionView setupInfoWithCancelResionDataArr:_cancelResionArr];
    }
    __weak typeof(self) weakSelf = self;
    _resionView.closeHandle = ^{
        [weakSelf hiddenMarkView];
    };
    _resionView.agreeHandle = ^(NSString *resion){
        [weakSelf hiddenMarkView];
        [weakSelf agreeTipsCommitDataWithResion:resion];
    };
    CGRect frame = _resionView.frame;
    frame.origin.y = mainScreenHeight - FitHeight(542.0);
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.resionView.frame = frame;
    }];
}

-(UIView *)markView{
    if (_markView) {
        return _markView;
    }
    _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:_markView];
    _markView.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMarkView)];
    [_markView addGestureRecognizer:tap];
    return _markView;
}

-(void)hiddenMarkView{
    CGRect frame = _resionView.frame;
    frame.origin.y = mainScreenHeight;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.resionView.frame = frame;
        [weakSelf.markView removeFromSuperview];
        weakSelf.markView = nil;
        [weakSelf.resionView removeFromSuperview];
        weakSelf.resionView = nil;
    }];
}

//选择了原因后的回调
-(void)agreeTipsCommitDataWithResion:(NSString *)resion{
    if (_order.orderState == OrderStatesCreate) {
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"user/order/%@?cancel",_order.no];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:resion forKey:@"reason"];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                OrderCancelOrDeletedBlock block = _cancelOrDeletedHandle;
                if (block) {
                    block();
                }
                [self configData];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
    if (_order.orderState == OrderStatesPaid) {
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"/user/order/%@/refund",_order.no];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:resion forKey:@"reason"];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                OrderCancelOrDeletedBlock block = _cancelOrDeletedHandle;
                if (block) {
                    block();
                }
                [self configData];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(void)paySucceedResultHandle{
    [self configData];
}

@end
