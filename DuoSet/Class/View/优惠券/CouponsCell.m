//
//  CouponsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CouponsCell.h"

@interface CouponsCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UIImageView *leftImgV;
@property(nonatomic,strong) UILabel *cashLable;
@property(nonatomic,strong) UILabel *imgVBigLable;
@property(nonatomic,strong) UILabel *imgVsmallLable;

@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *timeLable;

@property(nonatomic,strong) UIImageView *rightImgV;

@end

@implementation CouponsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _leftImgV = [UIImageView newAutoLayoutView];
        _leftImgV.image = [UIImage imageNamed:@"cash_coupons_unUse"];
        [_bgView addSubview:_leftImgV];
        
        _cashLable = [UILabel newAutoLayoutView];
        _cashLable.text = @"￥";
        _cashLable.font = CUSFONT(10);
        _cashLable.textColor = [UIColor whiteColor];
        [_leftImgV addSubview:_cashLable];
        
        _imgVBigLable = [UILabel newAutoLayoutView];
        _imgVBigLable.textColor = [UIColor whiteColor];
        _imgVBigLable.text = @"100";
        _imgVBigLable.font = CUSFONT(30);
        _imgVBigLable.textAlignment = NSTextAlignmentLeft;
        _imgVBigLable.adjustsFontSizeToFitWidth = true;
        [_leftImgV addSubview:_imgVBigLable];
        
        _imgVsmallLable = [UILabel newAutoLayoutView];
        _imgVsmallLable.text = @"满500可用";
        _imgVsmallLable.font = CUSFONT(12);
        _imgVsmallLable.textColor = [UIColor whiteColor];
        _imgVsmallLable.textAlignment = NSTextAlignmentCenter;
        [_leftImgV addSubview:_imgVsmallLable];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textColor = [UIColor colorFromHex:0x222222];
        _nameLable.font = CUSFONT(14);
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.text = @"全场通用，尽情购物吧";
        [_bgView addSubview:_nameLable];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textColor = [UIColor colorFromHex:0x808080];
        _timeLable.font = CUSFONT(11);
        _timeLable.textAlignment = NSTextAlignmentLeft;
        _timeLable.text = @"2017.03.07-2017.03.17";
        [_bgView addSubview:_timeLable];
        
        _getBtn = [UIButton newAutoLayoutView];
        _getBtn.layer.cornerRadius = 3;
        _getBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _getBtn.layer.borderWidth = 1;
        [_getBtn setTitle:@"领取" forState:UIControlStateNormal];
        [_getBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_bgView addSubview:_getBtn];
        
        _rightImgV = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_rightImgV];
        
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithCouponInfoData:(CouponInfoData *)item{
    if (item.couponType == CouponfullMinus) {
        _leftImgV.image = [UIImage imageNamed:@"cash_coupons_unUse"];
        _cashLable.hidden = false;
        _imgVBigLable.text = item.amount;
        _imgVsmallLable.text = [NSString stringWithFormat:@"满%@可用",item.fullAmountUse];
        _nameLable.text = item.name;
        if (item.startTime == nil) {
            _timeLable.text = [NSString stringWithFormat:@"领取后%@天有效",item.validDay];
        }else{
            NSString *begin = [NSString dateStrFormTimeInterval:item.startTime andFormatStr:@"yyyy.MM.dd"];
            NSString *end = [NSString dateStrFormTimeInterval:item.endTime andFormatStr:@"yyyy.MM.dd"];
            _timeLable.text = [NSString stringWithFormat:@"%@-%@",begin,end];
        }
    }
//    if (item.couponType == CouponDiscount) {
//        _leftImgV.image = [UIImage imageNamed:@"discount_coupons_unUse"];
//        _cashLable.hidden = true;
//        NSString *str = [NSString stringWithFormat:@"%f",item.amount.floatValue * 10];
//        NSString *intStr = [NSString stringWithFormat:@"%ld",str.integerValue];
//        _imgVBigLable.text = [NSString stringWithFormat:@"%@折",intStr];
//        _imgVsmallLable.text = [NSString stringWithFormat:@"满%@可用",item.fullAmountUse];
//        if (item.startTime == nil) {
//            _timeLable.text = [NSString stringWithFormat:@"领取后%@天有效",item.validDay];
//        }else{
//            NSString *begin = [NSString dateStrFormTimeInterval:item.startTime andFormatStr:@"yyyy.MM.dd"];
//            NSString *end = [NSString dateStrFormTimeInterval:item.endTime andFormatStr:@"yyyy.MM.dd"];
//            _timeLable.text = [NSString stringWithFormat:@"%@-%@",begin,end];
//        }
//    }
    switch (item.codeStatus) {
        case CouponUseWithNoGet:
            _getBtn.hidden = false;
            _rightImgV.hidden = true;
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_unUse"];
            break;
            
        case CouponUseWithNoUse:
            _getBtn.hidden = true;
            _rightImgV.hidden = false;
            _rightImgV.image = [UIImage imageNamed:@"isget_coupons"];
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_unUse"];
            break;
        case CouponUseWithUsed:
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_use"];
            _getBtn.hidden = true;
            _rightImgV.hidden = false;
            _rightImgV.image = [UIImage imageNamed:@"used_coupons"];
            break;
            
        case CouponUseWithPastDue:
            _getBtn.hidden = true;
            _rightImgV.hidden = false;
            _rightImgV.image = [UIImage imageNamed:@"past_coupons"];
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_use"];
            break;
            
        default:
            break;
    }
}

-(void)setupListInfoWithCouponInfoData:(CouponInfoData *)item{
    _leftImgV.image = [UIImage imageNamed:@"cash_coupons_unUse"];
    _cashLable.hidden = false;
    _imgVBigLable.text = item.amount;
    _imgVsmallLable.text = [NSString stringWithFormat:@"满%@可用",item.fullAmountUse];
    _nameLable.text = item.name;
    if (item.startTime == nil) {
        _timeLable.text = [NSString stringWithFormat:@"领取后%@天有效",item.validDay];
    }else{
        NSString *begin = [NSString dateStrFormTimeInterval:item.startTime andFormatStr:@"yyyy.MM.dd"];
        NSString *end = [NSString dateStrFormTimeInterval:item.endTime andFormatStr:@"yyyy.MM.dd"];
        _timeLable.text = [NSString stringWithFormat:@"%@-%@",begin,end];
    }
//    if (item.couponType == CouponfullMinus) {
//    }
//    if (item.couponType == CouponDiscount) {
//        _leftImgV.image = [UIImage imageNamed:@"discount_coupons_unUse"];
//        _cashLable.hidden = true;
//        NSString *str = [NSString stringWithFormat:@"%f",item.amount.floatValue * 10];
//        NSString *intStr = [NSString stringWithFormat:@"%ld",str.integerValue];
//        _imgVBigLable.text = [NSString stringWithFormat:@"%@折",intStr];
//        _imgVsmallLable.text = [NSString stringWithFormat:@"满%@可用",item.fullAmountUse];
//        if (item.startTime == nil) {
//            _timeLable.text = [NSString stringWithFormat:@"领取后%@天有效",item.validDay];
//        }else{
//            NSString *begin = [NSString dateStrFormTimeInterval:item.startTime andFormatStr:@"yyyy.MM.dd"];
//            NSString *end = [NSString dateStrFormTimeInterval:item.endTime andFormatStr:@"yyyy.MM.dd"];
//            _timeLable.text = [NSString stringWithFormat:@"%@-%@",begin,end];
//        }
//    }
    switch (item.codeStatus) {
        case CouponUseWithNoGet:
            _getBtn.hidden = false;
            _rightImgV.hidden = true;
            break;
            
        case CouponUseWithNoUse:
            _getBtn.hidden = true;
            _rightImgV.hidden = true;
            break;
        case CouponUseWithUsed:
            _getBtn.hidden = true;
            _rightImgV.hidden = false;
            _rightImgV.image = [UIImage imageNamed:@"used_coupons"];
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_use"];
//            if (item.couponType == CouponfullMinus) {
//                _leftImgV.image = [UIImage imageNamed:@"cash_coupons_use"];
//            }else{
//                _leftImgV.image = [UIImage imageNamed:@"discount_coupons_use"];
//            }
            break;
            
        case CouponUseWithPastDue:
            _getBtn.hidden = true;
            _rightImgV.hidden = false;
            _rightImgV.image = [UIImage imageNamed:@"past_coupons"];
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_use"];
//            if (item.couponType == CouponfullMinus) {
//                _leftImgV.image = [UIImage imageNamed:@"cash_coupons_use"];
//            }else{
//                _leftImgV.image = [UIImage imageNamed:@"discount_coupons_use"];
//            }
            break;
            
        default:
            break;
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_leftImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_leftImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_leftImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_leftImgV autoSetDimension:ALDimensionWidth toSize:FitWith(228.0)];
        
        [_cashLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(62.0)];
        [_cashLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(24.0)];
        
        [_imgVBigLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(88.0)];
        [_imgVBigLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(19.0)];
        
        [_imgVsmallLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        [_imgVsmallLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(60.0)];
        [_imgVsmallLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [_nameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_leftImgV withOffset:FitWith(22.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_timeLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameLable];
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(18.0)];
        
        [_getBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_getBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_getBtn autoSetDimension:ALDimensionWidth toSize:FitWith(110.0)];
        [_getBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_rightImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_rightImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_rightImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(100.0)];
        [_rightImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
