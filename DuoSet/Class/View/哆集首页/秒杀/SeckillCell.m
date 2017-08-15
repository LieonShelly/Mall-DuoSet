//
//  SeckillCell.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillCell.h"
#import "PercentageView.h"

@interface SeckillCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productname;
@property(nonatomic,strong) UILabel *productSubLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UILabel *originalPriceLable;
@property(nonatomic,strong) PercentageView *percentageView;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UIButton *rightNowBuyBtn;
@property(nonatomic,strong) UILabel *amountLable;

@end

@implementation SeckillCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.image = [UIImage imageNamed:@"p8"];
        [_bgView addSubview:_productImgV];
        
        _productname = [UILabel newAutoLayoutView];
        _productname.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        _productname.text = @"让身体自由呼吸吧！";
        _productname.textColor = [UIColor colorFromHex:0x000000];
        _productname.numberOfLines = 1;
        [_bgView addSubview:_productname];
        
        _productSubLable = [UILabel newAutoLayoutView];
        _productSubLable.font = CUSFONT(12);
        _productSubLable.text = @"2017新款连衣裙上市";
        _productSubLable.textColor = [UIColor colorFromHex:0x666666];
        _productSubLable.numberOfLines = 1;
        [_bgView addSubview:_productSubLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _priceLable.text = @"￥129.00";
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_priceLable];
        
        _originalPriceLable = [UILabel newAutoLayoutView];
        _originalPriceLable.textColor = [UIColor colorFromHex:0x999999];
        _originalPriceLable.text = @"￥168.0";
        _originalPriceLable.textAlignment = NSTextAlignmentLeft;
        _originalPriceLable.font = CUSFONT(12);
        NSMutableAttributedString *pri = [[NSMutableAttributedString alloc]initWithString:@"￥168.0"];
        [pri setAttributes:@{NSStrikethroughStyleAttributeName : [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,@"￥168.0".length)];
        _originalPriceLable.attributedText = pri;
        [_bgView addSubview:_originalPriceLable];
        
        _percentageView = [PercentageView newAutoLayoutView];
        [_bgView addSubview:_percentageView];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textColor = [UIColor colorFromHex:0x999999];
        _timeLable.text = @"3分钟抢光100件";
        _timeLable.font = CUSFONT(10);
        _timeLable.textAlignment = NSTextAlignmentLeft;
        _timeLable.hidden = true;
        [_bgView addSubview:_timeLable];
        
        _rightNowBuyBtn = [UIButton newAutoLayoutView];
        _rightNowBuyBtn.backgroundColor = [UIColor mainColor];
        _rightNowBuyBtn.layer.cornerRadius = 3;
        _rightNowBuyBtn.layer.masksToBounds = true;
        _rightNowBuyBtn.titleLabel.font = CUSFONT(10);
        [_rightNowBuyBtn setTitle:@"马上抢 >" forState:UIControlStateNormal];
        [_rightNowBuyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bgView addSubview:_rightNowBuyBtn];
        
        _amountLable = [UILabel newAutoLayoutView];
        _amountLable.textColor = [UIColor mainColor];
        _amountLable.text = @"已抢39件";
        _amountLable.textAlignment = NSTextAlignmentRight;
        _amountLable.font = CUSFONT(10);
        [_bgView addSubview:_amountLable];
        
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitWith(5)];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(50.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(80.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(200.0)];
        
        [_productname autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV];
        [_productname autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(60.0)];
        
        [_productSubLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productname withOffset:FitHeight(10.0)];
        [_productSubLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(60.0)];
        
        [_priceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productSubLable withOffset:FitHeight(10.0)];
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productname];
        
        [_originalPriceLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_priceLable withOffset:FitHeight(10.0)];
        [_originalPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productname];
        
        [_percentageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productname];
        [_percentageView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_originalPriceLable withOffset:FitHeight(10.0)];
        [_percentageView autoSetDimension:ALDimensionWidth toSize:FitWith(160.0)];
        [_percentageView autoSetDimension:ALDimensionHeight toSize:FitHeight(30.0)];
        
        [_timeLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productname];
        [_timeLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_originalPriceLable withOffset:FitHeight(10.0)];
        
        [_rightNowBuyBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(170.0)];
        [_rightNowBuyBtn autoSetDimension:ALDimensionWidth toSize:FitWith(130.0)];
        [_rightNowBuyBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        [_rightNowBuyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(40.0)];
        
        [_amountLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_rightNowBuyBtn];
        [_amountLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_rightNowBuyBtn withOffset:FitHeight(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
