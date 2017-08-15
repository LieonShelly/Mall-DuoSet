//
//  HomeMatchProductData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeMatchProductData.h"

@implementation HomeMatchProductData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _seeCount = @"0";
        if ([dic objectForKey:@"buyedCount"]) {
            _buyedCount = [dic objectForKey:@"buyedCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"buyedCount"]] : @"";
        }
        if ([dic objectForKey:@"carryPrice"]) {
            _carryPrice = [dic objectForKey:@"carryPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"carryPrice"]] : @"";
        }
        if ([dic objectForKey:@"commentCount"]) {
            _commentCount = [dic objectForKey:@"commentCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"commentCount"]] : @"";
        }
        if ([dic objectForKey:@"commentGood"]) {
            _commentGood = [dic objectForKey:@"commentGood"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"commentGood"]] : @"";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@!750x550",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"isCollect"]) {
            NSString *str = [dic objectForKey:@"isCollect"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isCollect"]] : @"0";
            _isCollect = str.integerValue == 1;
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
        if ([dic objectForKey:@"repertory"]) {
            _repertory = [dic objectForKey:@"repertory"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"repertory"]] : @"";
        }
        if ([dic objectForKey:@"seeCount"]) {
            _seeCount = [dic objectForKey:@"seeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"seeCount"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
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
