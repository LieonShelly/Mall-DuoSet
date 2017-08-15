//
//  ProductDetailsBaseInfoCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsBaseInfoCell.h"

@interface ProductDetailsBaseInfoCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *productNameLable;
@property(nonatomic,strong) UILabel *productSubLable;
@property(nonatomic,strong) UILabel *productPriceLable;
@property(nonatomic,strong) UILabel *texLable;
@property(nonatomic,strong) UIImageView *teximgV;
@property(nonatomic,strong) UIButton *taxBtn;
@property(nonatomic,strong) UILabel *payCountLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation ProductDetailsBaseInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _productNameLable = [UILabel newAutoLayoutView];
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _productNameLable.numberOfLines = 2;
        [self.contentView addSubview:_productNameLable];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.textColor = [UIColor mainColor];
        _productSubLable.numberOfLines = 0;
        _productSubLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_productSubLable];
        
        _productPriceLable = [UILabel newAutoLayoutView];
        _productPriceLable.textColor = [UIColor mainColor];
        _productPriceLable.font = CUSFONT(18);
        _productPriceLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_productPriceLable];
        
        _texLable = [UILabel newAutoLayoutView];
        _texLable.font = CUSNEwFONT(14);
        _texLable.text = @"进口税率：11.9%";
        _texLable.textAlignment = NSTextAlignmentLeft;
        _texLable.hidden = true;
        [self.contentView addSubview:_texLable];
        
        _teximgV = [UIImageView newAutoLayoutView];
        _teximgV.image = [UIImage imageNamed:@"global_question_des"];
        _teximgV.hidden = true;
        [self.contentView addSubview:_teximgV];
        
        _taxBtn = [UIButton newAutoLayoutView];
        [_taxBtn addTarget:self action:@selector(texBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _taxBtn.hidden = true;
        [self.contentView addSubview:_taxBtn];
        
        _payCountLable = [UILabel newAutoLayoutView];
        _payCountLable.textAlignment = NSTextAlignmentRight;
        _payCountLable.font = CUSFONT(11);
        _payCountLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_payCountLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)texBtnAction{
    TexButtonActionBlock block = _texBtnHandle;
    if (block) {
        block();
    }
}

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSNEwFONT(17),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
    self.productNameLable.attributedText = attributedString;
    
    if (item.productSubName.length > 0) {
        NSMutableParagraphStyle *subparagraphStyle = [[NSMutableParagraphStyle alloc] init];
        subparagraphStyle.lineSpacing = 3;
        NSDictionary *subAttributes = @{
                                        NSFontAttributeName:CUSNEwFONT(15),
                                        NSParagraphStyleAttributeName:paragraphStyle
                                        };
        
        NSMutableAttributedString *subAttributedString =  [[NSMutableAttributedString alloc] initWithString:item.productSubName attributes:subAttributes];
        [subAttributedString addAttribute:NSParagraphStyleAttributeName value:subparagraphStyle range:NSMakeRange(0,item.productSubName.length)];
        self.productSubLable.attributedText = subAttributedString;
    }
    
    NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(14) range:NSMakeRange(text.length - 2, 2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
    _productPriceLable.attributedText = attributeString;
    _payCountLable.text = [NSString stringWithFormat:@"%@人付款",item.buyedCount];
    
    if (item.isGlobal) {
        _taxBtn.hidden = false;
        _teximgV.hidden = false;
        _texLable.hidden = false;
        _texLable.text = [NSString stringWithFormat:@"进口税率：%@",item.tax];
    }
}

-(void)setupInfoWithFirstLangchProductTitle:(NSString *)productTitle productPrice:(NSString *)productPrice{
    if (productTitle.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:CUSNEwFONT(17),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:productTitle attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,productTitle.length)];
        self.productNameLable.attributedText = attributedString;
    }
    if (productPrice.length > 0) {
        NSString *text = [NSString stringWithFormat:@"￥%@",productPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(14) range:NSMakeRange(text.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
        _productPriceLable.attributedText = attributeString;
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_productSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productNameLable withOffset:FitHeight(10.0)];
        [_productSubLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productSubLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_productPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productNameLable];
        [_productPriceLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_texLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
        [_texLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(250.0)];
        
        [_teximgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_texLable];
        [_teximgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_texLable withOffset:FitWith(10.0)];
        
        [_taxBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
        [_taxBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_texLable];
        [_taxBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_teximgV];
        [_taxBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_payCountLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
        [_payCountLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
