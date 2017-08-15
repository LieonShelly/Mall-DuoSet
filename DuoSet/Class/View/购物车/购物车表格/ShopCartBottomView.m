//
//  ShopCartBottomView.m
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartBottomView.h"

@interface ShopCartBottomView()

@property(nonatomic,strong) UIButton *button1;
@property(nonatomic,strong) UIButton *button2;
@property(nonatomic,strong) UIButton *button3;
@property(nonatomic,strong) NSArray *btnArr;
@property(nonatomic,assign) ShopCartBottomViewStatus status;
//
@property(nonatomic,strong) UILabel *amountTipLable;
@property(nonatomic,strong) UIButton *gotoPayBtn;

@end

@implementation ShopCartBottomView

-(instancetype)initWithFrame:(CGRect)frame andShopCartBottomViewStatus:(ShopCartBottomViewStatus)status{
    self = [super initWithFrame:frame];
    if (self) {
        _status = status;
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
        
        _button1 = [[UIButton alloc]init];
        _button2 = [[UIButton alloc]init];
        _button3 = [[UIButton alloc]init];
        
        _btnArr = @[_button1,_button2,_button3];
        NSArray *nameArr = @[@"退换货",@"评价晒单",@"再次购买"];
        for (int i = 0; i < _btnArr.count; i++) {
            UIButton *btn = _btnArr[i];
            btn.frame = CGRectMake(FitWith(310.0) + (FitWith(120.0) + FitWith(25.0)) * i, FitHeight(20.0), FitWith(130.0), FitHeight(60.0));
            btn.tag = i + 1;
            btn.titleLabel.font = CUSFONT(13);
            btn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
            [btn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
            btn.layer.borderWidth = 0.5;
            btn.layer.cornerRadius = 2;
            [btn setTitle:nameArr[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
        
        if (_status == BottomViewShowStyleAmountForMoney) {
            _button1.hidden = true;
            _button2.hidden = true;
            _button3.hidden = true;
        }
        
        _amountTipLable = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth *.4, 0, FitWith(100.0), frame.size.height)];
        _amountTipLable.textColor = [UIColor colorFromHex:0x333333];
        _amountTipLable.text = @"合计：";
        _amountTipLable.textAlignment = NSTextAlignmentLeft;
        _amountTipLable.font = CUSFONT(12);
        [self addSubview:_amountTipLable];
        
        _allPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(_amountTipLable.frame.origin.x + _amountTipLable.frame.size.width, 0, FitWith(420.0), frame.size.height)];
        _allPriceLable.textColor = [UIColor colorFromHex:0x333333];
        _allPriceLable.textAlignment = NSTextAlignmentLeft;
        _allPriceLable.font = CUSFONT(12);
        _allPriceLable.text = @"￥ 0";
        [self addSubview:_allPriceLable];
        
        _gotoPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(150.0), 0, FitWith(150.0), frame.size.height)];
        _gotoPayBtn.backgroundColor = [UIColor mainColor];
        _gotoPayBtn.titleLabel.font = CUSFONT(12);
        [_gotoPayBtn setTitle:@"去结算" forState:UIControlStateNormal];
        [_gotoPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_gotoPayBtn addTarget:self action:@selector(goPayBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_gotoPayBtn];
    }
    return self;
}

-(void)resetShopCartBottomViewStatus:(ShopCartBottomViewStatus)status{
    _status = status;
    if (_status == BottomViewShowStyleAmountForMoney) {
        _button1.hidden = true;
        _button2.hidden = true;
        _button3.hidden = true;
        _amountTipLable.hidden = false;
        _allPriceLable.hidden = false;
        _gotoPayBtn.hidden = false;
    }else{
        _button1.hidden = true;
        _button2.hidden = true;
        _button3.hidden = false;
        [_button3 setTitle:@"删除" forState:UIControlStateNormal];
        _button3.layer.borderColor = [UIColor mainColor].CGColor;
        [_button3 setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _amountTipLable.hidden = true;
        _allPriceLable.hidden = true;
        _gotoPayBtn.hidden = true;
    }
}

-(void)goPayBtnAction{
    BottomPayActionBlock block = _payActionHandle;
    if (block) {
        block();
    }
}

-(void)bottomBtnsAction:(UIButton *)btn{
    if (btn.tag == 0) {
        btn.selected = !btn.selected;
    }
    BottomBtnsActionBlock block = _btnActionHandle;
    if (block) {
        block(btn);
    }
}

@end
