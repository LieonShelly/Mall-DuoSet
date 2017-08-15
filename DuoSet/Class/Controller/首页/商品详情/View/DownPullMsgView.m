//
//  DownPullMsgView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DownPullMsgView.h"

@implementation DownPullMsgView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, frame.size.height)];
        btn.titleLabel.font = CUSNEwFONT(14.0);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -FitWith(40.0), 0, 0);
        [btn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
        [btn setTitle:@"下拉收起图文详情" forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    return self;
}

@end
