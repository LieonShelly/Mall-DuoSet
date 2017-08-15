//
//  AddressInputDetailCell.m
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AddressInputDetailCell.h"

@interface AddressInputDetailCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;

@end

@implementation AddressInputDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSFONT(14);
        [self.contentView addSubview:_tipsLable];
        
        _inputTF = [UITextField newAutoLayoutView];
        _inputTF.textAlignment = NSTextAlignmentLeft;
        _inputTF.placeholder = @"街道，楼牌号等…";
        _inputTF.font = CUSFONT(13);
        _inputTF.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_inputTF];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(180.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(100.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
