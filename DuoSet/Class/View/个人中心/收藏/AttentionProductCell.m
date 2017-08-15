//
//  AttentionProductCell.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AttentionProductCell.h"

@interface AttentionProductCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *productImgV;
@property (nonatomic,strong) UILabel *productNameLable;
@property (nonatomic,strong) UILabel *standardLabel;
@property (nonatomic,strong) UILabel *productPriceLable;
@property (nonatomic,strong) UIButton *addShopCartBtn;
@property (nonatomic,strong) UIButton *findSameBtn;

@end

@implementation AttentionProductCell- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.image = [UIImage imageNamed:@"替代11"];
        [_bgView addSubview:_productImgV];
        
        _productNameLable = [UILabel newAutoLayoutView];
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _productNameLable.numberOfLines = 2;
        _productNameLable.font = CUSFONT(13);
        [_bgView addSubview:_productNameLable];
        
        _standardLabel = [UILabel newAutoLayoutView];
        _standardLabel.textColor = [UIColor colorFromHex:0xa09f9d];
        _standardLabel.font = CUSFONT(11);
        [_bgView addSubview:_standardLabel];
        
        _productPriceLable = [UILabel newAutoLayoutView];
        _productPriceLable.textColor = [UIColor mainColor];
        _productPriceLable.text = @"¥ 320";
        _productPriceLable.font = CUSFONT(18);
        _productPriceLable.textAlignment = NSTextAlignmentRight;
        [_bgView addSubview:_productPriceLable];
        
        _addShopCartBtn = [UIButton newAutoLayoutView];
        _addShopCartBtn.layer.borderWidth = 1;
        _addShopCartBtn.layer.borderColor = [UIColor colorFromHex:0x666666].CGColor;
        _addShopCartBtn.layer.cornerRadius = 2;
        _addShopCartBtn.layer.masksToBounds = true;
        _addShopCartBtn.titleLabel.font = CUSFONT(11);
        _addShopCartBtn.tag = 0;
        [_addShopCartBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addShopCartBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_addShopCartBtn];
        
//        _findSameBtn = [UIButton newAutoLayoutView];
//        _findSameBtn.layer.borderWidth = 0.5;
//        _findSameBtn.layer.borderColor = [UIColor colorFromHex:0xe4e4e4].CGColor;
//        _findSameBtn.layer.cornerRadius = 2;
//        _findSameBtn.layer.masksToBounds = true;
//        _findSameBtn.titleLabel.font = CUSFONT(9);
//        _findSameBtn.tag = 1;
//        [_findSameBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
//        [_findSameBtn setTitle:@"找相似" forState:UIControlStateNormal];
//        [_findSameBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_bgView addSubview:_findSameBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductListData:(ProductListData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(150, 150) options:0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(13),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
    _productNameLable.attributedText = attributedString;
    _productPriceLable.text = [NSString stringWithFormat:@"¥ %@",item.price];
}

-(void)buttonAction:(UIButton *)btn{
    BtnActionBlock block = _btnActionHandle;
    if (block) {
        block(btn);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(25)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(130.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(150.0)];
        
        [_productNameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productNameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_standardLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productNameLable withOffset:FitHeight(10.0)];
        [_standardLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productNameLable];
        
        [_productPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_standardLabel];
        [_productPriceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        
        [_addShopCartBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        [_addShopCartBtn autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        [_addShopCartBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
//        [_addShopCartBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(480.0)];
        [_addShopCartBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
//        [_findSameBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_addShopCartBtn];
//        [_findSameBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_addShopCartBtn];
//        [_findSameBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_addShopCartBtn withOffset:FitWith(30.0)];
//        [_findSameBtn autoSetDimension:ALDimensionWidth toSize:FitWith(80.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}




@end
