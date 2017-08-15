//
//  DuoDouData.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "DuoDouData.h"

@implementation DuoDouData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = FitHeight(80.0);
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"";
        }
        if ([dic objectForKey:@"reason"]) {
            _reason = [dic objectForKey:@"reason"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"reason"]] : @"";
            _cellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(164.0) textString:_reason textFont:14];
        }
        if ([dic objectForKey:@"time"]) {
            NSString *str = [dic objectForKey:@"time"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]] : @"";
            if (str.length > 0 && str.integerValue > 0) {
                _time = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd HH:mm"];
            }else{
                _time = @"";
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
