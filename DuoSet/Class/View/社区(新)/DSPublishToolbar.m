//
//  DSPublishToolbar.m
//  DuoSet
//
//  Created by HuangChao on 2017/5/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DSPublishToolbar.h"

@implementation DSPublishToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
//        UIButton *emojiBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0.0f, 44, 44)];
//        [emojiBtn setImage:[UIImage imageNamed:@"piazz_publish_emoji"] forState:UIControlStateNormal];
//        emojiBtn.tag = 0;
//        [emojiBtn addTarget:self action:@selector(btnaACtionHandleWithBtn:)
//           forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:emojiBtn];
        
        UIButton *bugbagBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0.0f, 44, 44)];
//        UIButton *bugbagBtn = [[UIButton alloc] initWithFrame:CGRectMake(64, 0.0f, 44, 44)];
        [bugbagBtn setImage:[UIImage imageNamed:@"piazz_publish_bugbag"] forState:UIControlStateNormal];
        bugbagBtn.tag = 1;
        [bugbagBtn addTarget:self action:@selector(btnaACtionHandleWithBtn:)
            forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:bugbagBtn];
        
        UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(64, 0.0f, 44, 44)];
//        UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(118, 0.0f, 44, 44)];
        [picBtn setImage:[UIImage imageNamed:@"piazz_publish_pic"] forState:UIControlStateNormal];
        picBtn.tag = 2;
        [picBtn addTarget:self action:@selector(btnaACtionHandleWithBtn:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:picBtn];
    }
    return self;
}

-(void)btnaACtionHandleWithBtn:(UIButton *)btn{
    DSPublishToolbarBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(btn);
    }
}

@end
