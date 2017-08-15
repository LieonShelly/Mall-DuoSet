//
//  ReturnAndChangeNewProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeNewProductCell.h"

@interface ReturnAndChangeNewProductCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *coverImgV;
@property (nonatomic,strong) UILabel *productName;
@property (nonatomic,strong) UILabel *subLable;
@property (nonatomic,strong) UILabel *priceLable;
@property (nonatomic,strong) UILabel *countLable;

@end

@implementation ReturnAndChangeNewProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xfafafa];
        [self.contentView addSubview:_bgView];
        
        _coverImgV = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_coverImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = CUSNEwFONT(16);
        _productName.numberOfLines = 2;
        [_bgView addSubview:_productName];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        _subLable.font = CUSNEwFONT(14);
        _subLable.numberOfLines = 1;
        [_bgView addSubview:_subLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor colorFromHex:0x808080];
        _priceLable.font = CUSNEwFONT(14);
        _priceLable.numberOfLines = 1;
        [_bgView addSubview:_priceLable];
        
        _countLable = [UILabel newAutoLayoutView];
        _countLable.textColor = [UIColor colorFromHex:0x808080];
        _countLable.font = CUSNEwFONT(14);
        _countLable.numberOfLines = 1;
        [_bgView addSubview:_countLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithNewReturnAndChangeData:(NewReturnAndChangeData *)item{
    [_coverImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(300, 300) options:0];
    _priceLable.text = [NSString stringWithFormat:@"价格:￥%.2lf",item.finalPrice.floatValue];
    _subLable.text = item.propertyName;
    _productName.text = item.productName;
    _countLable.text = [NSString stringWithFormat:@"X%@",item.count];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_coverImgV autoSetDimension:ALDimensionWidth toSize:FitWith(140.0)];
        [_coverImgV autoSetDimension:ALDimensionHeight toSize:FitWith(140.0)];
        [_coverImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_coverImgV];
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_coverImgV withOffset:FitWith(10.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        
        [_priceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_coverImgV];
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        
        [_subLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_subLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_priceLable withOffset:-FitHeight(5.0)];
        
        [_countLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_countLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_subLable];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
