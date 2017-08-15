//
//  GarmentMatchListCell.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GarmentMatchListCell.h"

@interface GarmentMatchListCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UIView *priceBgView;
@property(nonatomic,strong) UIButton *likedBtn;
@property(nonatomic,strong) UILabel *productName;

@end

@implementation GarmentMatchListCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
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
        
        _likedBtn = [UIButton newAutoLayoutView];
        _likedBtn.titleLabel.font = CUSFONT(9);
        [_likedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_likedBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_likedBtn setTitle:@"123" forState:UIControlStateNormal];
        [_priceBgView addSubview:_likedBtn];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x333333];
        _productName.textAlignment = NSTextAlignmentCenter;
        _productName.numberOfLines = 1;
        _productName.font = CUSFONT(11);
        _productName.text = @"潮流单品搭配";
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
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(50.0)];
        
        [_priceBgView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV withOffset:-FitHeight(10.0)];
        [_priceBgView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_productImgV withOffset:-FitWith(10.0)];
        [_priceBgView autoSetDimension:ALDimensionWidth toSize:FitWith(100.0)];
        [_priceBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
        
        [_likedBtn autoPinEdgesToSuperviewEdges];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productImgV withOffset:5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
