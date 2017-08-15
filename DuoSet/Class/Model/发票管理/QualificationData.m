//
//  QualificationData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "QualificationData.h"

@implementation QualificationData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"entrustPicture"]) {
            NSString *str = [dic objectForKey:@"entrustPicture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"entrustPicture"]] : @"";
            _entrustPicture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"bankAccount"]) {
            _bankAccount = [dic objectForKey:@"bankAccount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"bankAccount"]] : @"";
        }
        if ([dic objectForKey:@"code"]) {
            _code = [dic objectForKey:@"code"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]] : @"";
        }
        if ([dic objectForKey:@"createTime"]) {
            _createTime = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _obj_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"openBank"]) {
            _openBank = [dic objectForKey:@"openBank"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"openBank"]] : @"";
        }
        if ([dic objectForKey:@"registerAddress"]) {
            _registerAddress = [dic objectForKey:@"registerAddress"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"registerAddress"]] : @"";
        }
        if ([dic objectForKey:@"registerPhone"]) {
            _registerPhone = [dic objectForKey:@"registerPhone"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"registerPhone"]] : @"";
        }
        if ([dic objectForKey:@"unitName"]) {
            _unitName = [dic objectForKey:@"unitName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"unitName"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            NSString *str = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"0";
            if (str.integerValue == 0) {
                _status = CheckInfoNotBegin;
            }
            if (str.integerValue == 1) {
                _status = CheckInfoSuccess;
            }
            if (str.integerValue == 2) {
                _status = CheckInfoFailure;
            }
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
