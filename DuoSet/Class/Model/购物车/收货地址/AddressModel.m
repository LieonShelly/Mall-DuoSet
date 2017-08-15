//
//  AddressModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/21.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _isSeletced = false;
        if ([dic objectForKey:@"addr"]) {
            _addr = [dic objectForKey:@"addr"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"addr"]] : @"";
        }
        if ([dic objectForKey:@"area"]) {
            _area = [dic objectForKey:@"area"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"area"]] : @"";
        }
        if ([dic objectForKey:@"city"]) {
            _city = [dic objectForKey:@"city"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"city"]] : @"";
        }
        if ([dic objectForKey:@"def"]) {
            _def = [dic objectForKey:@"def"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"def"]] : @"0";
            _isDEFAULT = _def.integerValue == 1;
            _isSeletced = _isDEFAULT;
        }
        if ([dic objectForKey:@"id"]) {
            _address_id = [dic objectForKey:@"id"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"phone"]) {
            _phone = [dic objectForKey:@"phone"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"phone"]] : @"";
        }
        if ([dic objectForKey:@"province"]) {
            _province = [dic objectForKey:@"province"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"province"]] : @"";
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
