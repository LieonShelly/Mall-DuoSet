//
//  CouponHeaderView.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "CouponHeaderView.h"

@interface CouponHeaderView()

@property (nonatomic,strong) NSMutableArray *btnArr;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation CouponHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    self.backgroundColor = [UIColor whiteColor];
    _btnArr = [NSMutableArray array];
    
    _unUseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth * .5, FitHeight(90.0))];
    [_unUseBtn setTitle:@"未使用" forState:UIControlStateNormal];
    [_unUseBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_unUseBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
    _unUseBtn.titleLabel.font = CUSFONT(13);
    _unUseBtn.tag = 0;
    [_unUseBtn addTarget:self action:@selector(btnTapAciton:) forControlEvents:UIControlEventTouchUpInside];
    _unUseBtn.selected = true;
    [self addSubview:_unUseBtn];
    [_btnArr addObject:_unUseBtn];
    
    _expireEBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth * .5, 0, mainScreenWidth * .5, FitHeight(90.0))];
    [_expireEBtn setTitle:@"已过期" forState:UIControlStateNormal];
    [_expireEBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [_expireEBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
    _expireEBtn.titleLabel.font = CUSFONT(13);
    _expireEBtn.tag = 1;
    [_expireEBtn addTarget:self action:@selector(btnTapAciton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_expireEBtn];
    [_btnArr addObject:_expireEBtn];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(FitWith(110.0), FitHeight(80.0), FitWith(150.0), 2)];
    _lineView.backgroundColor = [UIColor mainColor];
    [self addSubview:_lineView];
    
}

-(void)btnTapAciton:(UIButton *)btn{
    CouponHeaderViewTapBlock block = _headerBtnActionHandle;
    if (block) {
        block(btn.tag);
    }
    
    if (btn.tag == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _lineView.frame;
            frame.origin.x = FitWith(110.0);
            _lineView.frame = frame;
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _lineView.frame;
            frame.origin.x = FitWith(490.0);
            _lineView.frame = frame;
        } completion:nil];
    }
    for (UIButton *b in _btnArr) {
        b.selected = btn.tag == b.tag;
    }
}

-(void)setBtnChangeWithIndex:(NSInteger)index{
    if (index == 0) {
        _unUseBtn.selected = true;
        _expireEBtn.selected = false;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _lineView.frame;
            frame.origin.x = FitWith(110.0);
            _lineView.frame = frame;
        } completion:nil];
    }else{
        _expireEBtn.selected = true;
        _unUseBtn.selected = false;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = _lineView.frame;
            frame.origin.x = FitWith(490.0);
            _lineView.frame = frame;
        } completion:nil];
    }
}

@end
