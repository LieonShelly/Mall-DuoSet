//
//  PiazzaMessageTipCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaMessageTipCell.h"

@interface PiazzaMessageTipCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UILabel *tipLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation PiazzaMessageTipCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.textAlignment = NSTextAlignmentLeft;
        _tipLable.font = CUSFONT(14);
        _tipLable.textColor = [UIColor colorFromHex:0x222222];
        _tipLable.text = @"评论";
        [_bgView addSubview:_tipLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [_bgView addSubview:_line];
        
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(50.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
