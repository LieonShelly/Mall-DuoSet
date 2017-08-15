//
//  PercentageView.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PercentageView.h"

@interface PercentageView()

@property(nonatomic,strong) UIView *fillView;
@property(nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation PercentageView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xe5b8b7];
        self.layer.cornerRadius = FitHeight(30.0) * 0.5;
        self.layer.borderColor = [UIColor mainColor].CGColor;
        self.layer.borderWidth = 1;
        
        _fillView = [UIView newAutoLayoutView];
        _fillView.backgroundColor = [UIColor mainColor];
        _fillView.layer.cornerRadius = FitHeight(30.0) * 0.5;
        _fillView.layer.borderColor = [UIColor mainColor].CGColor;
        [self addSubview:_fillView];
        
        [self updateConstraints];
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_fillView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_fillView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_fillView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_fillView autoSetDimension:ALDimensionWidth toSize:FitWith(50.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
