//
//  ShareItemHeaderView.m
//  DuoSet
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShareItemHeaderView.h"

@interface ShareItemHeaderView()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *bgImgV;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *nameLable;

@end

@implementation ShareItemHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _bgImgV = [UIImageView newAutoLayoutView];
        _bgImgV.image = [UIImage imageNamed:@"头部背景png"];
        [self addSubview:_bgImgV];
        
        _avatarImgV = [UIImageView newAutoLayoutView];
        _avatarImgV.layer.cornerRadius = FitWith(120.0)*0.5;
        _avatarImgV.layer.masksToBounds = true;
        _avatarImgV.layer.borderColor = [UIColor mainColor].CGColor;
        _avatarImgV.layer.borderWidth = 0.5;
        [self addSubview:_avatarImgV];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.font = CUSFONT(12);
        _nameLable.textColor = [UIColor mainColor];
        _nameLable.text = @"用户名";
        _nameLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLable];
        
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgImgV autoPinEdgesToSuperviewEdges];
        
        [_avatarImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(100.0)];
        [_avatarImgV autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_avatarImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(120.0)];
        
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatarImgV withOffset:FitWith(20.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
