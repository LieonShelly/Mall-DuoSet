//
//  BrownRecordsFootView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BrownRecordsFootView.h"

@interface BrownRecordsFootView()

@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;
@property(nonatomic,strong) UIButton *button3;
@property(nonatomic,strong) NSArray *btnArr;

@property(nonatomic,strong) UILabel *amountTipLable;
@property(nonatomic,strong) UIButton *gotoPayBtn;

@end

@implementation BrownRecordsFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self addSubview:line];
        
        _allSelectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(10.0), 0, FitWith(130.0), frame.size.height)];
        _allSelectedBtn.tag = 0;
        _allSelectedBtn.titleLabel.font = CUSFONT(13);
        [_allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_allSelectedBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_allSelectedBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        [_allSelectedBtn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [_allSelectedBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        _allSelectedBtn.tag = 0;
        [self addSubview:_allSelectedBtn];
        
        _gotoPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(150.0), 0, FitWith(150.0), frame.size.height)];
        _gotoPayBtn.tag = 1;
        _gotoPayBtn.backgroundColor = [UIColor mainColor];
        _gotoPayBtn.titleLabel.font = CUSFONT(12);
        [_gotoPayBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_gotoPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_gotoPayBtn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_gotoPayBtn];
    }
    return self;
}

-(void)bottomBtnsAction:(UIButton *)btn{
    BottomButtonAcitonBlock block = _buttonActionHandle;
    if (block) {
        block(btn);
    }
}
@end
