//
//  ShopCarModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/21.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ShopCarModel.h"

@implementation ShopCarModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _isSelected = false;
        if ([dic objectForKey:@"carryPrice"]) {
            _carryPrice = [dic objectForKey:@"carryPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"carryPrice"]] : @"0";
        }
        if ([dic objectForKey:@"cartId"]) {
            _cartId = [dic objectForKey:@"cartId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cartId"]] : @"";
        }
        if ([dic objectForKey:@"cartSelect"]) {
            NSString *str = [dic objectForKey:@"cartSelect"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cartSelect"]] : @"0";
            _cartSelect = str.integerValue == 1;
        }
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"createTime"]) {
            _createTime = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
        }
        if ([dic objectForKey:@"detail"]) {
            _detail = [dic objectForKey:@"detail"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"detail"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            NSString *priceStr = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"0";
            _price = [NSString stringWithFormat:@"%.2lf",priceStr.floatValue];
        }
        if ([dic objectForKey:@"productId"]) {
            _productId = [dic objectForKey:@"productId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productSubName"]) {
            _productSubName = [dic objectForKey:@"productSubName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productSubName"]] : @"";
        }
        if ([dic objectForKey:@"propertyCollection"]) {
            _propertyCollection = [dic objectForKey:@"propertyCollection"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyCollection"]] : @"";
        }
        if ([dic objectForKey:@"propertyName"]) {
            _propertyName = [dic objectForKey:@"propertyName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyName"]] : @"";
        }
        if ([dic objectForKey:@"repertoryCount"]) {
            _repertoryCount = [dic objectForKey:@"repertoryCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"repertoryCount"]] : @"";
        }
        if ([dic objectForKey:@"repertoryId"]) {
            _repertoryId = [dic objectForKey:@"repertoryId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"repertoryId"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
            switch (_status.integerValue) {
                case 0:
                    _productStatus = ShopCarProductSellStatusNormal;
                break;
                case 1:
                    _productStatus = ShopCarProductSellStatusSellEnd;
                break;
                default:
                _productStatus = ShopCarProductSellStatusNormal;
                break;
            }
        }
        if ([dic objectForKey:@"isGlobal"]) {
            NSString *str = [dic objectForKey:@"isGlobal"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isGlobal"]] : @"0";
            _isGlobal = str.integerValue == 1;
        }
        if ([dic objectForKey:@"canSelect"]) {
            NSString *str = [dic objectForKey:@"canSelect"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"canSelect"]] : @"0";
            _canSelect = str.integerValue == 1;
        }
        if ([dic objectForKey:@"words"]) {
            _words = [dic objectForKey:@"words"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"words"]] : @"";
        }
        if ([dic objectForKey:@"productNumber"]) {
            _productNumber = [dic objectForKey:@"productNumber"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
