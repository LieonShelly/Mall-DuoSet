//
//  OrderCollectionReusableView.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/25.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "OrderCollectionReusableView.h"

@implementation OrderCollectionReusableView

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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:imageView];
    
    // 背景视图
    self.classificationCollectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 1)];
    self.classificationCollectionTitleLabel.backgroundColor = [UIColor whiteColor];
    self.classificationCollectionTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.classificationCollectionTitleLabel];
}

@end
