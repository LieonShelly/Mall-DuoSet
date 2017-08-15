//
//  HotTypeModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/14.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "HotTypeModel.h"

@implementation HotTypeModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"bannerImg"]) {
        }
        if ([dic objectForKey:@"id"]) {
            _hotTypeId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"img"]) {
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
