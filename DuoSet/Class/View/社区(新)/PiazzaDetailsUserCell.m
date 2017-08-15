//
//  PiazzaDetailsUserCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaDetailsUserCell.h"

@interface PiazzaDetailsUserCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UIButton *likeBtn;

@end

@implementation PiazzaDetailsUserCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitHeight(90.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        _avatar.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avatarTap)];
        [_avatar addGestureRecognizer:tap];
        [_bgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.font = CUSNEwFONT(17);
        [_bgView addSubview:_userName];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSNEwFONT(13);
        _likeBtn.layer.cornerRadius = FitHeight(40.0) * 0.5;
        _likeBtn.layer.masksToBounds = true;
        _likeBtn.layer.borderWidth = 1;
        _likeBtn.layer.borderColor = [UIColor mainColor].CGColor;
        [_likeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateSelected];
        [_likeBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [_likeBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(likeButtonActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_likeBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)avatarTap{
    AvatarTapBLock block = _avatarHandle;
    if (block) {
        block();
    }
}

-(void)setupInfoWithPiazzaItemCollectAndLikeData:(PiazzaItemCollectAndLikeData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    _likeBtn.selected = item.concerns;
    if (_likeBtn.selected) {
        _likeBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }else{
        _likeBtn.layer.borderColor = [UIColor mainColor].CGColor;
    }
}

-(void)likeButtonActionHandle:(UIButton *)btn{
    UserCellCollectBtnBlock block = _collectHandle;
    if (block) {
        block(btn);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(24.0)];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(32.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(90.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(30.0)];
        
        [_likeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_likeBtn autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        [_likeBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
