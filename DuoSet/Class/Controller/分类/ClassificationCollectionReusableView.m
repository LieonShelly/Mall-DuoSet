//
//  ClassificationCollectionReusableView.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/24.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ClassificationCollectionReusableView.h"

@implementation ClassificationCollectionReusableView

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
    self.classificationCollectionTitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.classificationCollectionTitleLabel.backgroundColor = LGBgColor;
    self.classificationCollectionTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*AdapterWidth()];
    self.classificationCollectionTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.classificationCollectionTitleLabel];
}
@end
