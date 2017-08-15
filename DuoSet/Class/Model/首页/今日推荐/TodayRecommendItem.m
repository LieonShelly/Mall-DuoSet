//
//  TodayRecommendItem.m
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "TodayRecommendItem.h"

@implementation TodayRecommendItem

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _productId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"prePrice"]) {
            _prePrice = [dic objectForKey:@"prePrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"prePrice"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
        if ([dic objectForKey:@"smallImg"]) {
            NSString *str = [dic objectForKey:@"smallImg"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"smallImg"]] : @"";
            if (str.length > 0) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_Img_Url, str];
                NSString *imgStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                _smallImg = imgStr;
            }else{
                _smallImg = @"";
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
