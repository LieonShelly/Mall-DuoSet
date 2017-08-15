//
//  MustBuyListTypeData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuyListTypeData.h"

@implementation MustBuyListTypeData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _type_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"buyListCount"]) {
            _buyListCount = [dic objectForKey:@"buyListCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"buyListCount"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"recommend"]) {
            _recommend = [dic objectForKey:@"recommend"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"recommend"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
