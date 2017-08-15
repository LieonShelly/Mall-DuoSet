//
//  DuoPointHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuoPointHeaderView.h"

@interface DuoPointHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *headrView;
@property(nonatomic,strong) UILabel *pointCountLable;
@property(nonatomic,strong) UILabel *smallLable;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIView *whiteBgView;
@property(nonatomic,strong) UILabel *subTitleLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation DuoPointHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _headrView = [UIView newAutoLayoutView];
        _headrView.backgroundColor = [UIColor mainColor];
        [self addSubview:_headrView];
        
        _pointCountLable = [UILabel newAutoLayoutView];
        _pointCountLable.textColor = [UIColor whiteColor];
        _pointCountLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:65];
        [_headrView addSubview:_pointCountLable];
        
        _smallLable = [UILabel newAutoLayoutView];
        _smallLable.font = CUSFONT(25);
        _smallLable.textColor = [UIColor whiteColor];
        [_headrView addSubview:_smallLable];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.font = CUSFONT(14);
        _tipsLable.textColor = [UIColor whiteColor];
        _tipsLable.text = @"小哆豆，大有用，多领一些囤起来!";
        [_headrView addSubview:_tipsLable];
        
        _whiteBgView = [UIView newAutoLayoutView];
        _whiteBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteBgView];
        
        _subTitleLable = [UILabel newAutoLayoutView];
        _subTitleLable.font = CUSFONT(14);
        _subTitleLable.textColor = [UIColor colorFromHex:0x222222];
        _subTitleLable.text = @"收支明细";
        [_whiteBgView addSubview:_subTitleLable];
        
        _line = [UILabel newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [_whiteBgView addSubview:_line];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupPointCountWithString:(NSString *)str{
    _pointCountLable.text = str;
    _smallLable.text = @"个";
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_headrView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_headrView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_headrView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_headrView autoSetDimension:ALDimensionHeight toSize:FitHeight(428.0)];
        
        [_pointCountLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_pointCountLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(120.0)];
        
        [_smallLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_pointCountLable withOffset:-FitHeight(20)];
        [_smallLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_pointCountLable withOffset:FitWith(20.0)];
        
        [_tipsLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(290.0)];
        
        [_whiteBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_whiteBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_whiteBgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_whiteBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(78.0)];
        
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
