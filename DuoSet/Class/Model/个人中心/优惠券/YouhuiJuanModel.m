//
//  YouhuiJuanModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/20.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "YouhuiJuanModel.h"

@implementation YouhuiJuanModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"createDate"]) {
            _createDate = [dic objectForKey:@"createDate"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"createDate"]] : @"";
            _createDateStr = [NSString dateStrFormTimeInterval:_createDate andFormatStr:@"yyyy-MM-dd"];
            
        }
        if ([dic objectForKey:@"img"]) {
        }
        if ([dic objectForKey:@"customerId"]) {
            _customerId = [dic objectForKey:@"customerId"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"customerId"]] : @"";
        }
        if ([dic objectForKey:@"doorsill"]) {
            _doorsill = [dic objectForKey:@"doorsill"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"doorsill"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _couponId = [dic objectForKey:@"id"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
        if ([dic objectForKey:@"term"]) {//
            _term = [dic objectForKey:@"term"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"term"]] : @"";
            NSString *str = [NSString stringWithFormat:@"%ld",_createDate.integerValue + _term.integerValue * 86400000];
            _endDateStr = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy/MM/dd"];
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
