//
//  SeckillTableHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobSessionData.h"

typedef void(^HeaderViewBannerBlock)(NSInteger index);

@interface SeckillTableHeaderView : UIView

@property(nonatomic,copy) HeaderViewBannerBlock bannerHandle;

-(void)setupInfoWithImgVArr:(NSArray *)urlImgArr;

-(void)setupCutDownLableShowWithHouStr:(NSString *)hourStr minStr:(NSString *)minStr secStr:(NSString *)secStr;

-(void)setupInfoWithRobSessionData:(RobSessionData *)item;

@end
