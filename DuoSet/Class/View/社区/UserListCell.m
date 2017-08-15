//
//  UserListCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserListCell.h"

@interface UserListCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *contenLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation UserListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitWith(88.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_bgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.text = @"白发三千丈";
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.font = CUSFONT(14);
        [_bgView addSubview:_userName];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [_bgView addSubview:_line];
        
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}
-(void)setupInfoWithPiazzaUserData:(PiazzaUserData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_avatar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(88.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(88.0)];
        
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(40.0)];
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        
        [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
