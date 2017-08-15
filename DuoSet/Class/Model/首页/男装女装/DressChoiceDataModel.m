//
//  DressChoiceDataModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "DressChoiceDataModel.h"

@implementation DressChoiceDataModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"coverImg"]) {
            NSString *str = [dic objectForKey:@"coverImg"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"coverImg"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _dressid = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"img"]) {
            NSString *str = [dic objectForKey:@"img"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"img"]] : @"";
            if (str.length > 0) {
            }else{
                _img = @"";
            }
        }
        if ([dic objectForKey:@"desc"]) {
            _desc = [dic objectForKey:@"desc"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
