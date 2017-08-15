//
//  PaySucceedController.m
//  DuoSet
//
//  Created by fanfans on 2017/6/26.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PaySucceedController.h"
#import "ShoppingCartViewController.h"
#import "SingleProductNewController.h"
#import "AllOrderViewController.h"
#import "OrderDetailViewController.h"
#import "OrderCategoryController.h"
#import "OrderSearchController.h"

@interface PaySucceedController ()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *desLable;
@property(nonatomic,strong) UILabel *payAmountLable;
@property(nonatomic,strong) UILabel *cutAmountLable;
@property(nonatomic,strong) UILabel *payTypeLable;
@property(nonatomic,strong) UIButton *lookOrderList;
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIButton *doneBtn;
@property(nonatomic,strong) UILabel *titleLable;
//data
@property(nonatomic,assign) PayWayStatus payStatus;
@property(nonatomic,copy)   NSString *orderId;
@property(nonatomic,copy)   NSString *allAmountStr;
@property(nonatomic,copy)   NSString *cutAmountStr;
@property(nonatomic,copy)   NSString *payTypeStr;


@end

@implementation PaySucceedController

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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self configNav];
    [self configUI];
    [self configData];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44,20,44,44)];
    _doneBtn.titleLabel.font = CUSFONT(13);
    [_doneBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_doneBtn addTarget:self action:@selector(rightDoneHandle) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_doneBtn];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _titleLable.text = @"支付成功";
    [_navView addSubview:_titleLable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

-(void)rightDoneHandle{
    if (_payStatus == PayWayStatusByCart) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[ShoppingCartViewController class]]) {
                [self.navigationController popToViewController:vc animated:true];
                return;
            }
        }
        return;
    }
    if (_payStatus == PayWayStatusBySingleItem) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[SingleProductNewController class]]) {
                [self.navigationController popToViewController:vc animated:true];
                return;
            }
        }
        return;
    }
    if (_payStatus == PayWayStatusByOrderDetails) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[OrderDetailViewController class]]) {
                [self.navigationController popToViewController:vc animated:true];
                return;
            }
        }
        return;
    }
    if (_payStatus == PayWayStatusByOrderList) {
        for (UIViewController *vc in self.navigationController.viewControllers) {
            if ([vc isKindOfClass:[OrderDetailViewController class]]) {
                [self.navigationController popToViewController:vc animated:true];
                return;
            }
            if ([vc isKindOfClass:[AllOrderViewController class]]) {
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
        }
        return;
    }
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"user/order/%@/payOver",_orderId] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"order"] && [[objDic objectForKey:@"order"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *orderDic = [objDic objectForKey:@"order"];
                    if ([orderDic objectForKey:@"amountPrice"]) {
                        NSString *str = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"amountPrice"]];
                        _allAmountStr = [NSString stringWithFormat:@"%.2lf",str.floatValue];
                    }
                    if ([orderDic objectForKey:@"cutPrice"]) {
                        NSString *str = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"cutPrice"]];
                        _cutAmountStr = [NSString stringWithFormat:@"%.2lf",str.floatValue];
                    }
                    if ([orderDic objectForKey:@"payType"]) {
                        _payTypeStr = [NSString stringWithFormat:@"%@",[orderDic objectForKey:@"payType"]];
                    }
                }
                [self setupInfo];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)setupInfo{
    if (_allAmountStr.length > 0) {
        NSString *allStr = [NSString stringWithFormat:@"支付金额:%@",_allAmountStr];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:allStr];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(allStr.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(5, _allAmountStr.length)];
        self.payAmountLable.attributedText = attributeString;
    }
    if (_cutAmountStr.length > 0) {
        NSString *allStr = [NSString stringWithFormat:@"优惠金额:%@",_cutAmountStr];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:allStr];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(allStr.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(5, _cutAmountStr.length)];
        self.cutAmountLable.attributedText = attributeString;
    }
    if (_payTypeStr.length > 0) {
        _payTypeLable.text = [NSString stringWithFormat:@"支付方式:%@",_payTypeStr];
    }
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    
    _imgV = [UIImageView newAutoLayoutView];
    _imgV.image = [UIImage imageNamed:@"paySucceed"];
    [self.view addSubview:_imgV];
    
    _desLable = [UILabel newAutoLayoutView];
    _desLable.text = @"订单支付成功啦！";
    _desLable.textColor = [UIColor mainColor];
    _desLable.textAlignment = NSTextAlignmentCenter;
    _desLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_desLable];
    
    _payAmountLable = [UILabel newAutoLayoutView];
    _payAmountLable.textColor = [UIColor colorFromHex:0x222222];
    _payAmountLable.textAlignment = NSTextAlignmentCenter;
    _payAmountLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_payAmountLable];
    
    _cutAmountLable = [UILabel newAutoLayoutView];
    _cutAmountLable.textColor = [UIColor colorFromHex:0x222222];
    _cutAmountLable.textAlignment = NSTextAlignmentCenter;
    _cutAmountLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_cutAmountLable];
    
    _payTypeLable = [UILabel newAutoLayoutView];
    _payTypeLable.textColor = [UIColor colorFromHex:0x222222];
    _payTypeLable.textAlignment = NSTextAlignmentCenter;
    _payTypeLable.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_payTypeLable];
    
    _lookOrderList = [UIButton newAutoLayoutView];
    _lookOrderList.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    _lookOrderList.layer.borderWidth = 1;
    _lookOrderList.layer.cornerRadius = 3;
    _lookOrderList.layer.masksToBounds = true;
    _lookOrderList.titleLabel.font = [UIFont systemFontOfSize:16];
    [_lookOrderList setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
    [_lookOrderList addTarget:self action:@selector(lookAllOrderList) forControlEvents:UIControlEventTouchUpInside];
    [_lookOrderList setTitle:@"查看订单" forState:UIControlStateNormal];
    [self.view addSubview:_lookOrderList];
    
    [self updateViewConstraints];
}

-(void)lookAllOrderList{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[AllOrderViewController class]]) {
            [self.navigationController popToViewController:vc animated:true];
            return ;
        }
    }
    AllOrderViewController *allOrderVC = [[AllOrderViewController alloc]init];
    allOrderVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:allOrderVC animated:true];
}


-(void)updateViewConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:23 + 64];
        [_imgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_imgV autoSetDimension:ALDimensionWidth toSize:85];
        [_imgV autoSetDimension:ALDimensionHeight toSize:85];
        
        [_desLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:15];
        [_desLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_payAmountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_desLable withOffset:15];
        [_payAmountLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_payAmountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_desLable withOffset:15];
        [_payAmountLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_cutAmountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_payAmountLable withOffset:5];
        [_cutAmountLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_payTypeLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cutAmountLable withOffset:5];
        [_payTypeLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_lookOrderList autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [_lookOrderList autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [_lookOrderList autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_payTypeLable withOffset:15];
        [_lookOrderList autoSetDimension:ALDimensionHeight toSize:35];
        
        _didUpdateConstraints = true;
    }
    [super updateViewConstraints];
}

@end
