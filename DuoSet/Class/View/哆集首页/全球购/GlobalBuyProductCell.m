//
//  GlobalBuyProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalBuyProductCell.h"

@interface GlobalBuyProductCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UIButton *addShopCartBtn;

@end

@implementation GlobalBuyProductCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.layer.masksToBounds = true;
        [self.contentView addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = CUSFONT(12);
        _productName.textAlignment = NSTextAlignmentLeft;
        _productName.numberOfLines = 2;
        [self.contentView addSubview:_productName];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.font = CUSFONT(15);
        _priceLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_priceLable];
        
        _addShopCartBtn = [UIButton newAutoLayoutView];
        _addShopCartBtn.titleLabel.font = CUSFONT(11);
        _addShopCartBtn.hidden = true;
        _addShopCartBtn.layer.cornerRadius = 3;
        _addShopCartBtn.layer.masksToBounds = true;
        _addShopCartBtn.backgroundColor = [UIColor mainColor];
        [_addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addShopCartBtn.titleLabel.font = CUSFONT(11);
        _addShopCartBtn.userInteractionEnabled = false;
        [self.contentView addSubview:_addShopCartBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductForListData:(ProductForListData *)item{
    [self.productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(380, 500) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CGImageRef imageRef = image.CGImage;
            CGRect rectEnable = CGRectMake((image.size.width - 380) * 0.5, 0 ,380,500);
            CGImageRef imageRefRectEnable = CGImageCreateWithImageInRect(imageRef, rectEnable);
            UIImage *newImageEnable = [[UIImage alloc] initWithCGImage:imageRefRectEnable];
            self.productImgV.image = newImageEnable;
        }
    }];
    _productName.text = item.productName;
    _priceLable.text = [NSString stringWithFormat:@"￥%@",item.price];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(496.0)];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productImgV withOffset:FitHeight(8)];
        
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_addShopCartBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_priceLable];
        [_addShopCartBtn autoSetDimension:ALDimensionWidth toSize:FitWith(140.0)];
        [_addShopCartBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        [_addShopCartBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
