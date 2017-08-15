//
//  CustomAlert.m
//  DuoSet
//
//  Created by fanfans on 2017/6/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CustomAlert.h"

@interface CustomAlert()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *messageLable;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;

@end

@implementation CustomAlert

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)alertTitle message:(NSString *)message leftTitle:(NSString *)leftTitle leftColor:(UIColor *)leftColor leftTextColor:(UIColor *)leftTextColor rightTitle:(NSString*)rightTitle rightColor:(UIColor *)rightColor rightTextColor:(UIColor *)rightTextColor{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if (alertTitle.length > 0) {
            _titleLable = [UILabel newAutoLayoutView];
            _titleLable.backgroundColor = [UIColor whiteColor];
            _titleLable.font = [UIFont systemFontOfSize:15];
            _titleLable.numberOfLines = 0;
            _titleLable.textAlignment = NSTextAlignmentCenter;
            _titleLable.textColor = [UIColor blackColor];
            _titleLable.text = alertTitle;
            [self addSubview:_titleLable];
        }
        
        _messageLable = [UILabel new];
        _messageLable.backgroundColor = [UIColor whiteColor];
        _messageLable.font = alertTitle.length > 0 ? [UIFont systemFontOfSize:13] : [UIFont systemFontOfSize:15];
        _messageLable.numberOfLines = 0;
        _messageLable.textAlignment = NSTextAlignmentCenter;
        _messageLable.textColor = [UIColor blackColor];
        _messageLable.text = message;
        [self addSubview:_messageLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:_line];
        
        _leftBtn = [UIButton newAutoLayoutView];
        _leftBtn.backgroundColor = leftColor;
        _leftBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _leftBtn.tag = 0;
        [_leftBtn setTitleColor:leftTextColor forState:UIControlStateNormal];
        _leftBtn.font = [UIFont systemFontOfSize:15];
        [_leftBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
        
        _rightBtn = [UIButton newAutoLayoutView];
        _rightBtn.backgroundColor = rightColor;
        _rightBtn.tag = 1;
        _rightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_rightBtn setTitleColor:rightTextColor forState:UIControlStateNormal];
        _rightBtn.font = [UIFont systemFontOfSize:15];
        [_rightBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        
        [self updateConstraints];
    }
    return self;
}

-(void)btnAction:(UIButton *)btn{
    AlertButtonActionBlock block = _alertActionHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        if (_titleLable != nil) {
            [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
            [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
            [_titleLable autoSetDimension:ALDimensionHeight toSize:44];
            
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:34];
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:44];
        }else{
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
            [_messageLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:44];
        }
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:44];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_leftBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_leftBtn autoSetDimension:ALDimensionHeight toSize:44];
        [_leftBtn autoSetDimension:ALDimensionWidth toSize:self.bounds.size.width * 0.5];
        [_leftBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_rightBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_rightBtn autoSetDimension:ALDimensionHeight toSize:44];
        [_rightBtn autoSetDimension:ALDimensionWidth toSize:self.bounds.size.width * 0.5];
        [_rightBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
