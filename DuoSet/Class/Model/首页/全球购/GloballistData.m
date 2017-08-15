//
//  GloballistData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GloballistData.h"

@implementation GloballistData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _obj_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"picture"]) {
            NSString *coverStr = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,coverStr];
        }
        if ([dic objectForKey:@"productList"]) {
            _productList = [NSMutableArray array];
            if ([[dic objectForKey:@"productList"] isKindOfClass:[NSArray class]]) {
                NSArray *items = [dic objectForKey:@"productList"];
                for (NSDictionary *d in items) {
                    ProductForListData *item = [ProductForListData dataForDictionary:d];
                    [_productList addObject:item];
                }
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
