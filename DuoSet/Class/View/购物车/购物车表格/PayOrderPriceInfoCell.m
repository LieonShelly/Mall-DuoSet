//
//  PayOrderPriceInfoCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/20.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PayOrderPriceInfoCell.h"

@interface PayOrderPriceInfoCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) UILabel *priceLable;

@end

@implementation PayOrderPriceInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.font = CUSFONT(14);
        _tipsLable.text = @"支付金额";
        [self.contentView addSubview:_tipsLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textAlignment = NSTextAlignmentRight;
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.font = CUSFONT(14);
        [self.contentView addSubview:_priceLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithPriceStr:(NSString *)price{
    if (price.floatValue == 0.0) {
        return;
    }
    NSString *text = [NSString stringWithFormat:@"￥%.2lf",price.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    if (text.length > 2) {
        [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(text.length - 2, 2)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
    }
    self.priceLable.attributedText = attributeString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(40.0)];
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
