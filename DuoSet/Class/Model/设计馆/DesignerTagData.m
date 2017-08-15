//
//  DesignerTagData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerTagData.h"

@implementation DesignerTagData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _isSeletced = false;
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _tag_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"select"]) {
            NSString *str = [dic objectForKey:@"select"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"select"]] : @"0";
            _isSeletced = str.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
