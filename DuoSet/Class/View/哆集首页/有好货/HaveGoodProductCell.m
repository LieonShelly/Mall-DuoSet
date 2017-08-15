//
//  HaveGoodProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HaveGoodProductCell.h"

@interface HaveGoodProductCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *productImgV;
@property (nonatomic,strong) UIView *markFullView;
@property (nonatomic,strong) UILabel *statusLable;
@property (nonatomic,strong) UILabel *productName;
@property (nonatomic,strong) UILabel *productDesLable;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,strong) UIView *line;

@end

@implementation HaveGoodProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.layer.masksToBounds = true;
        [self.contentView addSubview:_productImgV];
        
        _markFullView = [UIView newAutoLayoutView];
        _markFullView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _markFullView.layer.cornerRadius = 80 * 0.5;
        _markFullView.layer.masksToBounds = true;
        _markFullView.hidden = true;
        [_productImgV addSubview:_markFullView];
        
        _statusLable = [UILabel newAutoLayoutView];
        _statusLable.textColor = [UIColor whiteColor];
        _statusLable.font = [UIFont systemFontOfSize:14];
        _statusLable.textAlignment = NSTextAlignmentCenter;
        [_markFullView addSubview:_statusLable];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        _productName.textAlignment = NSTextAlignmentLeft;
        _productName.numberOfLines = 1;
        [self.contentView addSubview:_productName];
        
        _productDesLable = [UILabel newAutoLayoutView];
        _productDesLable.textColor = [UIColor colorFromHex:0x666666];
        _productDesLable.font = CUSFONT(13);
        _productDesLable.textAlignment = NSTextAlignmentLeft;
        _productDesLable.numberOfLines = 3;
        [self.contentView addSubview:_productDesLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.text = @"￥ 369.00";
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.numberOfLines = 1;
        [self.contentView addSubview:_priceLable];
        
        _buyBtn = [UIButton newAutoLayoutView];
        _buyBtn.titleLabel.font = CUSFONT(13);
        _buyBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _buyBtn.layer.cornerRadius = 3;
        _buyBtn.layer.borderWidth = 1;
        [_buyBtn setTitle:@"去购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(buyBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _buyBtn.userInteractionEnabled = false;
        [self.contentView addSubview:_buyBtn];
        
        _line = [UILabel newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

-(void)setupInfoWithProductForListData:(ProductForListData *)item{
    if (item.picture.length > 0) {
        [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImageSize(300, 300) options:0];
    }else{
        [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(300, 300) options:0];
    }
    if (item.productStatus == ShopCarProductSellStatusSellEnd) {
        _markFullView.hidden = false;
        _statusLable.text = @"已下架";
    }else{
        if (item.count.integerValue <= 5) {
            _markFullView.hidden = false;
            _statusLable.text = item.count.integerValue == 0 ? @"已售罄" : [NSString stringWithFormat:@"仅剩%@件",item.count] ;
        }else{
            _markFullView.hidden = true;
        }
    }
    _productName.text = item.productName;
    if (item.productSubName.length > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:CUSFONT(13),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productSubName attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productSubName.length)];
        _productDesLable.attributedText = attributedString;
    }
    NSString *text = [NSString stringWithFormat:@"￥ %.2lf",item.price.floatValue];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(text.length - 2,2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
    _priceLable.attributedText = attributeString;
}

-(void)buyBtnAction:(UIButton *)btn{
    CellBuybuttonActionBlock block = _buyActionHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(300.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(300.0)];
        
        [_markFullView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_markFullView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_markFullView autoSetDimension:ALDimensionWidth toSize:80];
        [_markFullView autoSetDimension:ALDimensionHeight toSize:80];
        
        [_statusLable autoPinEdgesToSuperviewEdges];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(30.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_productDesLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_productDesLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_productDesLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productName withOffset:FitHeight(20.0)];
        
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(240.0)];
        
        [_buyBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_priceLable];
        [_buyBtn autoSetDimension:ALDimensionWidth toSize:FitWith(110.0)];
        [_buyBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(46.0)];
        [_buyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(16.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
