//
//  ScreenProductController.h
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//  商品列表

#import "BaseViewController.h"

typedef enum : NSUInteger {
    ClassficationType,
    OtherType
} ScreenProductStyle;

@interface ScreenProductController : BaseViewController

-(instancetype)initWithScreenProductStyle:(ScreenProductStyle)type andKeyWords:(NSString *)keyWords;

-(instancetype)initWithScreenProductStyle:(ScreenProductStyle)type andItemId:(NSString *)itemId;

-(instancetype)initWithScreenProductStyle:(ScreenProductStyle)type andclassifyLevel:(NSString *)level  andItemId:(NSString *)itemId;

@end
