//
//  ProductForListData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductForListData.h"

@implementation ProductForListData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _seeCount = @"0";
        if ([dic objectForKey:@"picture"]) {
            NSString *coverStr = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@!750x550",BaseImgUrl,coverStr];
            _pictureForCollectionCell = [NSString stringWithFormat:@"%@%@!372x496",BaseImgUrl,coverStr];
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *coverStr = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@!750x550",BaseImgUrl,coverStr];
//            _pictureForCollectionCell = [NSString stringWithFormat:@"%@%@!372x496",BaseImgUrl,coverStr];
        }
        if ([dic objectForKey:@"price"]) {
            NSString *str = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
            _price = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"productId"]) {
            _productId = [dic objectForKey:@"productId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productNumber"]) {
            _productNumber = [dic objectForKey:@"productNumber"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]] : @"";
        }
        if ([dic objectForKey:@"seeCount"]) {
            _seeCount = [dic objectForKey:@"seeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"seeCount"]] : @"";
        }
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"";
        }
        if ([dic objectForKey:@"productSubName"]) {
            _productSubName = [dic objectForKey:@"productSubName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productSubName"]] : @"";
        }
        if ([dic objectForKey:@"propertyCollection"]) {
            _propertyCollection = [dic objectForKey:@"propertyCollection"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyCollection"]] : @"";
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
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
