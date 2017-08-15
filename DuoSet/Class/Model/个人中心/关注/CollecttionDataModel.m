//
//  CollecttionDataModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/20.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "CollecttionDataModel.h"

@implementation CollecttionDataModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _productId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
        if ([dic objectForKey:@"smallImg"]) {
        }
        if ([dic objectForKey:@"standard"]) {
            _standard = [dic objectForKey:@"standard"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"standard"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
