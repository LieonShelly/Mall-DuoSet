//
//  AddressCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "AddressCell.h"

@interface AddressCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *phoneNumLable;
@property (nonatomic,strong) UILabel *defaultAddressLable;
@property (nonatomic,strong) UILabel *addressLable;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UIView *line;

@end

@implementation AddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.font = CUSFONT(14);
        _nameLable.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_nameLable];
        
        _phoneNumLable = [UILabel newAutoLayoutView];
        _phoneNumLable.textAlignment = NSTextAlignmentLeft;
        _phoneNumLable.font = CUSFONT(14);
        _phoneNumLable.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_phoneNumLable];
        
        _defaultAddressLable = [UILabel newAutoLayoutView];
        _defaultAddressLable.backgroundColor = [UIColor mainColor];
        _defaultAddressLable.text = @"默认";
        _defaultAddressLable.textColor = [UIColor whiteColor];
        _defaultAddressLable.font = CUSFONT(12);
        _defaultAddressLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_defaultAddressLable];
        
        _addressLable = [UILabel newAutoLayoutView];
        _addressLable.textAlignment = NSTextAlignmentLeft;
        _addressLable.font = CUSFONT(13);
        _addressLable.numberOfLines = 2;
        _addressLable.textColor = [UIColor colorFromHex:0x666666];
        [self.contentView addSubview:_addressLable];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.image = [UIImage imageNamed:@"right_arrow"];
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
    if (item.phone.length >= 11) {
        NSString *numberString = [item.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        _phoneNumLable.text = numberString;
    }
    _defaultAddressLable.hidden = !item.isDEFAULT;
    _addressLable.text = [NSString stringWithFormat:@"%@%@%@%@",item.province,item.city,item.area,item.addr];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_phoneNumLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_nameLable];
        [_phoneNumLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_nameLable withOffset:FitWith(30.0)];
        
        [_defaultAddressLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_phoneNumLable withOffset:FitWith(30.0)];
        [_defaultAddressLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_defaultAddressLable autoSetDimension:ALDimensionHeight toSize:FitHeight(40)];
        [_defaultAddressLable autoSetDimension:ALDimensionWidth toSize:FitWith(80)];
        
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(80.0)];
        [_addressLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLable withOffset:FitWith(15.0)];
        
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
