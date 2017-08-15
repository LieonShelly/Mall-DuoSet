//
//  ChoicenessProduct.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ChoicenessProduct.h"

@interface ChoicenessProduct()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *priceLable;

@end

@implementation ChoicenessProduct

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _productImgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(30.0), FitHeight(30.0), FitWith(120.0), FitWith(120.0))];
        _productImgV.layer.masksToBounds = true;
        _productImgV.layer.cornerRadius = 5;
        [self addSubview:_productImgV];
        
        _priceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, _productImgV.frame.origin.y +_productImgV.frame.size.height + FitHeight(10.0), _productImgV.frame.size.width, 30.0)];
        _priceLable.textColor = [UIColor colorFromHex:0x333333];
        _priceLable.textAlignment = NSTextAlignmentCenter;
        _priceLable.text = @"￥169";
        _priceLable.font = CUSFONT(10);
        [self addSubview:_priceLable];
    }
    return self;
}

@end
