//
//  DuoPointListCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuoPointListCell.h"

@interface DuoPointListCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *contentLable;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UILabel *rightLable;
@property (nonatomic,strong) UIView *line;

@end

@implementation DuoPointListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor colorFromHex:0x222222];
        _contentLable.textAlignment = NSTextAlignmentLeft;
        _contentLable.font = CUSFONT(14);
        _contentLable.numberOfLines = 0;
        [self.contentView addSubview:_contentLable];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textColor = [UIColor colorFromHex:0x222222];
        _timeLable.textAlignment = NSTextAlignmentLeft;
        _timeLable.font = CUSFONT(10);
        [self.contentView addSubview:_timeLable];
        
        _rightLable = [UILabel newAutoLayoutView];
        _rightLable.textColor = [UIColor mainColor];
        _rightLable.font = CUSFONT(18);
        [self.contentView addSubview:_rightLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithDuoDouData:(DuoDouData *)item{
    _contentLable.text = item.reason;
    _timeLable.text = item.time;
    _rightLable.text = item.count.integerValue > 0 ? [NSString stringWithFormat:@"+%@",item.count]  : item.count;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(140.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        [_timeLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_contentLable];
        [_timeLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(10.0)];
        
        [_rightLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_rightLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
