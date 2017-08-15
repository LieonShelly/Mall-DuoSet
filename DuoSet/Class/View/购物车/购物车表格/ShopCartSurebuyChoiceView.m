//
//  ShopCartSurebuyChoiceView.m
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartSurebuyChoiceView.h"

@interface ShopCartSurebuyChoiceView()

@property(nonatomic,strong) UIButton *globalBtn;
@property(nonatomic,strong) UIButton *otherBtn;

@end

@implementation ShopCartSurebuyChoiceView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = true;
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, FitWith(600.0), FitHeight(80.0))];
        title.text = @"请分开结算以下商品";
        title.font = CUSNEwFONT(18);
        title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:title];
        
        _globalBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(30.0), FitHeight(86.0), FitWith(570.0), FitHeight(80.0))];
        [_globalBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_globalBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_globalBtn setImage:nil forState:UIControlStateHighlighted];
        [_globalBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [_globalBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_globalBtn addTarget:self action:@selector(choiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _globalBtn.titleEdgeInsets = UIEdgeInsetsMake(0, FitWith(20.0), 0, 0);
        _globalBtn.selected = true;
        _globalBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _globalBtn.titleLabel.font = CUSNEwFONT(16);
        [self addSubview:_globalBtn];
        
        _otherBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(30.0), _globalBtn.frame.origin.y + _globalBtn.frame.size.height,  FitWith(570.0), FitHeight(80.0))];
        [_otherBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_otherBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_otherBtn setImage:nil forState:UIControlStateHighlighted];
        [_otherBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [_otherBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_otherBtn addTarget:self action:@selector(choiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _otherBtn.titleEdgeInsets = UIEdgeInsetsMake(0, FitWith(20.0), 0, 0);
        _otherBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _otherBtn.titleLabel.font = CUSNEwFONT(16);
        [self addSubview:_otherBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, FitHeight(370.0) - FitHeight(90.0), FitWith(300.0), 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:line];
        
        UIButton *backToShopCart = [[UIButton alloc]initWithFrame:CGRectMake(0, FitHeight(370.0) - FitHeight(90.0), FitWith(300.0), FitHeight(90.0))];
        backToShopCart.titleLabel.font = CUSNEwFONT(16);
        [backToShopCart setTitle:@"返回购物车" forState:UIControlStateNormal];
        [backToShopCart setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        backToShopCart.tag = 0;
        [backToShopCart addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backToShopCart];
        
        UIButton *goBuy = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(300.0), backToShopCart.frame.origin.y, FitWith(300.0), FitHeight(90.0))];
        goBuy.backgroundColor = [UIColor mainColor];
        goBuy.titleLabel.font = CUSNEwFONT(16);
        [goBuy setTitle:@"去结算" forState:UIControlStateNormal];
        [goBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        goBuy.tag = 1;
        [goBuy addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goBuy];
    }
    return self;
}

-(void)setupInfoWithGlobalCount:(NSInteger)globalCount andOtherCount:(NSInteger)otherCount{
    [_globalBtn setTitle:[NSString stringWithFormat:@"全球购商品 共%ld件",globalCount] forState:UIControlStateNormal];
    [_otherBtn setTitle:[NSString stringWithFormat:@"其他商品 共%ld件",otherCount] forState:UIControlStateNormal];
}

-(void)choiceBtnAction:(UIButton *)btn{
    _globalBtn.selected = btn == _globalBtn;
    _otherBtn.selected = !_globalBtn.selected;
}

-(void)commitAction:(UIButton *)btn{
    ShopCartSurebuyChoiceViewBtnActionBlock block = _chioceHandle;
    if (block) {
        block(btn.tag,_globalBtn.selected);
    }
}

@end
