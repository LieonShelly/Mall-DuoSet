//
//  ProductDetailsPromotionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsPromotionCell.h"

@interface ProductDetailsPromotionCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *tipLable;
@property(nonatomic,strong) UIImageView *imgV1;
@property(nonatomic,strong) UILabel *lable1;
@property(nonatomic,strong) UIImageView *imgV2;
@property(nonatomic,strong) UILabel *lable2;


@property(nonatomic,strong) UIView *line;

@end

@implementation ProductDetailsPromotionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.textColor = [UIColor colorFromHex:0x808080];
        _tipLable.font = CUSNEwFONT(15);
        _tipLable.text = @"促销";
        _tipLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_tipLable];
        
        _imgV1 = [UIImageView newAutoLayoutView];
        _imgV1.image = [UIImage imageNamed:@"details_promotion_con"];
        [self.contentView addSubview:_imgV1];
        
        _lable1 = [UILabel newAutoLayoutView];
        _lable1.textColor = [UIColor colorFromHex:0x212121];
        _lable1.font = CUSNEwFONT(14);
        _lable1.text = @"此商品参加价值满2999元送199元鞋包券";
        _lable1.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lable1];
        
        _imgV2 = [UIImageView newAutoLayoutView];
        _imgV2.image = [UIImage imageNamed:@"details_promotion_con"];
        [self.contentView addSubview:_imgV2];
        
        _lable2 = [UILabel newAutoLayoutView];
        _lable2.textColor = [UIColor colorFromHex:0x212121];
        _lable2.font = CUSNEwFONT(14);
        _lable2.text = @"此价格不与优惠券优惠同时享受";
        _lable2.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_lable2];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        [_imgV1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_tipLable];
        [_imgV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(110.0)];
        [_imgV1 autoSetDimension:ALDimensionWidth toSize:FitWith(38.0)];
        [_imgV1 autoSetDimension:ALDimensionHeight toSize:FitHeight(26.0)];
        
        [_lable1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_tipLable];
        [_lable1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgV1 withOffset:FitWith(20.0)];
        [_lable1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_imgV2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_imgV1];
        [_imgV2 autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_imgV1];
        [_imgV2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_imgV1];
        [_imgV2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV1 withOffset:FitHeight(16.0)];
        
        [_lable2 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_imgV2];
        [_lable2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_imgV2 withOffset:FitWith(20.0)];
        [_lable2 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
