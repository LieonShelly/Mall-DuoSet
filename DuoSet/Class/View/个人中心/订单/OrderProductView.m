//
//  OrderProductView.m
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "OrderProductView.h"

@interface OrderProductView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *productSubLable;
@property(nonatomic,strong) UILabel *countSubLable;

@end

@implementation OrderProductView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xfef9f5];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.layer.borderWidth = 0.5;
        _productImgV.layer.borderColor = [UIColor colorFromHex:0xe8e8e8].CGColor;
        _productImgV.image = [UIImage imageNamed:@"替代11"];
        [self addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.numberOfLines = 2;
        _productName.font = CUSFONT(12);
        [self addSubview:_productName];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.textColor = [UIColor colorFromHex:0x999999];
        _productSubLable.font = CUSFONT(11);
        [self addSubview:_productSubLable];
        
        _countSubLable = [UILabel newAutoLayoutView];
        _countSubLable.textColor = [UIColor colorFromHex:0x999999];
        _countSubLable.font = CUSFONT(11);
        [self addSubview:_countSubLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithOrderProduct:(DuojiOrderProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.productName;
    _productSubLable.text = item.propertyName;
    _countSubLable.text = [NSString stringWithFormat:@"￥%@ X %@",[NSString stringWithFormat:@"%.2lf",item.price.floatValue],item.count];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(35.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(135.0)];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        
        [_productSubLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_productSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productName withOffset:FitHeight(10.0)];
        
        [_countSubLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_countSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productSubLable withOffset:FitHeight(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
