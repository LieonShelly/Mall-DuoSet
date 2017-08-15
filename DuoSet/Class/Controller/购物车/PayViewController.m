//
//  PayViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/9.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "PayViewController.h"
#import "ShoppingCartViewController.h"
#import "SingleProductNewController.h"
#import "OrderDetailViewController.h"
#import "PayOrderPriceInfoCell.h"
#import "PayWayCell.h"
#import "PayForWechatFriendCell.h"
#import "PaySucceedController.h"
#import "AllOrderViewController.h"
#import "OtherFrendPayController.h"
#import "CustomAlert.h"

#import "WXApiObject.h"
#import "payRequsestHandler.h"
#import "payRequsestHandler.h"
#import "WXApi.h"

#import "AlixPayResult.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiObject.h"
#import "SBJSON.h"
#import "DataSigner.h"

@interface PayViewController ()<UITableViewDataSource, UITableViewDelegate>
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UILabel *titleLable;

@property(nonatomic,assign) DuoSetPayWay payWay;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *imgArr;
@property(nonatomic,strong) NSMutableArray *titleNameArr;
@property(nonatomic,strong) NSArray *sectionTitleNameArr;
@property(nonatomic,assign) PayWayStatus payStatus;
@property(nonatomic,strong) TransitionAnimator *animator;

@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,copy) NSString *totalPrice;
@property(nonatomic,copy) NSString *subtractPrice;
@property(nonatomic,copy) NSString *payTime;
@property(nonatomic,retain) dispatch_source_t timer;
@property(nonatomic,strong) NSString *showCutTimeStr;

@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) CustomAlert *alertView;

@end

@implementation PayViewController

-(instancetype)initWithPayWayStatus:(PayWayStatus)payStatus orderId:(NSString *)orderId{
    self = [super init];
    if (self) {
        _payStatus = payStatus;
        _orderId = orderId;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)dealloc{
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.totalPrice = @"";
    [self configData];
    [self creatUI];
    [self configNav];
    _payWay = PayWayForWeChat;
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        _payWay = PayWayForAlipay;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payResultHandle) name:@"AliPayResult" object:nil];
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
    _titleLable.text = @"支付订单";
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [_navView addSubview:_titleLable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

-(void)configData{
    NSString *urlStr = [NSString stringWithFormat:@"user/order/%@/price",_orderId];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = [responseDic objectForKey:@"object"];
                if ([dic objectForKey:@"totalPrice"]) {
                    self.totalPrice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPrice"]];
                }
                if ([dic objectForKey:@"subtractPrice"]) {
                    self.subtractPrice = [NSString stringWithFormat:@"%@",[dic objectForKey:@"subtractPrice"]];
                }
                if ([dic objectForKey:@"payTime"]) {
                    self.payTime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"payTime"]];
                }
                [self handlepayTime];
                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)removeTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)handlepayTime{
    [self countDownWithFinishTimeStamp:self.payTime.longLongValue completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        if (day == 0 && hour == 0 && minute == 0 && second == 0) {
        }
        NSString *hourStr = @"";
        NSString *minuteStr = @"";
        NSString *secondStr = @"";
        if (hour<10) {
            hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        if (minute<10) {
            minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
        }else{
            minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        if (second<10) {
            secondStr= [NSString stringWithFormat:@"0%ld",(long)second];
        }else{
            secondStr= [NSString stringWithFormat:@"%ld",(long)second];
        }
        if (day > 0) {
            hourStr = [NSString stringWithFormat:@"%ld",(long)hour + 24*day];
        }
        _showCutTimeStr = [NSString stringWithFormat:@"%@小时%@分钟",hourStr,minuteStr];
    }];
}

-(void)countDownWithFinishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer == nil) {
        NSTimeInterval timeInterval = finishTimeStamp/1000;
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void) creatUI{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        _imgArr = [NSMutableArray arrayWithObjects:@"Pay-treasure", nil];
        _titleNameArr = [NSMutableArray arrayWithObjects:@"支付宝支付", nil];
        _payWay = PayWayForAlipay;
    }else{
        _imgArr = [NSMutableArray arrayWithObjects:@"WeChat-pay",@"Pay-treasure", nil];
        _titleNameArr = [NSMutableArray arrayWithObjects:@"微信支付",@"支付宝支付", nil];
    }
    _sectionTitleNameArr = @[@"支付信息",@"选择支付方式",@"找人代付"];
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = false;
    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
    
    UIButton *gotoPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), mainScreenHeight - FitHeight(250.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
    [gotoPayBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [gotoPayBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    gotoPayBtn.titleLabel.font = CUSFONT(16);
    [gotoPayBtn setTitle:@"确认付款" forState:UIControlStateNormal];
    [gotoPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:gotoPayBtn];
    [gotoPayBtn addTarget:self action:@selector(gotoPayOrder) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:gotoPayBtn];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        return 2;
    }
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            return 1;
        }
        return 2;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *PayOrderPriceInfoCellID = @"PayOrderPriceInfoCellID";
        PayOrderPriceInfoCell * cell = [_tableView dequeueReusableCellWithIdentifier:PayOrderPriceInfoCellID];
        if (cell == nil) {
            cell = [[PayOrderPriceInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PayOrderPriceInfoCellID];
        }
        [cell setupInfoWithPriceStr:self.totalPrice];
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *PayWayCellID = @"PayWayCellID";
        PayWayCell * cell = [_tableView dequeueReusableCellWithIdentifier:PayWayCellID];
        if (cell == nil) {
            cell = [[PayWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PayWayCellID];
        }
        cell.tipImgV.image = [UIImage imageNamed:_imgArr[indexPath.row]];
        cell.infoLable.text = _titleNameArr[indexPath.row];
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            cell.selectedBtn.selected = indexPath.row == 0;
        }else{
            if (_payWay == PayWayForWeChat) {
                cell.selectedBtn.selected = indexPath.row == 0;
            }
            if (_payWay == PayWayForAlipay) {
                cell.selectedBtn.selected = indexPath.row == 1;
            }
            if (_payWay == PayWayForDuoSet) {
                cell.selectedBtn.selected = indexPath.row == 2;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *PayForWechatFriendCellID = @"PayForWechatFriendCellID";
    PayForWechatFriendCell * cell = [_tableView dequeueReusableCellWithIdentifier:PayForWechatFriendCellID];
    if (cell == nil) {
        cell = [[PayForWechatFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PayForWechatFriendCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FitHeight(100.0);
    }
    if (indexPath.section == 1) {
        return FitHeight(88.0);
    }
    if (indexPath.section == 2) {
        return FitHeight(120.0);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitWith(90.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
    UILabel *sectionLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), 0, mainScreenWidth - FitWith(24.0), FitHeight(90.0))];
    sectionLable.text = _sectionTitleNameArr[section];
    sectionLable.font = CUSFONT(14);
    sectionLable.textColor = [UIColor colorFromHex:0x999999];
    sectionLable.textAlignment = NSTextAlignmentLeft;
    [view addSubview:sectionLable];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            _payWay = PayWayForAlipay;
        }else{
            if (indexPath.row == 0) {
                _payWay = PayWayForWeChat;
            }
            if (indexPath.row == 1) {
                _payWay = PayWayForAlipay;
            }
            if (indexPath.row == 2) {
                _payWay = PayWayForDuoSet;
            }
        }
        [_tableView reloadData];
    }
    if (indexPath.section == 2) {
        OtherFrendPayController *ortherPay = [[OtherFrendPayController alloc]initWithOrderId:_orderId andPrice:[NSString stringWithFormat:@"%.2lf",self.totalPrice.floatValue]];
        ortherPay.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:ortherPay animated:true];
    }
}

-(void)gotoPayOrder{
    if (_payWay == PayWayForOther) {
        return;
    }
    [self getInfoFromServerWithPayWay:_payWay];
}

#pragma mark - payAndGetInfo
-(void)getInfoFromServerWithPayWay:(DuoSetPayWay)payWay{
    if (payWay == PayWayForAlipay) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_orderId forKey:@"orderId"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/order/pay/alipay" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    if ([objDic objectForKey:@"info"]) {
                        NSString *str = [objDic objectForKey:@"info"];
                        [self sendValusToAlipayOrderStr:str Scheme:@"Duoji"];
                    }
//                    NSString *isGlobalStr = @"";
//                    if ([objDic objectForKey:@"isGlobal"]) {
//                        isGlobalStr = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"isGlobal"]];
//                    }
//                    if (isGlobalStr.integerValue == 1) {
//                        if ([objDic objectForKey:@"info"]) {
//                            NSString *str = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"info"]];
//                            NSURL *url = [NSURL URLWithString:str];
//                            if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                                [[UIApplication sharedApplication] openURL:url];
//                            }
//                        }
//                    }else{
//                    }
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
    if (payWay == PayWayForWeChat) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_orderId forKey:@"orderId"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/order/pay/wechatPay" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    if ([objDic objectForKey:@"info"] && [[objDic objectForKey:@"info"]isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *infoDic = [objDic objectForKey:@"info"];
                        [self weChatPayWithDic:infoDic];
                    }
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

#pragma mark - weChatPay
-(void)weChatPayWithDic:(NSDictionary *)dic{
    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {//没安装微信
        [[UIApplication sharedApplication].keyWindow makeToast:@"未安装微信客服端，暂不能使用微信支付"];
        return;
    }
    if (dic) {
        NSMutableString *stamp  = [dic objectForKey:@"timestamp"];
        PayReq* req             = [[PayReq alloc] init];
        req.openID              = [dic objectForKey:@"appid"];
        req.partnerId           = [dic objectForKey:@"partnerid"];
        req.prepayId            = [dic objectForKey:@"prepayid"];
        req.nonceStr            = [dic objectForKey:@"noncestr"];
        req.timeStamp           = stamp.intValue;
        req.package             = [dic objectForKey:@"packages"];
        req.sign                = [dic objectForKey:@"sign"];
        [WXApi sendReq:req];
        //日志输出
        NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    
    [alter show];
}


#pragma mark - AliPay
-(void)sendValusToAlipayOrderStr:(NSString *)orderString Scheme:(NSString *)scheme{
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:scheme callback:^(NSDictionary *resultDic) {
        SBJSON *sbjson = [[SBJSON alloc]init];
        NSString *resultDicToString = [sbjson stringWithObject:resultDic];
        [self payMentResult:resultDicToString];
    }];
 }

-(void)payMentResult:(NSString *)resultDicToString{
    AlixPayResult *result = [[AlixPayResult alloc]initWithString:resultDicToString];
    if (result != nil) {
        if (result.statusCode == 9000) {
            [self payResultHandle];
        }
    }
}

//支付回调
-(void)payResultHandle{
    if (_payStatus == PayWayStatusByOrderDetails || _payStatus == PayWayStatusByOrderList) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OrderListOrDetailPayHandle" object:nil];
    }
    PaySucceedController *paySucceedVC = [[PaySucceedController alloc]initWithPayWayStatus:_payStatus orderId:_orderId];
    self.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:paySucceedVC animated:true];
    return;
}

- (void)leftItemHandle{
    [self showAlertView:true];
}

- (TransitionAnimator *)animator {
    if (_animator == nil) {
        _animator = [[TransitionAnimator alloc]init];
        CGFloat x = 30;
        CGFloat height = 135;
        CGFloat y = self.view.bounds.size.height * 0.5 - height * 0.5;
        CGFloat width = self.view.bounds.size.width - 30 * 2;
        _animator.presentFrame = CGRectMake(x, y, width, height);
    }
    return _animator;
}

#pragma mark - showAlertView
-(void)showAlertView:(BOOL)show{
    if (show) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.markView];
        [self.markView addSubview:self.alertView];
        self.markView.alpha = 0.f;
        self.alertView.alpha = 0.f;
        self.alertView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        [UIView animateWithDuration:0.25f animations:^{
            self.markView.alpha = 1;
            self.alertView.alpha = 1;
            self.alertView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            //
        }];
    }else{
        [UIView animateWithDuration:0.25f animations:^{
            self.markView.alpha = 0.f;
            self.alertView.alpha = 0.f;
            self.alertView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        } completion:^(BOOL finished) {
            [self.alertView removeFromSuperview];
            self.alertView = nil;
            [self.markView removeFromSuperview];
            self.markView = nil;
        }];
    }
}

-(CustomAlert *)alertView{
    if (_alertView == nil) {
        CGFloat width = self.view.bounds.size.width - 30 * 2;
        CGFloat height = 135;
        _alertView = [[CustomAlert alloc]initWithFrame:CGRectMake(0, 0, width, height) title:@"确定要离开收银台？" message:[NSString stringWithFormat:@"您的订单在%@内未支付将被取消，请尽快完成支付",_showCutTimeStr] leftTitle:@"继续支付" leftColor:[UIColor whiteColor] leftTextColor:[UIColor colorFromHex:0x222222] rightTitle:@"确定离开" rightColor:[UIColor mainColor] rightTextColor:[UIColor whiteColor]];
        _alertView.alertActionHandle = ^(NSInteger index) {
            if (index == 0) {
                [self showAlertView:false];
            }
            if (index == 1) {
                [self showAlertView:false];
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[AllOrderViewController class]]) {
                        [self.navigationController popToViewController:vc animated:true];
                        [self removeTimer];
                        return ;
                    }
                }
                AllOrderViewController *allOrderVC = [[AllOrderViewController alloc]init];
                allOrderVC.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:allOrderVC animated:true];
                [self removeTimer];
            }
        };
        _alertView.center = _markView.center;
    }
    return _alertView;
}

-(UIView *)markView{
    if (_markView == nil) {
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _markView;
}

@end
