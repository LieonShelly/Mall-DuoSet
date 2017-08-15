//
//  OrderCollectionViewCell.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/25.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "OrderCollectionViewCell.h"

@implementation OrderCollectionViewCell

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
//    backGroundView.backgroundColor = [UIColor redColor];
    [self addSubview:backGroundView];
    
    self.imageViewButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38 *AdapterWidth(), 32 *AdapterHeight())];
    self.imageViewButton.center = CGPointMake(backGroundView.center.x, backGroundView.center.y - 12 *AdapterHeight());
    [self.imageViewButton setImage:IMAGE_NAME(@"待付款png") forState:UIControlStateNormal];
    self.imageViewButton.layer.masksToBounds = YES;
    [backGroundView addSubview:self.imageViewButton];
    
    self.imageViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60 *AdapterWidth(), 20 *AdapterHeight())];
    self.imageViewLabel.center = CGPointMake(backGroundView.center.x, backGroundView.center.y + 12 *AdapterHeight());
    self.imageViewLabel.textAlignment = NSTextAlignmentCenter;
    self.imageViewLabel.textColor = [UIColor darkGrayColor];
    self.imageViewLabel.font = [UIFont systemFontOfSize:14 *AdapterWidth()];
    self.imageViewLabel.text = @"待付款";
    [backGroundView addSubview:self.imageViewLabel];
}

@end
