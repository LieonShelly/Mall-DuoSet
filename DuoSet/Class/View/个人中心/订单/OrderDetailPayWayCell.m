//
//  OrderDetailPayWayCell.m
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailPayWayCell.h"

@interface OrderDetailPayWayCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *sendInfoLable;
@property (nonatomic,strong) UILabel *sendTimeLable;

@end

@implementation OrderDetailPayWayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSFONT(13);
        _tipsLable.text = @"支付方式";
        [self.contentView addSubview:_tipsLable];
        
        _payWayLable = [UILabel newAutoLayoutView];
        _payWayLable.textColor = [UIColor colorFromHex:0x222222];
        _payWayLable.textAlignment = NSTextAlignmentRight;
        _payWayLable.font = CUSFONT(13);
        _payWayLable.text = @"微信支付";
        [self.contentView addSubview:_payWayLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        
        [_payWayLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_tipsLable];
        [_payWayLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(90.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
