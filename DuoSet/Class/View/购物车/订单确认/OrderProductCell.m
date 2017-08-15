//
//  OrderProductCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderProductCell.h"

@interface OrderProductCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIButton *selectedBtn;
@property (nonatomic,strong) UIImageView *productImgV;
@property (nonatomic,strong) UILabel *productNameLable;
@property (nonatomic,strong) UILabel *productCountLable;
@property (nonatomic,strong) UILabel *standardLabel;
@property (nonatomic,strong) UILabel *productPriceLable;
@property (nonatomic,strong) UILabel *productAmountLable;
@property (nonatomic,strong) ShopCarModel *item;

@end

@implementation OrderProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.layer.masksToBounds = true;
        [_bgView addSubview:_productImgV];
        
        _productNameLable = [UILabel newAutoLayoutView];
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _productNameLable.numberOfLines = 2;
        _productNameLable.font = CUSNEwFONT(15);
        [_bgView addSubview:_productNameLable];
        
        _standardLabel = [UILabel newAutoLayoutView];
        _standardLabel.textColor = [UIColor colorFromHex:0x808080];
        _standardLabel.font = CUSNEwFONT(14);
        [_bgView addSubview:_standardLabel];
        
        _productCountLable = [UILabel newAutoLayoutView];
        _productCountLable.textColor = [UIColor colorFromHex:0x808080];
        _productCountLable.font = CUSNEwFONT(14);
        _productCountLable.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_productCountLable];
        
        _productPriceLable = [UILabel newAutoLayoutView];
        _productPriceLable.textColor = [UIColor mainColor];
        _productPriceLable.font = CUSNEwFONT(18);
        _productPriceLable.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_productPriceLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setUpdataInfoWithShopCarModel:(ShopCarModel *)item{
    _item = item;
    _productNameLable.text = item.productName;
    _productPriceLable.text = [NSString stringWithFormat:@"￥ %@",item.price];
    _standardLabel.text = item.propertyName;
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
}

-(void)setUpdataInfoWithShopCarSureProduct:(ShopCarSureProduct *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _productNameLable.text = item.productName;
    _productCountLable.text = [NSString stringWithFormat:@"X%@",item.count];
    _standardLabel.text = item.properties;
    
    NSString *text = [NSString stringWithFormat:@"￥ %@",item.price];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(15) range:NSMakeRange(0,1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _productPriceLable.attributedText = attributeString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(182.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitWith(182.0)];
        
        [_productNameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productNameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_standardLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productNameLable];
        [_standardLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productNameLable withOffset:FitHeight(16)];
        
        [_productCountLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_standardLabel];
        [_productCountLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_productPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productNameLable];
        [_productPriceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
