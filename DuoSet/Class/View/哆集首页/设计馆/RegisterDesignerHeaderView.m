//
//  RegisterDesignerHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RegisterDesignerHeaderView.h"

@interface RegisterDesignerHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *tipLable;

@property(nonatomic,strong) UIView *line;

@end

@implementation RegisterDesignerHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.text = @"驳回原因";
        _tipLable.textColor = [UIColor mainColor];
        _tipLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _tipLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_tipLable];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor mainColor];
        _contentLable.font = CUSFONT(14);
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.numberOfLines = 0;
        [self addSubview:_contentLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:_line];
        
        [self updateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipLable withOffset:FitHeight(10.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
