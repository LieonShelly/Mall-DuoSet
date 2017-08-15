//
//  ViewControllerClassificationCollectionViewCell.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/22.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ViewControllerClassificationCollectionViewCell.h"

@implementation ViewControllerClassificationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化视图
        [self initView];
    }
    return self;
}
/**初始化视图*/
- (void)initView {
    // 背景视图
    UIView *backGroundView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:backGroundView];
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45 *AdapterWidth(), 45*AdapterWidth())];
    _imageV.center = CGPointMake(backGroundView.center.x, backGroundView.center.y - 8 *AdapterHeight());
    [backGroundView addSubview:_imageV];
    
    self.imageViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 75 *AdapterWidth(), 20 *AdapterHeight())];
    self.imageViewLabel.center = CGPointMake(backGroundView.center.x, backGroundView.center.y + 26 *AdapterHeight());
    self.imageViewLabel.textAlignment = NSTextAlignmentCenter;
    self.imageViewLabel.textColor = [UIColor colorFromHex:0x222222];
    self.imageViewLabel.font = [UIFont systemFontOfSize:12];
    [backGroundView addSubview:self.imageViewLabel];
}

@end
