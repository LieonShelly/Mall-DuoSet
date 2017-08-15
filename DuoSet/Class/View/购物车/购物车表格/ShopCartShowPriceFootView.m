//
//  ShopCartShowPriceFootView.m
//  DuoSet
//
//  Created by fanfans on 2017/6/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartShowPriceFootView.h"

@interface ShopCartShowPriceFootView()

@property(nonatomic,strong) UILabel *allPriceLable;
@property(nonatomic,strong) UILabel *allCarryPriceLable;

@end

@implementation ShopCartShowPriceFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self addSubview:line];
        
        _allSelectedBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(10.0), 0, FitWith(130.0), frame.size.height)];
        _allSelectedBtn.titleLabel.font = CUSFONT(13);
        [_allSelectedBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_allSelectedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_allSelectedBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_allSelectedBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        [_allSelectedBtn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [_allSelectedBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        [self addSubview:_allSelectedBtn];
        
        _allPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(_allSelectedBtn.frame.origin.x + _allSelectedBtn.frame.size.width, 0, mainScreenWidth - FitWith(10) - FitWith(130.0) - FitWith(200.0) , frame.size.height * 0.5)];
        _allPriceLable.textColor = [UIColor mainColor];
        _allPriceLable.textAlignment = NSTextAlignmentRight;
        _allPriceLable.font = CUSNEwFONT(18);
        [self addSubview:_allPriceLable];
        
        _allCarryPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(_allSelectedBtn.frame.origin.x + _allSelectedBtn.frame.size.width, frame.size.height * 0.5, mainScreenWidth - FitWith(10) - FitWith(130.0) - FitWith(200.0) , frame.size.height * 0.5)];
        _allCarryPriceLable.textColor = [UIColor colorFromHex:0x212121];
        _allCarryPriceLable.textAlignment = NSTextAlignmentRight;
        _allCarryPriceLable.font = CUSNEwFONT(13);
        [self addSubview:_allCarryPriceLable];
        
        _gotoPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(180.0), 0, FitWith(180.0), frame.size.height)];
        _gotoPayBtn.backgroundColor = [UIColor mainColor];
        _gotoPayBtn.titleLabel.font = CUSNEwFONT(18);
        _gotoPayBtn.titleLabel.adjustsFontSizeToFitWidth = true;
        [_gotoPayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_gotoPayBtn addTarget:self action:@selector(goPayBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_gotoPayBtn];
    }
    return self;
}

-(void)setupInfoWithShopCartSelectInfo:(ShopCartSelectInfo *)item{
    _allSelectedBtn.selected = item.isSelectAll;
    [_gotoPayBtn setTitle:[NSString stringWithFormat:@"去结算(%@)",item.selectCount] forState:UIControlStateNormal];
    
    NSString *text = [NSString stringWithFormat:@"合计：￥%@",item.allPrice];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(14) range:NSMakeRange(0,3)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x212121] range:NSMakeRange(0,3)];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(15) range:NSMakeRange(3,1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(3,1)];
    _allPriceLable.attributedText = attributeString;
    if (item.allCarryPrice.floatValue == 0.0) {
        _allCarryPriceLable.text = @"免运费";
    }else{
        _allCarryPriceLable.textColor = [UIColor mainColor];
        NSString *text = [NSString stringWithFormat:@"运费：￥%@",item.allCarryPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(13) range:NSMakeRange(0,3)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x212121] range:NSMakeRange(0,3)];
        [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(16) range:NSMakeRange(3,text.length - 3)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(3,text.length - 3)];
        _allCarryPriceLable.attributedText = attributeString;
    }
}

-(void)bottomBtnsAction:(UIButton *)btn{
    AllSelecteBtnActionBlock block = _priceAllHandle;
    if (block) {
        block(btn);
    }
}

-(void)goPayBtnAction{
    GotoPayBlock block = _gotoPayHandle;
    if (block) {
        block();
    }
}

@end
