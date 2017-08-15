//
//  OrderTetailsInvoiceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderTetailsInvoiceCell.h"

@interface OrderTetailsInvoiceCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *tipImgV;
@property (nonatomic,strong) UILabel *invoiceInfoLable;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderTetailsInvoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];//order_details_invoice@3x
        
        _tipImgV = [UIImageView newAutoLayoutView];
        _tipImgV.image = [UIImage imageNamed:@"order_details_invoice"];
        [self.contentView addSubview:_tipImgV];
        
        _invoiceInfoLable = [UILabel newAutoLayoutView];
        _invoiceInfoLable.textColor = [UIColor colorFromHex:0x212121];
        _invoiceInfoLable.textAlignment = NSTextAlignmentLeft;
        _invoiceInfoLable.font = CUSNEwFONT(16);
        _invoiceInfoLable.text = @"发票信息";
        [self.contentView addSubview:_invoiceInfoLable];
        
        _rightLable = [UILabel newAutoLayoutView];
        _rightLable.textColor = [UIColor colorFromHex:0x808080];
        _rightLable.textAlignment = NSTextAlignmentRight;
        _rightLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_rightLable];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textColor = [UIColor colorFromHex:0x212121];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.font = CUSFONT(11);
        _nameLable.numberOfLines = 0;
        [self.contentView addSubview:_nameLable];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textColor = [UIColor colorFromHex:0x212121];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = CUSFONT(11);
        _titleLable.text = @"发票内容:明细";
        [self.contentView addSubview:_titleLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

//-(void)setupInfoWithDuojiOrderData:(DuojiOrderData *)item{
//    _nameLable.text = [NSString stringWithFormat:@"收货人:%@",item.contact];
//    _phoneLable.text = [NSString stringWithFormat:@"联系电话:%@",item.phone];
//    NSString *address = [NSString stringWithFormat:@"收货地址:%@",item.address];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 3;
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:CUSFONT(12),
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 };
//    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:address attributes:attributes];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,address.length)];
//    _addressLable.attributedText = attributedString;
//}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_invoiceInfoLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(87.0)];
        [_invoiceInfoLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        UIImage *img = [UIImage imageNamed:@"order_details_invoice"];
        [_tipImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_tipImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_invoiceInfoLable];
        [_tipImgV autoSetDimension:ALDimensionWidth toSize:img.size.width];
        [_tipImgV autoSetDimension:ALDimensionHeight toSize:img.size.height];
        
        [_rightLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_invoiceInfoLable];
        [_rightLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_nameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipImgV];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_invoiceInfoLable withOffset:FitHeight(15.0)];
        
        [_titleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipImgV];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLable withOffset:FitHeight(15.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
