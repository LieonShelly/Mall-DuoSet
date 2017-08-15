//
//  ReturnAndChangeResionChoiceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeResionChoiceCell.h"

@interface ReturnAndChangeResionChoiceCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *resionTipLable;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UIView *line;

@end

@implementation ReturnAndChangeResionChoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _resionTipLable = [UILabel newAutoLayoutView];
        _resionTipLable.text = @"申请原因";
        _resionTipLable.textColor = [UIColor colorFromHex:0x212121];
        _resionTipLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_resionTipLable];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        _subLable.textAlignment = NSTextAlignmentRight;
        _subLable.font = CUSNEwFONT(14);
        _subLable.text = @"选择申请原因";
        [self.contentView addSubview:_subLable];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.contentMode = UIViewContentModeRight;
        _rightArrow.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_rightArrow];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_resionTipLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_resionTipLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_resionTipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_subLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_rightArrow withOffset:-FitWith(20)];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(200.0) relation:NSLayoutRelationGreaterThanOrEqual];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
