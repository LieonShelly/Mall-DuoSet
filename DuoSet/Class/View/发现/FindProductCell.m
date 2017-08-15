//
//  FindProductCell.m
//  DuoSet
//
//  Created by mac on 2017/1/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FindProductCell.h"

@interface FindProductCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *productSubLable;

@end

@implementation FindProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.layer.borderWidth = 0.5;
        _productImgV.layer.borderColor = [UIColor colorFromHex:0xa09f9d].CGColor;
        _productImgV.image = [UIImage imageNamed:@"替代11"];
        [_bgView addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.text = @"很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的商品名字";
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.numberOfLines = 2;
        _productName.font = CUSFONT(11);
        [_bgView addSubview:_productName];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.text = @"￥289.00";
        _productSubLable.textColor = [UIColor mainColor];
        _productSubLable.font = CUSFONT(11);
        [_bgView addSubview:_productSubLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

//-(void)setupInfoWithShopCarModel:(ShopCarModel *)item{
//    _item = item;
//    _numBtn.currentNumber = item.amount.integerValue;
//    _productNameLable.text = item.productName;
//    _productPriceLable.text = item.price;
//    _standardLabel.text = item.standard;
//    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.smallImg] placeholderImage:[UIImage imageNamed:@"数据加载失败"] options:0];
//    _selectedBtn.selected = item.isSelected;
//}

//-(void)selectedBtnAction:(UIButton *)btn{
//    btn.selected = !btn.selected;
//    _item.isSelected = btn.isSelected;
//    SingleProductSeletedBlock block = _productSelectedHandle;
//    if (block) {
//        block();
//    }
//}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(120.0)];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(20.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        
        [_productSubLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_productSubLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
