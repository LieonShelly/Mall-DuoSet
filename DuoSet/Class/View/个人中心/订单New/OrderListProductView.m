//
//  OrderListProductView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderListProductView.h"

@interface OrderListProductView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;

@end

@implementation OrderListProductView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xfafafa];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.layer.cornerRadius = 6;
        _productImgV.layer.masksToBounds = true;
        [self addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x212121];
        _productName.numberOfLines = 2;
        _productName.font = CUSFONT(12);
        [self addSubview:_productName];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithOrderProduct:(DuojiOrderProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.productName;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(142.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitWith(142.0)];
        [_productImgV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV withOffset:FitHeight(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
