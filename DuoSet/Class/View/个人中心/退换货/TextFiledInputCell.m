//
//  TextFiledInputCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TextFiledInputCell.h"

@interface TextFiledInputCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *line;

@end

@implementation TextFiledInputCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xffffff];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textColor = [UIColor colorFromHex:0x333333];
        _tipsLable.font = CUSFONT(12);
        [self.contentView addSubview:_tipsLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_line];
        
        _inputTF = [UITextField newAutoLayoutView];
        _inputTF.font = CUSFONT(11);
        _inputTF.textAlignment = NSTextAlignmentLeft;
        _inputTF.textColor = [UIColor colorFromHex:0x666666];
        _inputTF.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:_inputTF];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_inputTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tipsLable withOffset:FitWith(50.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
