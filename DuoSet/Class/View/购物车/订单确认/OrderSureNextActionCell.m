//
//  OrderSureNextActionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureNextActionCell.h"

@interface OrderSureNextActionCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderSureNextActionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_tipsLable];
        
        _arrowImgV = [UIImageView newAutoLayoutView];
        _arrowImgV.contentMode = UIViewContentModeRight;
        _arrowImgV.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_arrowImgV];
        
        _rightSubLable = [UILabel newAutoLayoutView];
        _rightSubLable.textColor = [UIColor colorFromHex:0x808080];
        _rightSubLable.font = CUSNEwFONT(15);
        _rightSubLable.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_rightSubLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_rightSubLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_arrowImgV withOffset:-FitWith(10)];
        [_rightSubLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(250.0) relation:NSLayoutRelationGreaterThanOrEqual];
        [_rightSubLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_rightSubLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
