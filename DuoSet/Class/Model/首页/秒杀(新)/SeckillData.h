//
//  SeckillData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentFashionData.h"
#import "SeckillListData.h"

@interface SeckillData : NSObject

@property (nonatomic, strong) CurrentFashionData *robTopBanner;
@property (nonatomic, strong) NSMutableArray *robs;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
