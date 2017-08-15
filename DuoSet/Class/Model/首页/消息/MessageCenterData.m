//
//  MessageCenterData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MessageCenterData.h"

@implementation MessageCenterData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"newMessageCount"]) {
            _unReadCount = [dic objectForKey:@"newMessageCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"newMessageCount"]] : @"0";
        }
        if ([dic objectForKey:@"typeName"]) {
            _typeName = [dic objectForKey:@"typeName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeName"]] : @"";
        }
        if ([dic objectForKey:@"typeIcon"]) {
            NSString *str = [dic objectForKey:@"typeIcon"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"typeIcon"]] : @"";
            _typeIcon = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"type"]) {
            _type_id = [dic objectForKey:@"type"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]] : @"0";
            if (_type_id.integerValue == 0) {
                _messageType = MessageTypeSystem;
            }
            if (_type_id.integerValue == 1) {
                _messageType = MessageTypeOrder;
            }
            if (_type_id.integerValue == 2) {
                _messageType = MessageTypeAsset;
            }
            if (_type_id.integerValue == 3) {
                _messageType = MessageTypePrivilege;
            }
        }
        if ([dic objectForKey:@"newMessageFirst"]) {
            if ([[dic objectForKey:@"newMessageFirst"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *messageDic = [dic objectForKey:@"newMessageFirst"];
                _message = [SystemMessageModel dataForDictionary:messageDic];
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
