//
//  HomeMatchData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeMatchData.h"

@implementation HomeMatchData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"descr"]) {
            _descr = [dic objectForKey:@"descr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"descr"]] : @"";
        }
        if ([dic objectForKey:@"home"]) {
            _home = [dic objectForKey:@"home"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"home"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _match_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"moreDescr"]) {
            _moreDescr = [dic objectForKey:@"moreDescr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"moreDescr"]] : @"";
        }
        if ([dic objectForKey:@"picture"]) {
            NSString *str = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"titleIcon"]) {
            NSString *str = [dic objectForKey:@"titleIcon"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"titleIcon"]] : @"";
            _titleIcon = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"productEntityOne"]) {
            if ([[dic objectForKey:@"productEntityOne"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDic = [dic objectForKey:@"productEntityOne"];
                _productEntityOne = [HomeMatchProductData dataForDictionary:itemDic];
            }
        }
        if ([dic objectForKey:@"productEntityTwo"]) {
            if ([[dic objectForKey:@"productEntityTwo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDic = [dic objectForKey:@"productEntityTwo"];
                _productEntityTwo = [HomeMatchProductData dataForDictionary:itemDic];
            }
        }
        if ([dic objectForKey:@"productEntityThree"]) {
            if ([[dic objectForKey:@"productEntityThree"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDic = [dic objectForKey:@"productEntityThree"];
                _productEntityThree = [HomeMatchProductData dataForDictionary:itemDic];
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
