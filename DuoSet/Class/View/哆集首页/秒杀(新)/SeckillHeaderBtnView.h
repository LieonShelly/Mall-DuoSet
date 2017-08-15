//
//  SeckillHeaderBtnView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobSessionData.h"

@interface SeckillHeaderBtnView : UIView

-(void)setupInfoWithRobSessionData:(RobSessionData *)item;

-(void)showWithSeletced:(BOOL)seletced;

@end
