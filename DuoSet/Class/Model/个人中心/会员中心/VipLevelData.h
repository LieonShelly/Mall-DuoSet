//
//  VipLevelData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipLevelData : NSObject

@property(nonatomic,assign) long endValue;
@property(nonatomic,assign) long startValue;
@property(nonatomic,copy) NSString *level;
@property(nonatomic,copy) NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;


@end
