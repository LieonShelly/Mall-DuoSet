//
//  OrderDetailsProductView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailsProductView.h"

@interface OrderDetailsProductView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *subLable;
@property(nonatomic,strong) UILabel *productCountLable;

@end

@implementation OrderDetailsProductView

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
        _productName.font = CUSNEwFONT(16);
        [self addSubview:_productName];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor colorFromHex:0x212121];
        _priceLable.font = CUSNEwFONT(18);
        _priceLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:_priceLable];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        _subLable.font = CUSNEwFONT(14);
        _subLable.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_subLable];
        
        _productCountLable = [UILabel newAutoLayoutView];
        _productCountLable.textColor = [UIColor colorFromHex:0x808080];
        _productCountLable.font = CUSNEwFONT(14);
        _productCountLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:_productCountLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithOrderProduct:(DuojiOrderProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.productName;
    _subLable.text = item.propertyName;
    _productCountLable.text = [NSString stringWithFormat:@"X %@",item.count];
    NSString *text = [NSString stringWithFormat:@"￥%.2lf",item.price.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 1) {
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(11) range:NSMakeRange(0, 1)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x212121] range:NSMakeRange(0, 1)];
    }
   _priceLable.attributedText = attributeString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(142.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitWith(142.0)];
        [_productImgV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(180.0)];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV withOffset:FitHeight(10.0)];
        
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_priceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productName];
        
        [_subLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        [_subLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        
        [_productCountLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_priceLable];
        [_productCountLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
