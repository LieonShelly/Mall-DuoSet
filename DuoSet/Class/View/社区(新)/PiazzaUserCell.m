//
//  PiazzaUserCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaUserCell.h"

@interface PiazzaUserCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UIView *line;

@end

@implementation PiazzaUserCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitHeight(90.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [self.contentView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.font = CUSNEwFONT(16);
        [self.contentView addSubview:_userName];
        
        _rightBtn = [UIButton newAutoLayoutView];
        _rightBtn.layer.cornerRadius = FitHeight(50.0) * 0.5;
        _rightBtn.layer.masksToBounds = true;
        _rightBtn.layer.borderWidth = 1;
        _rightBtn.titleLabel.font = CUSFONT(13);
        [_rightBtn setTitle:@" + 关注" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [_rightBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor colorFromHex:0x999999] forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
         [self.contentView addSubview:_rightBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithPiazzaFansUserInfo:(PiazzaFansUserInfo *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    _rightBtn.selected = item.concerns;
    if (item.concerns) {
        _rightBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
    }else{
        _rightBtn.layer.borderColor = [UIColor mainColor].CGColor;
    }
}

-(void)rightBtnAction:(UIButton *)btn{
    CellBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(btn);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_avatar autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(90.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        [_userName autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(30.0)];
        
        [_rightBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_rightBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_rightBtn autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        [_rightBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(120.0)];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
