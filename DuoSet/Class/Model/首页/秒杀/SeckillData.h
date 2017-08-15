//
//  SeckillData.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeckillData : NSObject

@property(nonatomic,copy) NSString *biginDate;
@property(nonatomic,copy) NSString *endDate;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) BOOL current;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
