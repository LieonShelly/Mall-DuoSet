//
//  WeekFashionTitleCell.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "WeekFashionTitleCell.h"

@interface WeekFashionTitleCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation WeekFashionTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _titleTipLable = [UILabel newAutoLayoutView];
        _titleTipLable.textAlignment = NSTextAlignmentCenter;
        _titleTipLable.textColor = [UIColor colorFromHex:0x333333];
        _titleTipLable.font = CUSFONT(13);
        [self.contentView addSubview:_titleTipLable];
        
        _subTitleLable = [UILabel newAutoLayoutView];
        _subTitleLable.textAlignment = NSTextAlignmentCenter;
        _subTitleLable.textColor = [UIColor colorFromHex:0x666666];
        _subTitleLable.font = CUSFONT(11);
        [self.contentView addSubview:_subTitleLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_titleTipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(40.0)];
        [_titleTipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_titleTipLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_subTitleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleTipLable];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
