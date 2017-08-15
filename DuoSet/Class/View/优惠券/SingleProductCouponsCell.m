//
//  SingleProductCouponsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SingleProductCouponsCell.h"
#import "CouponInfoData.h"

@interface SingleProductCouponsCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *titleLable;

@property(nonatomic,strong) NSMutableArray *couponBgViewArr;
@property(nonatomic,strong) UIImageView *couponBgView1;
@property(nonatomic,strong) UIImageView *couponBgView2;
@property(nonatomic,strong) UIImageView *couponBgView3;

@property(nonatomic,strong) NSMutableArray *tagArr;
@property(nonatomic,strong) UILabel *tag1;
@property(nonatomic,strong) UILabel *tag2;
@property(nonatomic,strong) UILabel *tag3;
@property(nonatomic,strong) UILabel *getLable;
@end

@implementation SingleProductCouponsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {//product_coupons_bg@3x
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textColor = [UIColor colorFromHex:0x808080];
        _titleLable.text = @"领券";
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_titleLable];
        
        _tagArr = [NSMutableArray array];
        _tag1 = [UILabel newAutoLayoutView];
        [_tagArr addObject:_tag1];
        _tag2 = [UILabel newAutoLayoutView];
        [_tagArr addObject:_tag2];
        _tag3 = [UILabel newAutoLayoutView];
        [_tagArr addObject:_tag3];
        
        _couponBgViewArr = [NSMutableArray array];
        _couponBgView1 = [UIImageView newAutoLayoutView];
        [_couponBgViewArr addObject:_couponBgView1];
        _couponBgView2 = [UIImageView newAutoLayoutView];
        [_couponBgViewArr addObject:_couponBgView2];
        _couponBgView3 = [UIImageView newAutoLayoutView];
        [_couponBgViewArr addObject:_couponBgView3];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *bgView = _couponBgViewArr[i];
            bgView.image = [UIImage imageNamed:@"product_coupons_bg"];
            [self.contentView addSubview:bgView];
            
            UILabel *tag = _tagArr[i];
            tag.textColor = [UIColor whiteColor];
            tag.font = CUSNEwFONT(13);
            tag.adjustsFontSizeToFitWidth = true;
            tag.textAlignment = NSTextAlignmentCenter;
            [bgView addSubview:tag];
        }
        
        _getLable = [UILabel newAutoLayoutView];
        _getLable.text = @"领取";
        _getLable.textColor = [UIColor colorFromHex:0x222222];
        _getLable.textAlignment = NSTextAlignmentRight;
        _getLable.font = CUSNEwFONT(15);
        [self.contentView addSubview:_getLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithCouponInfoDataArr:(NSMutableArray *)items{
    NSMutableArray *itemsArr = items;
    if (itemsArr.count > 3) {
        [itemsArr subarrayWithRange:NSMakeRange(0, 3)];
    }
    for (int i = 0; i < 3; i++) {
        UILabel *tag = _tagArr[i];
        UIImageView *bgView = _couponBgViewArr[i];
        if (i > itemsArr.count - 1) {
            bgView.hidden = true;
            tag.hidden = true;
        }else{
            CouponInfoData *item = itemsArr[i];
            tag.text = [NSString stringWithFormat:@"满%@减%@",item.fullAmountUse,item.amount];
        }
    }
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        for (int i = 0; i < 3; i++) {
            UIImageView *bgView = _couponBgViewArr[i];
            [bgView autoSetDimension:ALDimensionWidth toSize:FitWith(140.0)];
            [bgView autoSetDimension:ALDimensionHeight toSize:FitWith(40.0)];
            [bgView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
            [bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(132.0) + FitWith(180.0) * i];
            
            UILabel *tag = _tagArr[i];
            [tag autoPinEdgesToSuperviewEdges];
        }
        
        [_getLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_getLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
