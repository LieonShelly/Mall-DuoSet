//
//  SeckillHeaderBtnView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillHeaderBtnView.h"

@interface SeckillHeaderBtnView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UILabel *statusLable;

@end

@implementation SeckillHeaderBtnView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.text = @"12:00";
        _timeLable.font = CUSNEwFONT(21);
        _timeLable.textColor = [UIColor colorFromHex:0x222222];
        _timeLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLable];
        
        _statusLable = [UILabel newAutoLayoutView];
        _statusLable.text = @"即将开始";
        _statusLable.font = CUSNEwFONT(14);
        _statusLable.textColor = [UIColor colorFromHex:0x222222];
        _statusLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_statusLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithRobSessionData:(RobSessionData *)item{
    _timeLable.text = item.robSessionDisplay;
    if (item.isInRob) {
        self.backgroundColor = [UIColor mainColor];
        _timeLable.textColor = [UIColor whiteColor];
        _statusLable.textColor = [UIColor whiteColor];
        _statusLable.text = @"正在抢购";
    }else{
        self.backgroundColor = [UIColor clearColor];
        _timeLable.textColor = [UIColor colorFromHex:0x222222];
        _statusLable.textColor = [UIColor colorFromHex:0x222222];
        _statusLable.text = @"即将开始";
    }
}

-(void)showWithSeletced:(BOOL)seletced{
    if (seletced) {
        self.backgroundColor = [UIColor mainColor];
        _timeLable.textColor = [UIColor whiteColor];
        _statusLable.textColor = [UIColor whiteColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
        _timeLable.textColor = [UIColor colorFromHex:0x222222];
        _statusLable.textColor = [UIColor colorFromHex:0x222222];
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_timeLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        
        [_statusLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        [_statusLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
