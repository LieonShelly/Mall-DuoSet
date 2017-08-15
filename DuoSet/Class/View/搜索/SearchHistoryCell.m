//
//  SearchHistoryCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SearchHistoryCell.h"

@interface SearchHistoryCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIView *upLine;

@end

@implementation SearchHistoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _upLine = [UIView newAutoLayoutView];
        _upLine.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_upLine];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.font = CUSFONT(12);
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_titleLable];
        
        _downLine = [UIView newAutoLayoutView];
        _downLine.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_downLine];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_upLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_upLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_upLine autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_upLine autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_downLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_downLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_downLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_downLine autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
