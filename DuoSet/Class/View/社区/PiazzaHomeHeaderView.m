//
//  PiazzaHomeHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaHomeHeaderView.h"

@interface PiazzaHomeHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *bannerView;
@property(nonatomic,strong) UIImageView *leftImgV;
@property(nonatomic,strong) UIView *leftMarkView;
@property(nonatomic,strong) UILabel *leftLable;
@property(nonatomic,strong) UIImageView *rightimgV;
@property(nonatomic,strong) UIView *rightMarkView;
@property(nonatomic,strong) UILabel *rightLable;

@end

@implementation PiazzaHomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _bannerView = [UIImageView newAutoLayoutView];
        _bannerView.image = [UIImage imageNamed:@"piazza_bannerImg"];
        [self addSubview:_bannerView];
        
        _leftImgV = [UIImageView newAutoLayoutView];
        _leftImgV.image = [UIImage imageNamed:@"piazzaLeftImg"];
        _leftImgV.userInteractionEnabled = true;
        _leftImgV.tag = 0;
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTapAction:)];
        [_leftImgV addGestureRecognizer:tap0];
        _leftImgV.layer.cornerRadius = 2;
        _leftImgV.layer.masksToBounds = true;
        [self addSubview:_leftImgV];
        
        _leftMarkView = [UIView newAutoLayoutView];
        _leftMarkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [_leftImgV addSubview:_leftMarkView];
        
        _leftLable = [UILabel newAutoLayoutView];
        _leftLable.textColor = [UIColor whiteColor];
        _leftLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _leftLable.text = @"设计爱好者";
        [_leftMarkView addSubview:_leftLable];
        
        _rightimgV = [UIImageView newAutoLayoutView];
        _rightimgV.image = [UIImage imageNamed:@"piazzaRightImg"];
        _rightimgV.userInteractionEnabled = true;
        _rightimgV.tag = 1;
        _rightimgV.layer.cornerRadius = 2;
        _rightimgV.layer.masksToBounds = true;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTapAction:)];
        [_rightimgV addGestureRecognizer:tap1];
        [self addSubview:_rightimgV];
        
        _rightMarkView = [UIView newAutoLayoutView];
        _rightMarkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [_rightimgV addSubview:_rightMarkView];
        
        _rightLable = [UILabel newAutoLayoutView];
        _rightLable.textColor = [UIColor whiteColor];
        _rightLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _rightLable.text = @"摄影爱好者";
        [_rightMarkView addSubview:_rightLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)imgVTapAction:(UITapGestureRecognizer *)tap{
    PiazzaHeaderViewActionBlock block = _tapHandle;
    if (block) {
        block(tap.view.tag);
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [_bannerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bannerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bannerView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bannerView autoSetDimension:ALDimensionHeight toSize:FitHeight(374.0)];
        
        [_leftImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_leftImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_bannerView withOffset:FitHeight(20.0)];
        [_leftImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(150.0)];
        [_leftImgV autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(48.0) - FitWith(20.0)) * 0.5];
        
        [_leftMarkView autoPinEdgesToSuperviewEdges];
        
        [_leftLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_leftLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_rightimgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_rightimgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_leftImgV];
        [_rightimgV autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_leftImgV];
        [_rightimgV autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_leftImgV];
        
        [_rightMarkView autoPinEdgesToSuperviewEdges];
        
        [_rightLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_rightLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
