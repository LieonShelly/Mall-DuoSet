//
//  HeadCollectionReusableView.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "HeadCollectionReusableView.h"

@implementation HeadCollectionReusableView

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
    self.productsHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20 *AdapterHeight())];
    self.productsHeadImageView.center = self.center;
    [self addSubview:self.productsHeadImageView];
}

@end
