//
//  MustBuyBigView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuyBigView.h"

@interface MustBuyBigView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *subLable;

@end

@implementation MustBuyBigView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgV];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        _titleLable.font = CUSFONT(13);
        _titleLable.numberOfLines = 1;
        [self addSubview:_titleLable];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textAlignment = NSTextAlignmentLeft;
        _subLable.textColor = [UIColor colorFromHex:0x999999];
        _subLable.font = CUSFONT(12);
        _subLable.numberOfLines = 1;
        [self addSubview:_subLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithMustBuyRecommendData:(MustBuyRecommendData *)item{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:item.headeCover] placeholderImage:placeholderImage_702_420 options:0];
    _titleLable.text = item.title;
    _subLable.text = item.summary;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitHeight(200.0)];
        
        [_titleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_imgV withOffset:FitWith(10.0)];
        [_titleLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_imgV withOffset:FitWith(10.0)];
        [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV];
        
        [_subLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable withOffset:5];
        [_subLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_imgV withOffset:FitWith(10.0)];
        [_subLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_imgV withOffset:FitWith(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
