//
//  RefundInputCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RefundInputCell.h"

@interface RefundInputCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;

@end

@implementation RefundInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.font = [UIFont systemFontOfSize:14];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_tipsLable];
        
        _inputTF = [UITextField newAutoLayoutView];
        _inputTF.font = [UIFont systemFontOfSize:14];
        _inputTF.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_inputTF];
        
        _arrow = [UIImageView newAutoLayoutView];
        _arrow.image = [UIImage imageNamed:@"right_arrow"];
        _arrow.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_arrow];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipsLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:100.0];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_arrow autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_arrow autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_arrow autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_arrow autoSetDimension:ALDimensionWidth toSize:50];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
