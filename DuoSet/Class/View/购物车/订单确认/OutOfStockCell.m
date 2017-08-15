//
//  OutOfStockCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OutOfStockCell.h"

@interface OutOfStockCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@property (nonatomic,strong) UIImageView *productImgV;
@property (nonatomic,strong) UIView *markView;
@property (nonatomic,strong) UILabel *selloutLable;
@property (nonatomic,strong) UILabel *productName;

@end

@implementation OutOfStockCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.layer.cornerRadius = 2;
        _productImgV.layer.masksToBounds = true;
        [self.contentView addSubview:_productImgV];
        
        _markView = [UIView newAutoLayoutView];
        _markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        _markView.layer.cornerRadius = 42 * 0.5;
        _markView.layer.masksToBounds = true;
        [_productImgV addSubview:_markView];
        
        _selloutLable = [UILabel newAutoLayoutView];
        _selloutLable.textAlignment = NSTextAlignmentCenter;
        _selloutLable.font = [UIFont systemFontOfSize:9];
        _selloutLable.textColor = [UIColor whiteColor];
        _selloutLable.adjustsFontSizeToFitWidth = true;
        [_markView addSubview:_selloutLable];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.numberOfLines = 2;
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_productName];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithSellOutProductData:(SellOutProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(58, 58) options:0];
    _productName.text = item.productName;
    if (item.repertory.integerValue == 0) {
        _selloutLable.text = @"已售罄";
    }else{
        _selloutLable.text = [NSString stringWithFormat:@"仅剩%@件",item.repertory];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:58];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:58];
        [_productImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_markView autoSetDimension:ALDimensionWidth toSize:42];
        [_markView autoSetDimension:ALDimensionHeight toSize:42];
        [_markView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_markView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_selloutLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_selloutLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_productName autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:12];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
