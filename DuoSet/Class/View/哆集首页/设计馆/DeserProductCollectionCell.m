//
//  DeserProductCollectionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DeserProductCollectionCell.h"

@interface DeserProductCollectionCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *productPic;
@property (nonatomic,strong) UILabel *productName;
@property (nonatomic,strong) UIView *markView;
@property (nonatomic,strong) UILabel *sellCount;

@end

@implementation DeserProductCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _productPic = [UIImageView newAutoLayoutView];
        _productPic.contentMode = UIViewContentModeScaleAspectFill;
        _productPic.layer.masksToBounds = true;
        [self.contentView addSubview:_productPic];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = CUSFONT(14);
        _productName.textAlignment = NSTextAlignmentCenter;
        _productName.numberOfLines = 1;
        [self.contentView addSubview:_productName];
        
        _markView = [UIView newAutoLayoutView];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [_productPic addSubview:_markView];
        
        _sellCount = [UILabel newAutoLayoutView];
        _sellCount.textColor = [UIColor whiteColor];
        _sellCount.textAlignment = NSTextAlignmentCenter;
        _sellCount.font = CUSFONT(14);
        _sellCount.adjustsFontSizeToFitWidth = YES;
        [_markView addSubview:_sellCount];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithDesignerProductData:(DesignerProductData *)item{
    [_productPic sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productName.text = item.name;
    _sellCount.text = [NSString stringWithFormat:@"已售%@件",item.sellCount];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productPic autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productPic autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productPic autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productPic autoSetDimension:ALDimensionHeight toSize:FitHeight(370.0)];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productPic];
        
        [_markView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_markView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_markView autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        [_markView autoSetDimension:ALDimensionWidth toSize:FitWith(110.0)];
        
        [_sellCount autoPinEdgesToSuperviewEdges];
        
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
