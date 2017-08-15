//
//  ProductShowAllCommentCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductShowAllCommentCell.h"

@interface ProductShowAllCommentCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@property (nonatomic,strong) UIView *line;

@end

@implementation ProductShowAllCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _showAllLable = [UILabel newAutoLayoutView];
        _showAllLable.textColor = [UIColor colorFromHex:0x808080];
        _showAllLable.font = CUSNEwFONT(15);
        _showAllLable.text = @"查看全部评价";
        _showAllLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_showAllLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_showAllLable autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
        [_showAllLable autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
