//
//  CurrentFashionData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CurrentFashionData.h"

@implementation CurrentFashionData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"classifyLevel"]) {
            _classifyLevel = [dic objectForKey:@"classifyLevel"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"classifyLevel"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"picture"]) {
            NSString *str = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"positionCode"]) {
            _positionCode = [dic objectForKey:@"positionCode"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"positionCode"]] : @"";
        }
        if ([dic objectForKey:@"positionId"]) {
            _positionId = [dic objectForKey:@"positionId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"positionId"]] : @"";
        }
        if ([dic objectForKey:@"positionName"]) {
            _positionName = [dic objectForKey:@"positionName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"positionName"]] : @"";
        }
        if ([dic objectForKey:@"sequence"]) {
            _sequence = [dic objectForKey:@"sequence"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"sequence"]] : @"";
        }
        if ([dic objectForKey:@"type"]) {
            NSString *str = [dic objectForKey:@"type"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]] : @"0";
            switch (str.integerValue) {
                case 0:
                    _type = BannerProduct;
                    break;
                case 1:
                    _type = BannerWeb;
                    break;
                case 2:
                    _type = BannerSubObject;
                    break;
                case 3:
                    _type = BannerClsaaify;
                    break;
                case 4:
                    _type = BannerOrther;
                    break;
                    
                default:
                    break;
            }
        }
        if ([dic objectForKey:@"typeValue"]) {
            _typeValue = [dic objectForKey:@"typeValue"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeValue"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
