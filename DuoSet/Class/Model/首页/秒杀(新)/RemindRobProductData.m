//
//  RemindRobProductData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RemindRobProductData.h"

@implementation RemindRobProductData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _robResponses = [NSMutableArray array];
        if ([dic objectForKey:@"robSessionDisplay"]) {
            _robSessionDisplay = [dic objectForKey:@"robSessionDisplay"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robSessionDisplay"]] : @"";
        }
        if ([dic objectForKey:@"robResponses"] && [[dic objectForKey:@"robResponses"] isKindOfClass:[NSArray class]]) {
            NSArray *arr = [dic objectForKey:@"robResponses"];
            for (NSDictionary *d in arr) {
                RobProductData *item = [RobProductData dataForDictionary:d];
                [_robResponses addObject:item];
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
