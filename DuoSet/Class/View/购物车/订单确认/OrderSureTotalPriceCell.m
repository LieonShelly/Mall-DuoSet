//
//  OrderSureTotalPriceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureTotalPriceCell.h"

@interface OrderSureTotalPriceCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *allPriceTipslable;
@property (nonatomic,strong) UILabel *postTipsLable;
@property (nonatomic,strong) UILabel *privilegeTipsLable;
@property (nonatomic,strong) UILabel *allPriceLable;
@property (nonatomic,strong) UILabel *postPriceLable;
@property (nonatomic,strong) UILabel *privilegePriceLable;

@end

@implementation OrderSureTotalPriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _allPriceTipslable = [UILabel newAutoLayoutView];
        _allPriceTipslable.textColor = [UIColor colorFromHex:0x222222];
        _allPriceTipslable.textAlignment = NSTextAlignmentLeft;
        _allPriceTipslable.text = @"商品总额";
        _allPriceTipslable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_allPriceTipslable];
        
        _allPriceLable = [UILabel newAutoLayoutView];
        _allPriceLable.textColor = [UIColor mainColor];
        _allPriceLable.textAlignment = NSTextAlignmentRight;
        _allPriceLable.font = CUSNEwFONT(18);
        [self.contentView addSubview:_allPriceLable];
        
        _postTipsLable = [UILabel newAutoLayoutView];
        _postTipsLable.textColor = [UIColor colorFromHex:0x222222];
        _postTipsLable.textAlignment = NSTextAlignmentLeft;
        _postTipsLable.font = CUSNEwFONT(15);
        _postTipsLable.text = @"运费";
        [self.contentView addSubview:_postTipsLable];
        
        _postPriceLable = [UILabel newAutoLayoutView];
        _postPriceLable.textColor = [UIColor mainColor];
        _postPriceLable.textAlignment = NSTextAlignmentRight;
        _postPriceLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_postPriceLable];
        
        _privilegeTipsLable = [UILabel newAutoLayoutView];
        _privilegeTipsLable.textColor = [UIColor colorFromHex:0x222222];
        _privilegeTipsLable.textAlignment = NSTextAlignmentLeft;
        _privilegeTipsLable.font = CUSNEwFONT(15);
        _privilegeTipsLable.text = @"优惠";
        [self.contentView addSubview:_privilegeTipsLable];
        
        _privilegePriceLable = [UILabel newAutoLayoutView];
        _privilegePriceLable.textColor = [UIColor mainColor];
        _privilegePriceLable.textAlignment = NSTextAlignmentRight;
        _privilegePriceLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_privilegePriceLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithShopCarSureData:(ShopCarSureData *)item{
    NSString *text = [NSString stringWithFormat:@"￥ %@",item.productPrice];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(16) range:NSMakeRange(0,1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _allPriceLable.attributedText = attributeString;
    
    NSString *postText = [NSString stringWithFormat:@"+￥%@",item.carrierPrice];
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc]initWithString:postText];
    [attributeString1 addAttribute:NSFontAttributeName value:CUSNEwFONT(14) range:NSMakeRange(0,1)];
    [attributeString1 addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _postPriceLable.attributedText = attributeString1;
    
    NSString *cutText = [NSString stringWithFormat:@"-￥%@",item.cutPrice];
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc]initWithString:cutText];
    [attributeString2 addAttribute:NSFontAttributeName value:CUSNEwFONT(14) range:NSMakeRange(0,1)];
    [attributeString2 addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _privilegePriceLable.attributedText = attributeString2;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_allPriceTipslable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_allPriceTipslable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(22.0)];
        
        [_allPriceLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_allPriceTipslable];
        [_allPriceLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_postTipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_allPriceTipslable];
        [_postTipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_allPriceTipslable withOffset:FitHeight(10)];
        
        [_postPriceLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_postTipsLable];
        [_postPriceLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_allPriceLable];
        
        [_privilegeTipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_allPriceTipslable];
        [_privilegeTipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_postTipsLable withOffset:FitHeight(10)];
        
        [_privilegePriceLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_privilegeTipsLable];
        [_privilegePriceLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_allPriceLable];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
