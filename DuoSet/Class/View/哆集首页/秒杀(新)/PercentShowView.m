//
//  PercentShowView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PercentShowView.h"

@interface PercentShowView()

@property(nonatomic,strong) UIView *filView;

@end

@implementation PercentShowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor mainColor].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = FitHeight(14.0) * 0.5;
        self.layer.masksToBounds = true;
        
        _filView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, frame.size.height)];
        _filView.backgroundColor = [UIColor mainColor];
        [self addSubview:_filView];
    }
    return self;
}

-(void)setFillViewCoveWithProgress:(CGFloat)progress{
    CGRect frame = _filView.frame;
    frame.size.width = FitWith(142) * progress;
    [UIView animateWithDuration:0.2 animations:^{
        _filView.frame = frame;
    }];
}

@end
