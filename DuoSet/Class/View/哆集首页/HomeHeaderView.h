//
//  HomeHeaderView.h
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainData.h"

typedef void(^BannerActionBlcok)(NSInteger);
typedef void(^HeaderViewAdActionBlock)();
typedef void(^HeaderViewClassifierBlock)(NSInteger);

@interface HomeHeaderView : UIView

@property(nonatomic,copy) BannerActionBlcok bannerHandle;
@property(nonatomic,copy) HeaderViewAdActionBlock adTapHandle;
@property(nonatomic,copy) HeaderViewClassifierBlock classChickHandle;

-(void)setupInfoWithHomeMainData:(HomeMainData *)item;

@end
