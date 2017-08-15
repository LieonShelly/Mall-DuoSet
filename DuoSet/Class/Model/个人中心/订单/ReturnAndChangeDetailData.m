//
//  ReturnAndChangeDetailData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeDetailData.h"

@implementation ReturnAndChangeDetailData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = FitHeight(80.0);
        if ([dic objectForKey:@"message"]) {
            _message = [dic objectForKey:@"message"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"message"]] : @"";
            _cellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(60.0) textString:_message textFont:13];
        }
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
            _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd HH:mm:ss"];
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
