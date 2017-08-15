//
//  ProductListData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductListData.h"

@implementation ProductListData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _isSeletced = false;
        _seeCount = @"0";
        if ([dic objectForKey:@"buyedCount"]) {
            _buyedCount = [dic objectForKey:@"buyedCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"buyedCount"]] : @"0";
        }
        if ([dic objectForKey:@"carryPrice"]) {
            _carryPrice = [dic objectForKey:@"carryPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"carryPrice"]] : @"0";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *coverStr = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@!750x550",BaseImgUrl,coverStr];
//            CGSize size = [Utils getImageSizeWithURLStr:_cover];
//            _imgHight = (mainScreenWidth - FitWith(60.0))/size.width * size.height;
        }
        if ([dic objectForKey:@"id"]) {
            _product_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"0";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productNumber"]) {
            _productNumber = [dic objectForKey:@"productNumber"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]] : @"";
        }
        if ([dic objectForKey:@"orderCount"]) {
            _orderCount = [dic objectForKey:@"orderCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderCount"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            NSString *str = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
            _price = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"seeCount"]) {
            _seeCount = [dic objectForKey:@"seeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"seeCount"]] : @"0";
        }
        if ([dic objectForKey:@"repertory"]) {
            _repertory = [dic objectForKey:@"repertory"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"repertory"]] : @"";
        }
        if ([dic objectForKey:@"productSubName"]) {
            _productSubName = [dic objectForKey:@"productSubName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productSubName"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
