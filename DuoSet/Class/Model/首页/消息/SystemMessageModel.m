//
//  SystemMessageModel.m
//  DuoSet
//
//  Created by fanfans on 2017/2/25.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SystemMessageModel.h"

@implementation SystemMessageModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = FitHeight(80.0);
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
            if (str.length > 0) {
                _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy/MM/dd"];
            }
        }
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
            _cellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(96.0) textString:_content textFont:13];
        }
        if ([dic objectForKey:@"id"]) {
            _message_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
            _cellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(96.0) textString:_title textFont:13];
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
