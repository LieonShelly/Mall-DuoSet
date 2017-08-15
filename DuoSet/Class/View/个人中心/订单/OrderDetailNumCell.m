//
//  OrderDetailNumCell.m
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailNumCell.h"

@interface OrderDetailNumCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderDetailNumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.text = @"订单号:";
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_tipsLable];
        
        _orderNumLable = [UILabel newAutoLayoutView];
        _orderNumLable.textColor = [UIColor colorFromHex:0x222222];
        _orderNumLable.textAlignment = NSTextAlignmentLeft;
        _orderNumLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_orderNumLable];
        
        _orderStatusLable = [UILabel newAutoLayoutView];
        _orderStatusLable.textColor = [UIColor mainColor];
        _orderStatusLable.textAlignment = NSTextAlignmentRight;
        _orderStatusLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_orderStatusLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        
        [_orderNumLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tipsLable withOffset:FitWith(10)];
        [_orderNumLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_orderNumLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_orderStatusLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_orderStatusLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_orderStatusLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
