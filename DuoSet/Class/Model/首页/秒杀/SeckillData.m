//
//  SeckillData.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "SeckillData.h"

@implementation SeckillData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _current = false;
        if ([dic objectForKey:@"beginDate"]) {
            NSString *str = [dic objectForKey:@"beginDate"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"beginDate"]] : @"";
            if (str.length > 0) {
                _biginDate = [NSString dateHourStrFormDateStr:str];
            }
        }
        if ([dic objectForKey:@"endDate"]) {
            NSString *str = [dic objectForKey:@"endDate"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"endDate"]] : @"";
            if (str.length > 0) {
                _endDate = [NSString dateHourStrFormDateStr:str];
            }
        }
        if ([dic objectForKey:@"name"]) {
            NSString *str = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
            _name = [NSString dateOnlyHourStrFromDataStr:str];
        }
        if ([dic objectForKey:@"current"]) {
            NSString *currentStr = [dic objectForKey:@"current"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"current"]] : @"0";
            _current = currentStr.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
