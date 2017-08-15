//
//  OrderDetailsNextActionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailsNextActionCell.h"

@interface OrderDetailsNextActionCell()

@property (nonatomic,strong) UIImageView *arrowImgV;
@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderDetailsNextActionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsImgV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_tipsImgV];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_tipsLable];
        
        _arrowImgV = [UIImageView newAutoLayoutView];
        _arrowImgV.contentMode = UIViewContentModeRight;
        _arrowImgV.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_arrowImgV];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_tipsImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(80.0)];
        
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
