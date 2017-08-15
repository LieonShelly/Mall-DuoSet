//
//  VipData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VipLevelData.h"

@interface VipData : NSObject

@property(nonatomic,copy) NSString *pointCount;
@property(nonatomic,assign) long vipValue;
@property(nonatomic,copy) NSString *level;
@property(nonatomic,copy) NSString *vipLevel;
@property(nonatomic,copy) NSString *vipLevelName;
@property(nonatomic,copy) NSString *vipValueStr;
@property(nonatomic,strong) NSMutableArray *vipLevels;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;


@end
