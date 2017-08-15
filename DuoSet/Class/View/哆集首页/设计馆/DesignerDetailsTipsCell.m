//
//  DesignerDetailsTipsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerDetailsTipsCell.h"

@interface DesignerDetailsTipsCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation DesignerDetailsTipsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.font = CUSFONT(14);
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_tipsLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}
- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
