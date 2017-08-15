//
//  TadayNewItemTypeData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CurrentFashionData.h"
#import "TodayNewType.h"

@interface TadayNewItemTypeData : NSObject

@property (nonatomic, copy) CurrentFashionData *todayNewTopBanner;
@property (nonatomic, strong) NSMutableArray *todayNewTypes;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
