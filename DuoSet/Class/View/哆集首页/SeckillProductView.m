//
//  SeckillProductView.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillProductView.h"

@interface SeckillProductView()

@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *originalPriceLable;
@property(nonatomic,strong) UILabel *priceLable;

@end

@implementation SeckillProductView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _productImgV = [[UIImageView alloc]initWithFrame:CGRectMake(FitWith(20.0), 5,frame.size.width - FitWith(40.0) , FitHeight(220.0))];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.layer.masksToBounds = true;
        [self addSubview:_productImgV];
        
        _originalPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, _productImgV.frame.origin.y + _productImgV.frame.size.height + 5, frame.size.width, FitHeight(30.0))];
        _originalPriceLable.textColor = [UIColor colorFromHex:0x666666];
        _originalPriceLable.textAlignment = NSTextAlignmentCenter;
        _originalPriceLable.font = [UIFont systemFontOfSize:12];
        [self addSubview:_originalPriceLable];
        
        _priceLable = [[UILabel alloc]initWithFrame:CGRectMake(0, _originalPriceLable.frame.origin.y + _originalPriceLable.frame.size.height - 5, frame.size.width, FitHeight(60.0))];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.textAlignment = NSTextAlignmentCenter;
        _priceLable.font = [UIFont systemFontOfSize:15];
        [self addSubview:_priceLable];
    }
    return self;
}

-(void)setupInfoWithRobProductData:(RobProductData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(110, 160) options:0];
    NSString *oldPrice = [NSString stringWithFormat:@"￥%.2lf",item.curDetailResponse.price.floatValue];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldPrice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
    [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                             NSBaselineOffsetAttributeName : @0,
                             NSStrikethroughColorAttributeName : [UIColor colorFromHex:0x666666]
                             }
                     range:NSMakeRange(1, length - 1)];
    _originalPriceLable.attributedText = attrStr;
    
    NSString *text = [NSString stringWithFormat:@"￥%.2lf",item.curDetailResponse.robPrice.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 2) {
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
    }
    self.priceLable.attributedText = attributeString;
}

-(void)setupInfoWithSeckillListData:(SeckillListData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    NSString *oldPrice = [NSString stringWithFormat:@"￥%@",item.price];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(1, length - 1)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorFromHex:0x666666] range:NSMakeRange(0, length)];
    [_originalPriceLable setAttributedText:attri];
    
    NSString *text = [NSString stringWithFormat:@"￥%.2lf",item.robPrice.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 2) {
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(text.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
    }
    self.priceLable.attributedText = attributeString;
}

@end
