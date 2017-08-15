//
//  AccountavtarCell.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AccountavtarCell.h"


@interface AccountavtarCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UIView *line;

@end

@implementation AccountavtarCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.layer.cornerRadius = FitWith(120.0) *0.5;
        _imgV.layer.masksToBounds = true;
        [self.contentView addSubview:_imgV];
        
        _userNameLable = [UILabel newAutoLayoutView];
        _userNameLable.textAlignment = NSTextAlignmentLeft;
        _userNameLable.textColor = [UIColor colorFromHex:0x222222];
        _userNameLable.font = CUSFONT(13);
        [self.contentView addSubview:_userNameLable];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.contentMode = UIViewContentModeRight;
        _rightArrow.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_rightArrow];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(15.0)];
        [_imgV autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitWith(120.0)];
        
        [_userNameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgV withOffset:FitWith(FitWith(40.0))];
        [_userNameLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_userNameLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
