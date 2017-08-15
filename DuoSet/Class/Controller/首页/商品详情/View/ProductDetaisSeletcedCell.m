//
//  ProductDetaisSeletcedCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetaisSeletcedCell.h"

@interface ProductDetaisSeletcedCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *seletcedTipLable;
@property(nonatomic,strong) UIImageView *arrowImgV;
//@property(nonatomic,strong) UIView *line;

@end

@implementation ProductDetaisSeletcedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _seletcedTipLable = [UILabel newAutoLayoutView];
        _seletcedTipLable.textColor = [UIColor colorFromHex:0x808080];
        _seletcedTipLable.font = CUSNEwFONT(15);
        _seletcedTipLable.text = @"已选";
        _seletcedTipLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_seletcedTipLable];
        
        _seletcedLable = [UILabel newAutoLayoutView];
        _seletcedLable.textColor = [UIColor colorFromHex:0x212121];
        _seletcedLable.font = CUSNEwFONT(15);
        _seletcedLable.text = @"白色，M号，1件";
        _seletcedLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_seletcedLable];
        
        _arrowImgV = [UIImageView newAutoLayoutView];
        _arrowImgV.image = [UIImage imageNamed:@"right_arrow"];
        _arrowImgV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_arrowImgV];
        
//        _line = [UIView newAutoLayoutView];
//        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
//        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_seletcedTipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_seletcedTipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_seletcedLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seletcedTipLable];
        [_seletcedLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(112.0)];
        [_seletcedLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
//        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
//        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
//        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
