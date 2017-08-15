//
//  NavMoreActionView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NavMoreActionView.h"

@implementation NavMoreActionView
//CGRectMake(mainScreenWidth - FitWith(20) - imgW, FitHeight(110.0), imgW, FitHeight(320.0)
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat imgW = FitWith(186.0);
        UIImageView *bgImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imgW, frame.size.height)];
        bgImgV.image = [UIImage imageNamed:@"piazza_more_imgV"];
        bgImgV.userInteractionEnabled = true;
        [self addSubview:bgImgV];
        
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, FitHeight(20.0), imgW, FitHeight(100.0))];
        shareBtn.tag = 0;
        [shareBtn addTarget:self action:@selector(btnActionhandle:) forControlEvents:UIControlEventTouchUpInside];
        [bgImgV addSubview:shareBtn];
        
        UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, shareBtn.frame.origin.y + shareBtn.frame.size.height, imgW, FitHeight(100.0))];
        editBtn.tag = 1;
        [editBtn addTarget:self action:@selector(btnActionhandle:) forControlEvents:UIControlEventTouchUpInside];
        [bgImgV addSubview:editBtn];
        
        UIButton *deletedBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, editBtn.frame.origin.y + editBtn.frame.size.height, imgW, FitHeight(100.0))];
        deletedBtn.tag = 2;
        [deletedBtn addTarget:self action:@selector(btnActionhandle:) forControlEvents:UIControlEventTouchUpInside];
        [bgImgV addSubview:deletedBtn];
        
    }
    return self;
}

-(void)btnActionhandle:(UIButton *)btn{
    NavMoreActionViewActionBlock block = _moreActionHanlde;
    if (block) {
        block(btn.tag);
    }
}


@end
