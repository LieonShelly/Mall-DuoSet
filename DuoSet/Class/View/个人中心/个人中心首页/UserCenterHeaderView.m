//
//  UserCenterHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserCenterHeaderView.h"

@interface UserCenterHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *bgImgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UIButton *vipBtn;
@property(nonatomic,strong) UIButton *coverBtn;

@end

@implementation UserCenterHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //user_center_header_bg@3x
        _bgImgView = [UIImageView newAutoLayoutView];
        _bgImgView.image = [UIImage imageNamed:@"piazza_header_bgView"];
//        _bgImgView.image = [UIImage imageNamed:@"user_center_header_bg"];
        _bgImgView.userInteractionEnabled = true;
        [self addSubview:_bgImgView];
        
        UserInfo *info = [Utils getUserInfo];
        _avatar = [UIImageView newAutoLayoutView];
        [_avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
        _avatar.layer.cornerRadius = FitHeight(140.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        _avatar.layer.borderWidth = 2;
        _avatar.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
        _avatar.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avtarAciton)];
        [_avatar addGestureRecognizer:tap];
        [_bgImgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        if (info.name) {
            _userName.text = info.name;
        }else{
            _userName.text = @"登录/注册";
        }
        _userName.textColor = [UIColor whiteColor];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.font = CUSFONT(16);
        [_bgImgView addSubview:_userName];
        
        _vipBtn = [UIButton newAutoLayoutView];
        _vipBtn.titleLabel.font = CUSFONT(12);
        [_vipBtn setBackgroundImage:[UIImage imageNamed:@"piazza_nav_likebtn_bg"] forState:UIControlStateNormal];
        [_vipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_vipBtn addTarget:self action:@selector(vipAction) forControlEvents:UIControlEventTouchUpInside];
        _vipBtn.hidden = true;
        [_bgImgView addSubview:_vipBtn];
        
        _coverBtn = [UIButton newAutoLayoutView];
        [_coverBtn addTarget:self action:@selector(avtarAciton) forControlEvents:UIControlEventTouchUpInside];
        [_bgImgView addSubview:_coverBtn];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item{
    _vipBtn.hidden = false;
    if (item.vipLevel.integerValue == 1) {//铜牌
        [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_copper_seletced"] forState:UIControlStateNormal];
        [_vipBtn setTitle:@"铜牌会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 2) {//银牌
        [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_silver_seletced"] forState:UIControlStateNormal];
        [_vipBtn setTitle:@"银牌会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 3) {//金牌
        [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_gold_seletced"] forState:UIControlStateNormal];
        [_vipBtn setTitle:@"金牌会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 4) {//钻石
        [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_diamond_seletced"] forState:UIControlStateNormal];
        [_vipBtn setTitle:@"钻石会员" forState:UIControlStateNormal];
    }
    if (item.vipLevel.integerValue == 5) {//皇冠
        [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_king_seletced"] forState:UIControlStateNormal];
        [_vipBtn setTitle:@"皇冠会员" forState:UIControlStateNormal];
    }
    
}

-(void)resetHeaderViewInfo{
    UserInfo *info = [Utils getUserInfo];
    [_avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = info.name;
}

-(void)clearUserInfo{
    _avatar.image = placeholderImage_avatar;
    _userName.text = @"登录/注册";
    _vipBtn.hidden = true;
}

-(void)avtarAciton{
    UserCenterAvatarTapBlock block = _avatarHandle;
    if (block) {
        block();
    }
}

-(void)accountAction{
    UserCenterAccountTapBlock block = _accountHandle;
    if (block) {
        block();
    }
}

-(void)vipAction{
    UserCentervipTapBlock block = _vipHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgImgView autoPinEdgesToSuperviewEdges];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(168.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(140.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(140.0)];
        
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(230.0)];
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(30.0)];
        
        [_vipBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_vipBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(42.0)];
        [_vipBtn autoSetDimension:ALDimensionWidth toSize:FitWith(190.0)];
        [_vipBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_coverBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_avatar];
        [_coverBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avatar];
        [_coverBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_avatar];
        [_coverBtn autoSetDimension:ALDimensionWidth toSize:FitWith(400.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
