//
//  ShopCartSelectInfo.m
//  DuoSet
//
//  Created by fanfans on 2017/6/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartSelectInfo.h"

@implementation ShopCartSelectInfo

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"allPrice"]) {
            NSString *str = [dic objectForKey:@"allPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"allPrice"]] : @"0";
            _allPrice = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"allCarryPrice"]) {
            NSString *str = [dic objectForKey:@"allCarryPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"allCarryPrice"]] : @"0";
            _allCarryPrice = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"selectCount"]) {
            _selectCount = [dic objectForKey:@"selectCount"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"selectCount"]] : @"";
        }
        if ([dic objectForKey:@"isSelectAll"]) {
            NSString *str = [dic objectForKey:@"isSelectAll"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"isSelectAll"]] : @"0";
            _isSelectAll = str.integerValue == 1;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
