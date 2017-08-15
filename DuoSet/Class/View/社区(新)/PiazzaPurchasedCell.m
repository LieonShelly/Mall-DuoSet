//
//  PiazzaPurchasedCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaPurchasedCell.h"

@interface PiazzaPurchasedCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *cover;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UIView *line;

@end

@implementation PiazzaPurchasedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _cover = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_cover];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = CUSNEwFONT(18);
        _productName.numberOfLines = 2;
        [self.contentView addSubview:_productName];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithPiazzaPurchasedProduct:(PiazzaPurchasedProduct *)item{
    [_cover sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_avatar options:0];
    _productName.text = item.productName;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_cover autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_cover autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_cover autoSetDimension:ALDimensionWidth toSize:FitHeight(122.0)];
        [_cover autoSetDimension:ALDimensionHeight toSize:FitHeight(122.0)];
        
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(40.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_cover withOffset:FitWith(14.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
