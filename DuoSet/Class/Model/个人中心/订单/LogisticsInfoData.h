//
//  LogisticsInfoData.h
//  DuoSet
//
//  Created by fanfans on 2017/4/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TraceData.h"

@interface LogisticsInfoData : NSObject

@property(nonatomic,copy) NSString *orderNo;
@property(nonatomic,copy) NSString *express;
@property(nonatomic,copy) NSString *expressNum;
@property(nonatomic,strong) NSMutableArray *trace;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
