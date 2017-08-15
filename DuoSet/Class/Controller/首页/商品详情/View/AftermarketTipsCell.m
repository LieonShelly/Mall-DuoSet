//
//  AftermarketTipsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AftermarketTipsCell.h"

@interface AftermarketTipsCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation AftermarketTipsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x808080];
        _tipsLable.font = CUSNEwFONT(14);
        _tipsLable.text = @"由哆集直接销售和发货，并且提供售后服务";
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
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipsLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
