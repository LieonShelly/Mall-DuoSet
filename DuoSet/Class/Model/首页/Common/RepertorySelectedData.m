//
//  RepertorySelectedData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RepertorySelectedData.h"

@implementation RepertorySelectedData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"picture"]) {
            NSString *coverStr = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,coverStr];
        }
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"0";
        }
        if ([dic objectForKey:@"propertyCollection"]) {
            _propertyCollection = [dic objectForKey:@"propertyCollection"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyCollection"]] : @"";
        }
        if ([dic objectForKey:@"propertyName"]) {
            NSString *str = [dic objectForKey:@"propertyName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyName"]] : @"";
            NSArray *array = [str componentsSeparatedByString:@":"];
            _propertyName = @"";
            for (NSString *s in array) {
                _propertyName = [NSString stringWithFormat:@"%@%@，",_propertyName,s];
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
