//
//  RegisterDesignerTipsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RegisterDesignerTipsCell.h"

@interface RegisterDesignerTipsCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation RegisterDesignerTipsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.font = CUSFONT(12);
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_tipsLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
