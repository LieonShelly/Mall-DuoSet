//
//  RecommendListData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RecommendListData.h"

@implementation RecommendListData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _seeCount = @"0";
        if ([dic objectForKey:@"adId"]) {
            _adId = [dic objectForKey:@"adId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"adId"]] : @"";
        }
        if ([dic objectForKey:@"adName"]) {
            _adName = [dic objectForKey:@"adName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"adName"]] : @"";
        }
        if ([dic objectForKey:@"picture"]) {
            NSString *str = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@!372x496",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"price"]) {
            NSString *str = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
            _price = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productNo"]) {
            _productNo = [dic objectForKey:@"productNo"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNo"]] : @"";
        }
        if ([dic objectForKey:@"seeCount"]) {
            _seeCount = [dic objectForKey:@"seeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"seeCount"]] : @"";
        }
        if ([dic objectForKey:@"sequence"]) {
            _sequence = [dic objectForKey:@"sequence"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"sequence"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
