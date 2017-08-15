//
//  MyVipHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MyVipHeaderView.h"

@interface MyVipHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *bgImgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *userSubName;
@property(nonatomic,strong) UIButton *vipBtn;

@end

@implementation MyVipHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgImgView = [UIImageView newAutoLayoutView];// user_center_header_bg
        _bgImgView.image = [UIImage imageNamed:@"piazza_header_bgView"];
        _bgImgView.userInteractionEnabled = true;
        [self addSubview:_bgImgView];
        
        UserInfo *info = [Utils getUserInfo];
        _avatar = [UIImageView newAutoLayoutView];
        [_avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:[UIImage imageNamed:@"user_nologin"] options:0];
        _avatar.layer.cornerRadius = FitHeight(140.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        _avatar.layer.borderWidth = 2;
        _avatar.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
        _avatar.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avtarAciton)];
        [_avatar addGestureRecognizer:tap];
        [_bgImgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.text = info.name;
        _userName.textColor = [UIColor whiteColor];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.font = CUSFONT(16);
        [_bgImgView addSubview:_userName];
        
        _userSubName = [UILabel newAutoLayoutView];
        _userSubName.textColor = [UIColor whiteColor];
        _userSubName.textAlignment = NSTextAlignmentLeft;
        _userSubName.font = CUSFONT(12);
        [_bgImgView addSubview:_userSubName];
        
        _vipBtn = [UIButton newAutoLayoutView];
        _vipBtn.titleLabel.font = CUSFONT(12);
        [_vipBtn setBackgroundImage:[UIImage imageNamed:@"piazza_nav_likebtn_bg"] forState:UIControlStateNormal];
        [_vipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bgImgView addSubview:_vipBtn];
        
        [self updateConstraints];
    }
    return self;
}

-(void)avtarAciton{
    
}

-(void)setupInfoWithVipData:(VipData *)item{
    _userSubName.text = [NSString stringWithFormat:@"成长值:%@   哆豆:%@",item.vipValueStr,item.pointCount];
    switch (item.vipLevel.integerValue) {
        case 1:
            [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_copper_seletced"] forState:UIControlStateNormal];
            [_vipBtn setTitle:[NSString stringWithFormat:@"铜牌会员"] forState:UIControlStateNormal];
            break;
        case 2:
            [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_silver_seletced"] forState:UIControlStateNormal];
            [_vipBtn setTitle:[NSString stringWithFormat:@"银牌会员"] forState:UIControlStateNormal];
            break;
        case 3:
            [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_gold_seletced"] forState:UIControlStateNormal];
            [_vipBtn setTitle:[NSString stringWithFormat:@"金牌会员"] forState:UIControlStateNormal];
            break;
        case 4:
            [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_diamond_seletced"] forState:UIControlStateNormal];
            [_vipBtn setTitle:[NSString stringWithFormat:@"钻石会员"] forState:UIControlStateNormal];
            break;
        case 5:
            [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_king_seletced"] forState:UIControlStateNormal];
            [_vipBtn setTitle:[NSString stringWithFormat:@"皇冠会员"] forState:UIControlStateNormal];
            break;
        default:
            [_vipBtn setImage:[UIImage imageNamed:@"user_center_vip_copper_seletced"] forState:UIControlStateNormal];
            [_vipBtn setTitle:[NSString stringWithFormat:@"铜牌会员"] forState:UIControlStateNormal];
            break;
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgImgView autoPinEdgesToSuperviewEdges];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(168.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(140.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(140.0)];
        
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(30.0)];
        [_userName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avatar withOffset:FitHeight(20.0)];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(230.0)];
        
        [_userSubName autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_userName];
        [_userSubName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_userName withOffset:FitHeight(20.0)];
        
        [_vipBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_userName];
        [_vipBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(42.0)];
        [_vipBtn autoSetDimension:ALDimensionWidth toSize:FitWith(190.0)];
        [_vipBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
