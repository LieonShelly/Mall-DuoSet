//
//  FirstHeaderdReusableView.m
//  DuoSet
//
//  Created by fanfans on 2017/4/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FirstHeaderdReusableView.h"

@implementation FirstHeaderdReusableView

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
    self.backgroundColor = LGBgColor;
    
    self.headerImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20 *AdapterHeight(), mainScreenWidth - 120 *AdapterWidth() , 115 *AdapterHeight())];
    [self addSubview:self.headerImgV];
    
    self.classificationCollectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headerImgV.frame.origin.y + self.headerImgV.frame.size.height, mainScreenWidth - 130 *AdapterWidth(), 40 *AdapterHeight())];
    self.classificationCollectionTitleLabel.backgroundColor = LGBgColor;
    self.classificationCollectionTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14*AdapterWidth()];
    self.classificationCollectionTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.classificationCollectionTitleLabel];
}


@end
