//
//  PiazzaCommentData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaCommentData.h"

@implementation PiazzaCommentData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = 0.0;
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"communityId"]) {
            _communityId = [dic objectForKey:@"communityId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"communityId"]] : @"";
        }
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
            _cellHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(244.0) textString:_content textFont:13];
        }
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
            _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd HH:mm:ss"];
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
        _cellHight += FitHeight(100.0);
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
