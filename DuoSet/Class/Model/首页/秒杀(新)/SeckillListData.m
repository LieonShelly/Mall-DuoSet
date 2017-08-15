//
//  SeckillListData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillListData.h"

@implementation SeckillListData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"0";
        }
        if ([dic objectForKey:@"buyCount"]) {
            _buyCount = [dic objectForKey:@"buyCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"buyCount"]] : @"0";
        }
        if ([dic objectForKey:@"limitCount"]) {
            _limitCount = [dic objectForKey:@"limitCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"limitCount"]] : @"0";
        }
        if ([dic objectForKey:@"endTime"]) {
            _endTime = [dic objectForKey:@"endTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"endTime"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _seckill_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
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
        if ([dic objectForKey:@"robPrice"]) {
            NSString *str = [dic objectForKey:@"robPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"robPrice"]] : @"";
            _robPrice = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"startTime"]) {
            _startTime = [dic objectForKey:@"startTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"startTime"]] : @"";
            _startTimeStr = [NSString dateStrFormTimeInterval:_startTime andFormatStr:@"HH:mm:ss"];
        }
        if ([dic objectForKey:@"systemTime"]) {
            _systemTime = [dic objectForKey:@"systemTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"systemTime"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            NSString *str = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
            if (str.integerValue == -1) {
                _status = SecKillWillBegin;
            }
            if (str.integerValue == 0) {
                _status = SecKillBedoing;
            }
            if (str.integerValue == 1) {
                _status = SecKillisEnd;
            }
            if (str.integerValue == 2) {
                _status = SeckillisOver;
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
