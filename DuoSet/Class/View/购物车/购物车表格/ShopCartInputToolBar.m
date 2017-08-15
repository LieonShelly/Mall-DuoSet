//
//  ShopCartInputToolBar.m
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartInputToolBar.h"

@implementation ShopCartInputToolBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        self.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenView)];
        [self addGestureRecognizer:tap];
        
        UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0), 0, 44, 44)];
        cancelBtn.titleLabel.font = CUSNEwFONT(17);
        cancelBtn.tag = 0;
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(toolbarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44 - FitWith(24.0), 0, 44, 44)];
        doneBtn.titleLabel.font = CUSNEwFONT(17);
        doneBtn.tag = 1;
        [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(toolbarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneBtn];
    }
    return self;
}

-(void)toolbarBtnAction:(UIButton *)btn{
    ShopCartInputToolBarBtnACtionBlock block = _btnActionHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)hiddenView{
    ShopCartInputToolBarBtnACtionBlock block = _btnActionHandle;
    if (block) {
        block(0);
    }
}

@end
