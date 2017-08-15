//
//  CommentImageCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentImageCell.h"

@interface CommentImageCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation CommentImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imgV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_imgV];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
