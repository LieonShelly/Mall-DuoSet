//
//  SeckillProduct.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "SeckillProduct.h"

@implementation SeckillProduct

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _seckillId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"killedAmount"]) {
            _killedAmount = [dic objectForKey:@"killedAmount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"killedAmount"]] : @"";
        }
        if ([dic objectForKey:@"originalPrice"]) {
            _originalPrice = [dic objectForKey:@"originalPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"originalPrice"]] : @"";
        }
        if ([dic objectForKey:@"productId"]) {
            _productId = [dic objectForKey:@"productId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"seckillPrice"]) {
            _seckillPrice = [dic objectForKey:@"seckillPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"seckillPrice"]] : @"";
        }
        if ([dic objectForKey:@"totalAmount"]) {
            _totalAmount = [dic objectForKey:@"totalAmount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalAmount"]] : @"";
        }
        if ([dic objectForKey:@"smallImg"]) {
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
