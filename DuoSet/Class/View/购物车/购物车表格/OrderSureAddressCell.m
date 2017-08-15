//
//  OrderSureAddressCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureAddressCell.h"

@interface OrderSureAddressCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *phoneNumLable;
@property (nonatomic,strong) UILabel *defaultAddressLable;
@property (nonatomic,strong) UILabel *addressLable;
@property (nonatomic,strong) UIImageView *locationImgV;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderSureAddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.font = CUSNEwFONT(16);
        _nameLable.textColor = [UIColor colorFromHex:0x212121];
        [self.contentView addSubview:_nameLable];
        
        _phoneNumLable = [UILabel newAutoLayoutView];
        _phoneNumLable.textAlignment = NSTextAlignmentLeft;
        _phoneNumLable.font = CUSNEwFONT(16);
        _phoneNumLable.textColor = [UIColor colorFromHex:0x212121];
        [self.contentView addSubview:_phoneNumLable];
        
        _defaultAddressLable = [UILabel newAutoLayoutView];
        _defaultAddressLable.backgroundColor = [UIColor mainColor];
        _defaultAddressLable.text = @"默认";
        _defaultAddressLable.textColor = [UIColor whiteColor];
        _defaultAddressLable.font = CUSNEwFONT(11);
        _defaultAddressLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_defaultAddressLable];
        
        _addressLable = [UILabel newAutoLayoutView];
        _addressLable.textAlignment = NSTextAlignmentLeft;
        _addressLable.font = CUSNEwFONT(16);
        _addressLable.numberOfLines = 2;
        _addressLable.textColor = [UIColor colorFromHex:0x212121];
        [self.contentView addSubview:_addressLable];
        
        _locationImgV = [UIImageView newAutoLayoutView];
        _locationImgV.contentMode = UIViewContentModeCenter;
        _locationImgV.image = [UIImage imageNamed:@"order_sure_location"];
        [self.contentView addSubview:_locationImgV];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.image = [UIImage imageNamed:@"common_right_arrow_small"];
        _rightArrow.contentMode = UIViewContentModeRight;
        [self.contentView addSubview:_rightArrow];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithAddressModel:(AddressModel *)item{
    if (item.name.length > 4) {
        NSString *str = [item.name stringByReplacingCharactersInRange:NSMakeRange(4, item.name.length - 4) withString:@"..."];
        _nameLable.text = str;
    }else{
        _nameLable.text = item.name;
    }
    NSString *phone = item.phone;
    if (phone.length >= 11) {
        NSString *numberString = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _phoneNumLable.text = numberString;
    }else{
        _phoneNumLable.text = phone;
    }
    _defaultAddressLable.hidden = !item.isDEFAULT;
    _addressLable.text = [NSString stringWithFormat:@"%@%@%@%@",item.province,item.city,item.area,item.addr];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(70.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_phoneNumLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nameLable];
        [_phoneNumLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nameLable withOffset:FitWith(30.0)];
        
        [_defaultAddressLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_phoneNumLable withOffset:FitWith(30.0)];
        [_defaultAddressLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_nameLable];
        [_defaultAddressLable autoSetDimension:ALDimensionHeight toSize:FitHeight(30)];
        [_defaultAddressLable autoSetDimension:ALDimensionWidth toSize:FitWith(60)];
        
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(70.0)];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(80.0)];
        [_addressLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLable withOffset:FitWith(15.0)];
        
        [_locationImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_addressLable];
        [_locationImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_rightArrow autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
