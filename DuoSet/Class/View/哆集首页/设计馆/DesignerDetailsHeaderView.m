//
//  DesignerDetailsHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerDetailsHeaderView.h"

@interface DesignerDetailsHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *cover;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UIButton *likeBtn;
@property(nonatomic,strong) UILabel *nameLable;

@end

@implementation DesignerDetailsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _cover = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(400.0))];
        _cover.userInteractionEnabled = true;
        _cover.contentMode = UIViewContentModeScaleAspectFill;
        _cover.layer.masksToBounds = true;
        [self addSubview:_cover];
        
        UIView *markView = [[UIView alloc]initWithFrame:_cover.frame];
        markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self addSubview:markView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.masksToBounds = true;
        _avatar.contentMode = UIViewContentModeScaleAspectFill;
        _avatar.layer.cornerRadius = FitWith(176.0) * 0.5;
        _avatar.layer.borderWidth = 2;
        _avatar.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:_avatar];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSFONT(13);
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_likeBtn setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"piazza_like_normal"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"piazza_like_seletced"] forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(likeBtnActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [markView addSubview:_likeBtn];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textColor = [UIColor colorFromHex:0x222222];
        _nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _nameLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)likeBtnActionHandle:(UIButton *)btn{
    LikeBtnActionBlock block = _likehandle;
    if (block) {
        block(btn);
    }
}

-(void)setupInfoWithDesignerData:(DesignerData *)item{
    [_cover sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_702_420 options:0];
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    [_likeBtn setTitle:item.followCount forState:UIControlStateNormal];
    _likeBtn.selected = item.follow;
    _nameLable.text = item.name;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(310.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(176.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(176.0)];
        [_avatar autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(36.0)];
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(22.0)];
        
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(16)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
