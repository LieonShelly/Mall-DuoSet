//
//  FindShareItemCell.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FindShareItemCell.h"

@interface FindShareItemCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *priceLable;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UIButton *unLikeBtn;

@end

@implementation FindShareItemCell

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
        _productName.numberOfLines = 1;
        _productName.font = CUSFONT(11);
        [_bgView addSubview:_productName];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.text = @"￥289.00";
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.font = CUSFONT(11);
        [_bgView addSubview:_priceLable];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSFONT(10.0);
        [_likeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        [_likeBtn setTitle:@"123" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"赞png"] forState:UIControlStateNormal];
        [_bgView addSubview:_likeBtn];
        
        _unLikeBtn = [UIButton newAutoLayoutView];
        _unLikeBtn.titleLabel.font = CUSFONT(10.0);
        [_unLikeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -5)];
        [_unLikeBtn setTitle:@"3" forState:UIControlStateNormal];
        [_unLikeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_unLikeBtn setImage:[UIImage imageNamed:@"踩png"] forState:UIControlStateNormal];
        [_bgView addSubview:_unLikeBtn];
        
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

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(80.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(90.0)];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(20.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_priceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        [_likeBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(450.0)];
        [_likeBtn autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_likeBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_unLikeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_likeBtn];
        [_unLikeBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_likeBtn withOffset:FitWith(20.0)];
        [_unLikeBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_likeBtn];
        [_unLikeBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_likeBtn];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}



@end
