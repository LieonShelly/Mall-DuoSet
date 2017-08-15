//
//  RecommendForYouItem.m
//  DuoSet
//
//  Created by fanfans on 12/29/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "RecommendForYouItem.h"

@implementation RecommendForYouItem

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
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
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _productId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            NSString *str = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"0";
            _price = [NSString stringWithFormat:@"%.2lf",str.floatValue];
            
        }
        if ([dic objectForKey:@"soldAmout"]) {
            _soldAmout = [dic objectForKey:@"soldAmout"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"soldAmout"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
