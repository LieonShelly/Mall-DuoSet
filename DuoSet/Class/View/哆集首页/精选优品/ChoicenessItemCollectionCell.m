//
//  ChoicenessItemCollectionCell.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ChoicenessItemCollectionCell.h"

@interface ChoicenessItemCollectionCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UIView *priceBgView;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *productName;

@end

@implementation ChoicenessItemCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.image = [UIImage imageNamed:@"test_01.jpg"];
        _productImgV.layer.masksToBounds = true;
        _productImgV.layer.cornerRadius = 5;
        [self.contentView addSubview:_productImgV];
        
        _priceBgView = [UIView newAutoLayoutView];
        _priceBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        _priceBgView.layer.masksToBounds = true;
        _priceBgView.layer.cornerRadius = 3;
        [_productImgV addSubview:_priceBgView];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.text = @"￥369.00";
        _priceLable.textColor = [UIColor whiteColor];
        _priceLable.font = CUSFONT(13);
        _priceLable.textAlignment = NSTextAlignmentCenter;
        [_priceBgView addSubview:_priceLable];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x333333];
        _productName.textAlignment = NSTextAlignmentLeft;
        _productName.numberOfLines = 2;
        _productName.font = CUSFONT(12);
        _productName.text = @"我不会告诉你，这是一件最新最显瘦的连衣裙哦";
        [self.contentView addSubview:_productName];
        
        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(510.0)];
        
        [_priceBgView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        [_priceBgView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_productImgV];
        [_priceBgView autoSetDimension:ALDimensionWidth toSize:FitWith(160.0)];
        [_priceBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_priceLable autoPinEdgesToSuperviewEdges];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productImgV withOffset:FitHeight(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
