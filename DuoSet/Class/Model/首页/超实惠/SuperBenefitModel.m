//
//  SuperBenefitModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "SuperBenefitModel.h"

@implementation SuperBenefitModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"bannerImg"]) {
        }
        if ([dic objectForKey:@"themeImg"]) {
        }
        if ([dic objectForKey:@"themeId"]) {
            _themeId = [dic objectForKey:@"themeId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"themeId"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
