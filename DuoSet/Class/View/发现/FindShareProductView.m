//
//  FindShareProductView.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FindShareProductView.h"

@interface FindShareProductView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *productSubLable;

@end

@implementation FindShareProductView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xfef9f5];
        
//        _bgView = [UIView newAutoLayoutView];
//        _bgView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
//        [self addSubview:_bgView];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.layer.borderWidth = 0.5;
        _productImgV.layer.borderColor = [UIColor colorFromHex:0xa09f9d].CGColor;
        _productImgV.image = [UIImage imageNamed:@"替代11"];
        [self addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.text = @"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的商品名字";
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.numberOfLines = 2;
        _productName.font = CUSFONT(11);
        [self addSubview:_productName];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.text = @"颜色 :白色";
        _productSubLable.textColor = [UIColor colorFromHex:0xa09f9d];
        _productSubLable.font = CUSFONT(10);
        [self addSubview:_productSubLable];
        
        [self updateConstraints];
    }
    return self;
}

//-(void)setupInfoWithOrderProduct:(OrderProduct *)item{
//    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.productSmallImg] placeholderImage:[UIImage imageNamed:@""] options:0];
//    _productName.text = item.productName;
//    _productSubLable.text = item.standard;
//}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
//        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
//        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(25.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(120.0)];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        
        [_productSubLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_productSubLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
