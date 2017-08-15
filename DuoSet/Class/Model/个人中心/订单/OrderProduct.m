//
//  OrderProduct.m
//  DuoSet
//
//  Created by fanfans on 12/28/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "OrderProduct.h"

@implementation OrderProduct

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"productSmallImg"]) {
        }
        if ([dic objectForKey:@"amount"]) {
            _amount = [dic objectForKey:@"amount"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]] : @"";
        }
        if ([dic objectForKey:@"isDiscuss"]) {
            NSString *str = [dic objectForKey:@"isDiscuss"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"isDiscuss"]] : @"";
            if (str.length > 0) {
                _isDiscuss = str.integerValue == 1;
            }else{
                _isDiscuss = false;
            }
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
        if ([dic objectForKey:@"productDesc"]) {
            _productDesc = [dic objectForKey:@"productDesc"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productDesc"]] : @"";
        }
        if ([dic objectForKey:@"productId"]) {
            _productId = [dic objectForKey:@"productId"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"standard"]) {
            _standard = [dic objectForKey:@"standard"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"standard"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
