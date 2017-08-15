//
//  ShippingAddressViewCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShippingAddressViewCell.h"

@interface ShippingAddressViewCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIButton *locationBtn;
@property(nonatomic,strong) UILabel *addresslable;
@property(nonatomic,strong) UIImageView *rightImgV;
@property(nonatomic,strong) UIView *line;

@end

@implementation ShippingAddressViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _locationBtn = [UIButton newAutoLayoutView];
        [_locationBtn setImage:[UIImage imageNamed:@"product_address_location_nomal"] forState:UIControlStateNormal];
        [_locationBtn setImage:[UIImage imageNamed:@"product_address_location_seletced"] forState:UIControlStateSelected];
        [self.contentView addSubview:_locationBtn];
                
        _addresslable = [UILabel newAutoLayoutView];
        _addresslable.textColor = [UIColor colorFromHex:0x222222];
        _addresslable.font = CUSNEwFONT(15);
        _addresslable.numberOfLines = 2;
        _addresslable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_addresslable];
        
        _rightImgV = [UIImageView newAutoLayoutView];
        _rightImgV.image = [UIImage imageNamed:@"cell_selected"];
        _rightImgV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_rightImgV];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithAddressModel:(AddressModel *)item{
    _locationBtn.selected = item.isSeletced;
    _addresslable.text = [NSString stringWithFormat:@"%@%@%@%@",item.province,item.city,item.area,item.addr];
    _rightImgV.hidden = !item.isSeletced;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_locationBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(50.0)];
        [_locationBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(22.0)];
        [_locationBtn autoSetDimension:ALDimensionWidth toSize:FitWith(30.0)];
        [_locationBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(38.0)];
        
        [_addresslable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_locationBtn];
        [_addresslable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(100.0)];
        [_addresslable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitHeight(90.0)];
        
        [_rightImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_rightImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_rightImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_rightImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(90.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
