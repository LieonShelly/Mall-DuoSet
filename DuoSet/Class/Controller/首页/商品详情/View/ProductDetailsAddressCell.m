//
//  ProductDetailsAddressCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsAddressCell.h"

@interface ProductDetailsAddressCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *addressTipLable;
@property(nonatomic,strong) UIImageView *arrowImgV;
@property(nonatomic,strong) UILabel *freightTipLable;
@property(nonatomic,strong) UILabel *freightLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation ProductDetailsAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _addressTipLable = [UILabel newAutoLayoutView];
        _addressTipLable.textColor = [UIColor colorFromHex:0x808080];
        _addressTipLable.font = CUSNEwFONT(15);
        _addressTipLable.text = @"送至";
        _addressTipLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_addressTipLable];
        
        _addressLable = [UILabel newAutoLayoutView];
        _addressLable.textColor = [UIColor colorFromHex:0x212121];
        _addressLable.font = CUSNEwFONT(15);
        _addressLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_addressLable];
        
        _arrowImgV = [UIImageView newAutoLayoutView];
        _arrowImgV.image = [UIImage imageNamed:@"right_arrow"];
        _arrowImgV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_arrowImgV];
        
        _freightTipLable = [UILabel newAutoLayoutView];
        _freightTipLable.textColor = [UIColor colorFromHex:0x808080];
        _freightTipLable.font = CUSNEwFONT(15);
        _freightTipLable.text = @"运费";
        _freightTipLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_freightTipLable];
        
        _freightLable = [UILabel newAutoLayoutView];
        _freightLable.textColor = [UIColor colorFromHex:0x212121];
        _freightLable.font = CUSNEwFONT(15);
        _freightLable.text = @"在线支付免运费";
        _freightLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_freightLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_addressTipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_addressTipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_addressLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_addressTipLable];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(112.0)];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(64.0)];
        
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_arrowImgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_addressLable];
        
        [_freightTipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_freightTipLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_addressTipLable withOffset:FitHeight(20.0)];
        
        [_freightLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_freightTipLable];
        [_freightLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(112.0)];
        [_freightLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
