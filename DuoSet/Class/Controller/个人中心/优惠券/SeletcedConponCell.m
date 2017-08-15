//
//  SeletcedConponCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeletcedConponCell.h"

@interface SeletcedConponCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UIImageView *leftImgV;
@property(nonatomic,strong) UILabel *cashLable;
@property(nonatomic,strong) UILabel *imgVBigLable;
@property(nonatomic,strong) UILabel *imgVsmallLable;

@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *timeLable;

@end

@implementation SeletcedConponCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _leftSeletcedBtn = [UIButton newAutoLayoutView];
        [_leftSeletcedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_leftSeletcedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_bgView addSubview:_leftSeletcedBtn];
        
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
        NSString *begin = [NSString dateStrFormTimeInterval:item.startTime andFormatStr:@"yyyy.MM.dd"];
        NSString *end = [NSString dateStrFormTimeInterval:item.endTime andFormatStr:@"yyyy.MM.dd"];
        _timeLable.text = [NSString stringWithFormat:@"%@-%@",begin,end];
        _leftSeletcedBtn.selected = item.couponSelectedResonse.selected;
        if (item.couponSelectedResonse.canSelected) {
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_unUse"];
        }else{
            _leftImgV.image = [UIImage imageNamed:@"cash_coupons_use"];
        }
    }
    if (item.couponType == CouponDiscount) {
        _leftImgV.image = [UIImage imageNamed:@"discount_coupons_unUse"];
        _cashLable.hidden = true;
        NSString *str = [NSString stringWithFormat:@"%f",item.amount.floatValue * 10];
        NSString *intStr = [NSString stringWithFormat:@"%ld",str.integerValue];
        _imgVBigLable.text = [NSString stringWithFormat:@"%@折",intStr];
        _imgVsmallLable.text = [NSString stringWithFormat:@"满%@可用",item.fullAmountUse];
        NSString *begin = [NSString dateStrFormTimeInterval:item.startTime andFormatStr:@"yyyy.MM.dd"];
        NSString *end = [NSString dateStrFormTimeInterval:item.endTime andFormatStr:@"yyyy.MM.dd"];
        _timeLable.text = [NSString stringWithFormat:@"%@-%@",begin,end];
        _leftSeletcedBtn.selected = item.couponSelectedResonse.selected;
    }
//    switch (item.codeStatus) {
//        case CouponUseWithNoGet:
//            _getBtn.hidden = false;
//            _rightImgV.hidden = true;
//            break;
//            
//        case CouponUseWithNoUse:
//            _getBtn.hidden = true;
//            _rightImgV.hidden = false;
//            _rightImgV.image = [UIImage imageNamed:@"isget_coupons"];
//            break;
//        case CouponUseWithUsed:
//            _getBtn.hidden = true;
//            _rightImgV.hidden = false;
//            _rightImgV.image = [UIImage imageNamed:@"used_coupons"];
//            break;
//            
//        case CouponUseWithPastDue:
//            _getBtn.hidden = true;
//            _rightImgV.hidden = false;
//            _rightImgV.image = [UIImage imageNamed:@"past_coupons"];
//            break;
//            
//        default:
//            break;
//    }
    
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_leftSeletcedBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_leftSeletcedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(50)];
        [_leftSeletcedBtn autoSetDimension:ALDimensionHeight toSize:FitWith(50)];
        [_leftSeletcedBtn autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        
        [_leftImgV autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_leftSeletcedBtn];
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
        
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
