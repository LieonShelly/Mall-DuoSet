//
//  SigninHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SigninHeaderView.h"

@interface SigninHeaderView()

@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UIImageView *douImgV;
@property(nonatomic,strong) UILabel *pointCount;
@property(nonatomic,strong) UILabel *subLable;
@property(nonatomic,strong) UIButton *siginBtn;
@property(nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation SigninHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UserInfo *info = [Utils getUserInfo];
        
        _avatar = [UIImageView newAutoLayoutView];
        [_avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
        _avatar.layer.borderWidth = 2;
        _avatar.layer.masksToBounds = true;
        _avatar.layer.borderColor = [UIColor colorFromHex:0xeaeaea].CGColor;
        _avatar.layer.cornerRadius = FitWith(120.0) * 0.5;
        [self addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.text = [Utils getUserInfo].name;
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        [self addSubview:_userName];
        
        _douImgV = [UIImageView newAutoLayoutView];
        _douImgV.image = [UIImage imageNamed:@"singin_all_img"];
        [self addSubview:_douImgV];
        
        _pointCount = [UILabel newAutoLayoutView];
        _pointCount.textColor = [UIColor colorFromHex:0x222222];
        _pointCount.textAlignment = NSTextAlignmentLeft;
        _pointCount.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:14];
        [self addSubview:_pointCount];
        
        _siginBtn = [UIButton newAutoLayoutView];
        _siginBtn.titleLabel.font = CUSFONT(12);
        [_siginBtn setTitle:@"立即签到" forState:UIControlStateNormal];
        [_siginBtn setTitle:@"已签到" forState:UIControlStateSelected];
        [_siginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_siginBtn addTarget:self action:@selector(signinBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_siginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forState:UIControlStateNormal];
        [_siginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHex:0xf8a81d]] forState:UIControlStateSelected];
        _siginBtn.layer.cornerRadius = FitHeight(44.0) * 0.5;
        _siginBtn.layer.masksToBounds = true;
        [self addSubview:_siginBtn];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textColor = [UIColor colorFromHex:0x222222];
        _subLable.textAlignment = NSTextAlignmentLeft;
        _subLable.font = CUSFONT(12);
        [self addSubview:_subLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupinfoWithUserSignData:(UserSignData *)item{
    _pointCount.text = [NSString stringWithFormat:@"%@颗",item.pointCount];
    _subLable.text = item.signRemark;
    _siginBtn.selected = item.todayIsSign;
}

-(void)signinBtnAction:(UIButton *)btn{
    if (btn.selected) {
        return;
    }
    SigninButtonActionBlock block = _signinHandle;
    if (block) {
        block(btn);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(28.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(126.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(126.0)];
        
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(20.0)];
        [_userName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avatar withOffset:FitHeight(14.0)];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(230.0)];
        
        [_douImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_userName];
        [_douImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_userName withOffset:FitHeight(10.0)];
        [_douImgV autoSetDimension:ALDimensionWidth toSize:FitWith(55.0)];
        [_douImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
        
        [_pointCount autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_douImgV];
        [_pointCount autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_douImgV withOffset:FitWith(20.0)];
        
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(28.0)];
        [_subLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(18.0)];
        
        [_siginBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_siginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_siginBtn autoSetDimension:ALDimensionWidth toSize:FitWith(162.0)];
        [_siginBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(51.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
