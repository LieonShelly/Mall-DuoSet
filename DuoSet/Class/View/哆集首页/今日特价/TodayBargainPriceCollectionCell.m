//
//  TodayBargainPriceCollectionCell.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TodayBargainPriceCollectionCell.h"

@interface TodayBargainPriceCollectionCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *productPrice;
@property(nonatomic,strong) UILabel *originalPrice;
@property(nonatomic,strong) UIButton *buyButtion;

@end

@implementation TodayBargainPriceCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.image = [UIImage imageNamed:@"test_01.jpg"];
        [self.contentView addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x333333];
        _productName.textAlignment = NSTextAlignmentLeft;
        _productName.numberOfLines = 1;
        _productName.font = CUSFONT(12);
        _productName.text = @"MS彩妆组合套装初学者必备东西哦";
        [self.contentView addSubview:_productName];
        
        _productPrice = [UILabel newAutoLayoutView];
        _productPrice.textColor = [UIColor mainColor];
        _productPrice.textAlignment = NSTextAlignmentLeft;
        _productPrice.numberOfLines = 1;
        _productPrice.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _productPrice.text = @"￥ 169.00";
        [self.contentView addSubview:_productPrice ];
        
        _originalPrice = [UILabel newAutoLayoutView];
        _originalPrice.textColor = [UIColor colorFromHex:0x666666];
        _originalPrice.textAlignment = NSTextAlignmentLeft;
        _originalPrice.font = CUSFONT(10);
        _originalPrice.text = @"￥ 169.00";
        [self.contentView addSubview:_originalPrice];
        
        _buyButtion = [UIButton newAutoLayoutView];
        _buyButtion.backgroundColor = [UIColor mainColor];
        _buyButtion.titleLabel.font = CUSFONT(12);
        [_buyButtion setTitle:@"立即抢购" forState:UIControlStateNormal];
        [_buyButtion setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyButtion.userInteractionEnabled = false;
        [self.contentView addSubview:_buyButtion];

        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(450.0)];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productImgV withOffset:FitHeight(10.0)];
        
        [_productPrice autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_productPrice autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productName withOffset:FitHeight(10.0)];
        
        [_originalPrice autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productPrice withOffset:FitWith(30.0)];
        [_originalPrice autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPrice];
        
        [_buyButtion autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(40.0)];
        [_buyButtion autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(40.0)];
        [_buyButtion autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productPrice withOffset:FitHeight(10.0)];
        [_buyButtion autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
