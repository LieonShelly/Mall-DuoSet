//
//  RegisterDesignerResionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RegisterDesignerResionCell.h"

@interface RegisterDesignerResionCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *line;

@end

@implementation RegisterDesignerResionCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _inputTV = [UITextView newAutoLayoutView];
        _inputTV.textColor = [UIColor colorFromHex:0x222222];
        _inputTV.font = CUSFONT(13);
        _inputTV.placeholder = @"我们非常看重您的设计理念(200字以内)";
        [self.contentView addSubview:_inputTV];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}
- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_inputTV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_inputTV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_inputTV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        [_inputTV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
