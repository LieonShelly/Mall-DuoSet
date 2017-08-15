//
//  ClassificationTypeCollectionViewCell.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/24.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ClassificationTypeCollectionViewCell.h"

@implementation ClassificationTypeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化视图
        [self initView];
        
    }
    return self;
}

/**初始化视图*/
- (void)initView
{
    // 背景视图
    UIView *backGroundView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:backGroundView];
    
    self.imageViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50 *AdapterWidth(), 60 *AdapterHeight())];
    self.imageViewButton.center = CGPointMake(backGroundView.center.x, backGroundView.center.y - 8 *AdapterHeight());
    self.imageViewButton.layer.masksToBounds = YES;
    self.imageViewButton.userInteractionEnabled = false;
    [backGroundView addSubview:self.imageViewButton];
    
    self.imageViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20 *AdapterHeight())];
    self.imageViewLabel.center = CGPointMake(backGroundView.center.x, backGroundView.center.y + 36 *AdapterHeight());
    self.imageViewLabel.textAlignment = NSTextAlignmentCenter;
    self.imageViewLabel.textColor = [UIColor darkGrayColor];
    self.imageViewLabel.font = [UIFont systemFontOfSize:12 *AdapterWidth()];
    [backGroundView addSubview:self.imageViewLabel];
}

@end
