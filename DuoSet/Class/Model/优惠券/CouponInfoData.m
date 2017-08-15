//
//  CouponInfoData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CouponInfoData.h"

@implementation CouponInfoData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"codeStatus"]) {
            NSString *str = [dic objectForKey:@"codeStatus"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"codeStatus"]] : @"40";
            switch (str.integerValue) {
                case 10:
                    _codeStatus = CouponUseWithNoGet;
                    break;
                case 20:
                    _codeStatus = CouponUseWithNoUse;
                    break;
                case 30:
                    _codeStatus = CouponUseWithUsed;
                    break;
                case 40:
                    _codeStatus = CouponUseWithPastDue;
                    break;
                    
                default:
                    _codeStatus = CouponUseWithPastDue;
                    break;
            }
        }
        if ([dic objectForKey:@"amount"]) {
            _amount = [dic objectForKey:@"amount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]] : @"0";
        }
        if ([dic objectForKey:@"couponId"]) {
            _couponId = [dic objectForKey:@"couponId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"couponId"]] : @"0";
        }
        if ([dic objectForKey:@"couponType"]) {
//            NSString *str = [dic objectForKey:@"couponType"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"couponType"]] : @"-1";
            _couponType = CouponfullMinus;
//            if (str.integerValue == 10) {
//                _couponType = CouponfullMinus;
//            }else if (str.integerValue == 20){
//                _couponType = CouponDiscount;
//            }else{
//                _couponType = CouponOther;
//            }
        }
        if ([dic objectForKey:@"description"]) {
            _descriptionStr = [dic objectForKey:@"description"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"description"]] : @"";
        }
        if ([dic objectForKey:@"endTime"]) {
            _endTime = [dic objectForKey:@"endTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"endTime"]] : @"";
        }
        if ([dic objectForKey:@"fullAmountUse"]) {
            _fullAmountUse = [dic objectForKey:@"fullAmountUse"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"fullAmountUse"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"rangeType"]) {
            _rangeType = [dic objectForKey:@"rangeType"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"rangeType"]] : @"";
        }
        if ([dic objectForKey:@"startTime"]) {
            _startTime = [dic objectForKey:@"startTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"startTime"]] : @"";
        }
        if ([dic objectForKey:@"validDay"]) {
            _validDay = [dic objectForKey:@"validDay"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"validDay"]] : @"";
        }
        if ([dic objectForKey:@"couponSelectedResonse"]) {
            if ([[dic objectForKey:@"couponSelectedResonse"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *seletcedDic = [dic objectForKey:@"couponSelectedResonse"];
                _couponSelectedResonse = [CouponSeletcedData dataForDictionary:seletcedDic];
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
