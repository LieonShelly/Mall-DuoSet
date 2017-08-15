//
//  ExpressData.m
//  DuoSet
//
//  Created by fanfans on 2017/4/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TraceData.h"

@implementation TraceData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = FitHeight(80.0);
        if ([dic objectForKey:@"acceptTime"]) {
            NSString *str = [dic objectForKey:@"acceptTime"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"acceptTime"]] : @"";
            _acceptTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd HH:mm:ss"];
        }
        if ([dic objectForKey:@"acceptStation"]) {
            _acceptStation = [dic objectForKey:@"acceptStation"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"acceptStation"]] : @"";
            CGFloat hight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(120.0) textString:_acceptStation textFont:12];
            _cellHight += hight;
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
