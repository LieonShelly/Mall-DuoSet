//
//  GramentStyleListCell.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GramentStyleListCell.h"

@interface GramentStyleListCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,assign) BOOL isFirst;
@property (nonatomic,strong) UIImageView *imgV;

@end

@implementation GramentStyleListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isFirst:(BOOL)isFirst{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _isFirst = isFirst;
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.image = [UIImage imageNamed:@"替代6"];
        [self.contentView addSubview:_imgV];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:_isFirst ? FitHeight(20.0) : 0];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
