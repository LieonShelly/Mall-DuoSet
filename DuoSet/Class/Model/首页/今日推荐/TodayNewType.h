//
//  TodayNewType.h
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayNewType : NSObject

@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *enabled;
@property (nonatomic, copy) NSString *typeId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sequence;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;


@end
