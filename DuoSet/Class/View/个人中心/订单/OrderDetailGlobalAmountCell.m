//
//  OrderDetailGlobalAmountCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderDetailGlobalAmountCell.h"

@interface OrderDetailGlobalAmountCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) UILabel *postTipsLable;
@property (nonatomic,strong) UILabel *taxTipsLable;
@property (nonatomic,strong) UILabel *cutTipsLabe;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderDetailGlobalAmountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSNEwFONT(16);
        _tipsLable.text = @"商品总额";
        [self.contentView addSubview:_tipsLable];
        
        _productPrice = [UILabel newAutoLayoutView];
        _productPrice.textColor = [UIColor mainColor];
        _productPrice.textAlignment = NSTextAlignmentRight;
        _productPrice.font = CUSNEwFONT(18);
        [self.contentView addSubview:_productPrice];
        
        _postTipsLable = [UILabel newAutoLayoutView];
        _postTipsLable.textColor = [UIColor colorFromHex:0x222222];
        _postTipsLable.textAlignment = NSTextAlignmentLeft;
        _postTipsLable.font = CUSNEwFONT(15);
        _postTipsLable.text = @"运费";
        [self.contentView addSubview:_postTipsLable];
        
        _postAmountLable = [UILabel newAutoLayoutView];
        _postAmountLable.textColor = [UIColor mainColor];
        _postAmountLable.textAlignment = NSTextAlignmentLeft;
        _postAmountLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_postAmountLable];
        
        _taxTipsLable = [UILabel newAutoLayoutView];
        _taxTipsLable.textColor = [UIColor colorFromHex:0x222222];
        _taxTipsLable.textAlignment = NSTextAlignmentLeft;
        _taxTipsLable.font = CUSNEwFONT(15);
        _taxTipsLable.text = @"税费";
        [self.contentView addSubview:_taxTipsLable];
        
        _taxLable = [UILabel newAutoLayoutView];
        _taxLable.textColor = [UIColor mainColor];
        _taxLable.textAlignment = NSTextAlignmentLeft;
        _taxLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_taxLable];
        
        _cutTipsLabe = [UILabel newAutoLayoutView];
        _cutTipsLabe.textColor = [UIColor colorFromHex:0x222222];
        _cutTipsLabe.textAlignment = NSTextAlignmentLeft;
        _cutTipsLabe.font = CUSNEwFONT(15);
        _cutTipsLabe.text = @"优惠";
        [self.contentView addSubview:_cutTipsLabe];
        
        _cutLable = [UILabel newAutoLayoutView];
        _cutLable.textColor = [UIColor mainColor];
        _cutLable.textAlignment = NSTextAlignmentLeft;
        _cutLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_cutLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        _realPayAmountLable = [UILabel newAutoLayoutView];
        _realPayAmountLable.textColor = [UIColor mainColor];
        _realPayAmountLable.textAlignment = NSTextAlignmentRight;
        _realPayAmountLable.font = CUSFONT(16);
        [self.contentView addSubview:_realPayAmountLable];
        
        _realPayTipsLable = [UILabel newAutoLayoutView];
        _realPayTipsLable.textColor = [UIColor colorFromHex:0x222222];
        _realPayTipsLable.textAlignment = NSTextAlignmentRight;
        _realPayTipsLable.font = CUSNEwFONT(16);
        _realPayTipsLable.text = @"实付款：";
        [self.contentView addSubview:_realPayTipsLable];
        
        _createTimeLable = [UILabel newAutoLayoutView];
        _createTimeLable.textColor = [UIColor colorFromHex:0x666666];
        _createTimeLable.textAlignment = NSTextAlignmentRight;
        _createTimeLable.font = CUSNEwFONT(14);
        [self.contentView addSubview:_createTimeLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupDuojiOrderData:(DuojiOrderData *)item{
    _productPrice.text = [NSString stringWithFormat:@"￥%@",item.productPrice];
    _postAmountLable.text = [NSString stringWithFormat:@"￥%@",item.carrierPrice];
    _taxLable.text = [NSString stringWithFormat:@"￥%@",item.taxPrice];
    _cutLable.text = [NSString stringWithFormat:@"￥%@",item.subtractPrice];
    
    _productPrice.text = [NSString stringWithFormat:@"￥%.2lf",item.productPrice.floatValue];
    _postAmountLable.text = [NSString stringWithFormat:@"+￥%.2lf",item.carrierPrice.floatValue];
    _taxLable.text = [NSString stringWithFormat:@"+￥%.2lf",item.taxPrice.floatValue];
    _cutLable.text = [NSString stringWithFormat:@"-￥%.2lf",item.subtractPrice.floatValue];
    
    
    _createTimeLable.text = [NSString stringWithFormat:@"下单时间：%@",item.createTime] ;
    NSString *price  = @"";
    if (item.orderState == OrderStatesCreate || item.orderState == OrderStatesCancel) {
        _realPayTipsLable.text = @"需付款：";
        price = [NSString stringWithFormat:@"%@",item.totalPrice];
    }else{
        _realPayTipsLable.text = @"实付款：";
        price = [NSString stringWithFormat:@"%@",item.amountPrice];
    }
    NSString *text = [NSString stringWithFormat:@"￥%.2lf",price.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 1) {
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(0, 1)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0, 1)];
    }
    _realPayAmountLable.attributedText = attributeString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        
        [_productPrice autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(35.0)];
        [_productPrice autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_postTipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipsLable withOffset:FitHeight(15)];
        [_postTipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        
        [_postAmountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_postTipsLable];
        [_postAmountLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_productPrice];
        
        [_taxTipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        [_taxTipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_postTipsLable withOffset:FitHeight(15)];
        
        [_taxLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_postAmountLable];
        [_taxLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_taxTipsLable];
        
        [_cutTipsLabe autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        [_cutTipsLabe autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_taxTipsLable withOffset:FitHeight(15)];
        
        [_cutLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_postAmountLable];
        [_cutLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_cutTipsLabe];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(220.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [_realPayAmountLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_productPrice];
        [_realPayAmountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line withOffset:FitHeight(15.0)];
        
        [_realPayTipsLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_realPayAmountLable];
        [_realPayTipsLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_realPayAmountLable withOffset:FitWith(10)];
        
        [_createTimeLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_productPrice];
        [_createTimeLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_realPayTipsLable withOffset:FitHeight(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
