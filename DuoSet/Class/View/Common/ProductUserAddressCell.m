//
//  ProductUserAddressCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductUserAddressCell.h"

@interface ProductUserAddressCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIImageView *imgV;

@end

@implementation ProductUserAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x666666];
        _tipsLable.text = @"送至";
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSFONT(14);
        [self.contentView addSubview:_tipsLable];
        
        _addressLable = [UILabel newAutoLayoutView];
        _addressLable.textColor = [UIColor colorFromHex:0x222222];
        _addressLable.text = @"四川省成都市高新区天府大道中段350号天祥广场2号楼2210";
        _addressLable.textAlignment = NSTextAlignmentRight;
        _addressLable.font = CUSFONT(13);
        [self.contentView addSubview:_addressLable];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.image = [UIImage imageNamed:@"surrounding"];
        _imgV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_imgV];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_addressLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(130.0)];
        
        [_imgV autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_addressLable withOffset:FitWith(20.0)];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_imgV autoSetDimension:ALDimensionWidth toSize:FitHeight(80.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
