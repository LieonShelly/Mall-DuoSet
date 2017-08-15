//
//  ProductBaseInfoCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductBaseInfoCell.h"

@interface ProductBaseInfoCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *productNameLable;
@property(nonatomic,strong) UILabel *productPriceLable;
@property(nonatomic,strong) UILabel *freightLable;
@property(nonatomic,strong) UILabel *sendAdressLable;
@property(nonatomic,strong) UILabel *payCountLable;
@property(nonatomic,assign) ProductDetailStyle status;

@end

@implementation ProductBaseInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withProductDetailStyle:(ProductDetailStyle)status{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _status = status;
        
        _productNameLable = [UILabel newAutoLayoutView];
        _productNameLable.textColor = [UIColor colorFromHex:0x222222];
        _productNameLable.numberOfLines = 2;
        [self.contentView addSubview:_productNameLable];
        
        if (_status == ProductDetailDefault) {
            _productPriceLable = [UILabel newAutoLayoutView];
            _productPriceLable.textColor = [UIColor mainColor];
            _productPriceLable.font = CUSFONT(18);
            _productPriceLable.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:_productPriceLable];
        }
        
        _freightLable = [UILabel newAutoLayoutView];
//        _freightLable.text = @"运费：￥10";
        _freightLable.textAlignment = _status == ProductDetailSeckill ? NSTextAlignmentLeft : NSTextAlignmentCenter;
        _freightLable.font = CUSFONT(11);
        _freightLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_freightLable];
        
        _sendAdressLable = [UILabel newAutoLayoutView];
//        _sendAdressLable.text = @"四川成都";
        _sendAdressLable.textAlignment = NSTextAlignmentCenter;
        _sendAdressLable.font = CUSFONT(11);
        _sendAdressLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_sendAdressLable];
        
        _payCountLable = [UILabel newAutoLayoutView];
//        _payCountLable.text = @"12000人付款";
        _payCountLable.textAlignment = _status == ProductDetailSeckill ? NSTextAlignmentRight :NSTextAlignmentCenter;
        _payCountLable.font = CUSFONT(11);
        _payCountLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_payCountLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
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
    
    if (_status == ProductDetailDefault) {
        NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(14) range:NSMakeRange(text.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
        _productPriceLable.attributedText = attributeString;
        _sendAdressLable.hidden = true;
        _freightLable.text = [NSString stringWithFormat:@"运费:￥%@",[NSString stringWithFormat:@"%.2lf",item.carryPrice.floatValue]];
        _payCountLable.text = [NSString stringWithFormat:@"%@人付款",item.buyedCount];
    }else{
        _freightLable.hidden = false;
        _freightLable.text = [NSString stringWithFormat:@"运费:￥%@",[NSString stringWithFormat:@"%.2lf",item.carryPrice.floatValue]];
        _sendAdressLable.text = [NSString stringWithFormat:@"%@人付款",item.buyedCount];
        _payCountLable.hidden = true;
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productNameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        if (_status == ProductDetailDefault) {
            [_productPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productNameLable];
            [_productPriceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productNameLable withOffset:FitHeight(20.0)];
            
            [_freightLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
            [_freightLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(270.0)];
            
            [_sendAdressLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
            [_sendAdressLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_freightLable withOffset:FitWith(60.0)];
            
            [_payCountLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_productPriceLable];
            [_payCountLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_sendAdressLable withOffset:FitWith(60.0)];
        }
        if (_status == ProductDetailSeckill) {
            [_freightLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
            [_freightLable autoSetDimension:ALDimensionWidth toSize:(mainScreenWidth - FitWith(60.0))/3];
            [_freightLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(140.0)];
            
            [_sendAdressLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_freightLable];
            [_sendAdressLable autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_freightLable];
            [_sendAdressLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_freightLable];
            
            [_payCountLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_freightLable];
            [_payCountLable autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_freightLable];
            [_payCountLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_sendAdressLable];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
