//
//  ShopCarSureProduct.m
//  DuoSet
//
//  Created by fanfans on 2017/3/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCarSureProduct.h"

@implementation ShopCarSureProduct

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"productId"]) {
            _product_id = [dic objectForKey:@"productId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"productNumber"]) {
            _productNumber = [dic objectForKey:@"productNumber"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]] : @"";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"properties"]) {
            _properties = [dic objectForKey:@"properties"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"properties"]] : @"";
        }
        if ([dic objectForKey:@"propertiesId"]) {
            _propertiesId = [dic objectForKey:@"propertiesId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertiesId"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            NSString *priceStr = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"0";
            _price = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
