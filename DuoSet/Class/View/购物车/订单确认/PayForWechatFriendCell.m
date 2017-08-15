//
//  PayForWechatFriendCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/26.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PayForWechatFriendCell.h"

@interface PayForWechatFriendCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *tipLable;
@property (nonatomic,strong) UILabel *tipSubLable;
@property (nonatomic,strong) UIImageView *rightArrow;

@end

@implementation PayForWechatFriendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.image = [UIImage imageNamed:@"wechat_PayForOrther"];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgV];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.text = @"微信好友代付";
        _tipLable.font = CUSFONT(14);
        _tipLable.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_tipLable];
        
        _tipSubLable = [UILabel newAutoLayoutView];
        _tipSubLable.text = @"帮你付款的才是真爱";
        _tipSubLable.textColor = [UIColor colorFromHex:0x999999];
        _tipSubLable.font = CUSFONT(12);
        _tipSubLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_tipSubLable];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.image = [UIImage imageNamed:@"right_arrow"];
        _rightArrow.contentMode = UIViewContentModeRight;
        [self.contentView addSubview:_rightArrow];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_imgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_imgV autoSetDimension:ALDimensionWidth toSize:FitWith(54.0)];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitWith(54.0)];
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(140.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        [_tipSubLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipLable];
        [_tipSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipLable withOffset:5];
        
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(50.0)];
        [_rightArrow autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
