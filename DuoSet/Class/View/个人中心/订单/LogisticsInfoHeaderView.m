//
//  LogisticsInfoHeaderView.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "LogisticsInfoHeaderView.h"

@interface LogisticsInfoHeaderView()

@property(nonatomic,strong) UILabel *orderNumLable;
@property(nonatomic,strong) UILabel *logisticsCompany;
@property(nonatomic,strong) UILabel *logisticsNumLable;

@end

@implementation LogisticsInfoHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _orderNumLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), FitHeight(30.0), mainScreenWidth - FitWith(60.0), FitHeight(FitHeight(50)))];
        _orderNumLable.textColor = [UIColor colorFromHex:0x666666];
        _orderNumLable.textAlignment = NSTextAlignmentLeft;
        _orderNumLable.font = CUSFONT(12);
        [self addSubview:_orderNumLable];
        
        _logisticsCompany = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), _orderNumLable.frame.origin.y + _orderNumLable.frame.size.height + FitHeight(30.0), mainScreenWidth - FitWith(60.0), FitHeight(FitHeight(50)))];
        _logisticsCompany.textColor = [UIColor colorFromHex:0x666666];
        _logisticsCompany.textAlignment = NSTextAlignmentLeft;
        _logisticsCompany.font = CUSFONT(12);
        [self addSubview:_logisticsCompany];
        
        _logisticsNumLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), _logisticsCompany.frame.origin.y + _logisticsCompany.frame.size.height + FitHeight(30.0), mainScreenWidth - FitWith(60.0), FitHeight(FitHeight(50)))];
        _logisticsNumLable.textColor = [UIColor colorFromHex:0x666666];
        _logisticsNumLable.textAlignment = NSTextAlignmentLeft;
        _logisticsNumLable.font = CUSFONT(12);
        [self addSubview:_logisticsNumLable];
        
    }
    return self;
}

-(void)setupInfoWithLogisticsInfoData:(LogisticsInfoData *)item{
    _orderNumLable.text = [NSString stringWithFormat:@"订单编号：%@",item.orderNo];
    _logisticsCompany.text = [NSString stringWithFormat:@"物流公司：%@",item.express];
    _logisticsNumLable.text = [NSString stringWithFormat:@"物流单号：%@",item.expressNum];
}


@end
