//
//  ReturnAndChangeProductCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeProductCell.h"

@interface ReturnAndChangeProductCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *productSubLable;


@end

@implementation ReturnAndChangeProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xffffff];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.layer.borderWidth = 0.5;
        _productImgV.layer.borderColor = [UIColor colorFromHex:0xa09f9d].CGColor;
        _productImgV.image = [UIImage imageNamed:@"替代11"];
        [self addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.text = @"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的商品名字";
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.numberOfLines = 1;
        _productName.font = CUSFONT(11);
        [self addSubview:_productName];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.text = @"数量 : X1";
        _productSubLable.textColor = [UIColor colorFromHex:0xa09f9d];
        _productSubLable.font = CUSFONT(10);
        [self addSubview:_productSubLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithDuojiOrderProductData:(DuojiOrderProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.productName;
    _productSubLable.text = [NSString stringWithFormat:@"数量 : X%@",item.count];
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
        [_productSubLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
