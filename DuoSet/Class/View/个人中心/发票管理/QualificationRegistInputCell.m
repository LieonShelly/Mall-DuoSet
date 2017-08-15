//
//  QualificationRegistInputCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "QualificationRegistInputCell.h"

@interface QualificationRegistInputCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *line;

@end

@implementation QualificationRegistInputCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.font = CUSFONT(12);
        _tipLable.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_tipLable];
        
        _inputTF = [UITextField newAutoLayoutView];
        _inputTF.tintColor = [UIColor mainColor];
        _inputTF.textAlignment = NSTextAlignmentLeft;
        _inputTF.font = CUSFONT(13);
        [self.contentView addSubview:_inputTF];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipLable autoSetDimension:ALDimensionWidth toSize:FitWith(190.0) relation:NSLayoutRelationLessThanOrEqual];
        
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        [_inputTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tipLable withOffset:FitWith(40.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
