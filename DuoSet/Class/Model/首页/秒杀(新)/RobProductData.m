//
//  RobProductData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RobProductData.h"

@implementation RobProductData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@!750x550",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"curDetailResponse"] && [[dic objectForKey:@"curDetailResponse"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *objDic = [dic objectForKey:@"curDetailResponse"];
            _curDetailResponse = [CurDetailResponse dataForDictionary:objDic];
        }
        if ([dic objectForKey:@"id"]) {
            _obj_id= [dic objectForKey:@"id"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"isInRob"]) {
            NSString *str = [dic objectForKey:@"isInRob"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isInRob"]] : @"0";
            _isInRob = str.integerValue == 1;
        }
        if ([dic objectForKey:@"isRemind"]) {
            NSString *str = [dic objectForKey:@"isRemind"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isRemind"]] : @"0";
            _isRemind = str.integerValue == 1;
        }
        if ([dic objectForKey:@"productId"]) {
            _productId= [dic objectForKey:@"productId"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productNumber"]) {
            _productNumber = [dic objectForKey:@"productNumber"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]] : @"";
        }
        if ([dic objectForKey:@"progress"]) {
            _progress = [dic objectForKey:@"progress"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"progress"]] : @"";
        }
        if ([dic objectForKey:@"remindCount"]) {
            _remindCount = [dic objectForKey:@"remindCount"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"remindCount"]] : @"";
        }
        if ([dic objectForKey:@"robDate"]) {
            _robDate = [dic objectForKey:@"robDate"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robDate"]] : @"";
        }
        if ([dic objectForKey:@"remindCode"]) {
            _remindCode = [dic objectForKey:@"remindCode"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"remindCode"]] : @"";
        }
        if ([dic objectForKey:@"robSession"]) {
            _robSession = [dic objectForKey:@"robSession"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robSession"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
        }
        if ([dic objectForKey:@"totalCount"]) {
            _totalCount = [dic objectForKey:@"totalCount"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalCount"]] : @"";
        }
        if ([dic objectForKey:@"totalSellCount"]) {
            _totalSellCount = [dic objectForKey:@"totalSellCount"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalSellCount"]] : @"";
        }
        if ([dic objectForKey:@"sessionStartTime"]) {
            _sessionStartTime = [dic objectForKey:@"sessionStartTime"] != nil ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"sessionStartTime"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
