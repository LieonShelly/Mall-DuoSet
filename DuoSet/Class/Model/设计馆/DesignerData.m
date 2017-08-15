//
//  DesignerData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerData.h"

@implementation DesignerData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _backReasonCellHight = FitHeight(80.0);
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"createTime"]) {
            _createTime = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
        }
        if ([dic objectForKey:@"follow"]) {
            NSString *str = [dic objectForKey:@"follow"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"follow"]] : @"0";
            _follow = str.integerValue == 1;
        }
        if ([dic objectForKey:@"followCount"]) {
            _followCount = [dic objectForKey:@"followCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"followCount"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _designer_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"phone"]) {
            _phone = [dic objectForKey:@"phone"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"phone"]] : @"";
        }
        if ([dic objectForKey:@"weixin"]) {
            _weixin = [dic objectForKey:@"weixin"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"weixin"]] : @"";
        }
        if ([dic objectForKey:@"qq"]) {
            _qq = [dic objectForKey:@"qq"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"qq"]] : @"";
        }
        if ([dic objectForKey:@"backReason"]) {
            _backReason = [dic objectForKey:@"backReason"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"backReason"]] : @"";
            _backReasonCellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(48.0) textString:_backReason textFont:14];
        }
        if ([dic objectForKey:@"reason"]) {
            _reason = [dic objectForKey:@"reason"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"reason"]] : @"";
        }
        if ([dic objectForKey:@"idcardFront"]) {
            _idcardFront = [dic objectForKey:@"idcardFront"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"idcardFront"]] : @"";
        }
        if ([dic objectForKey:@"idcardBack"]) {
            _idcardBack = [dic objectForKey:@"idcardBack"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"idcardBack"]] : @"";
        }
        if ([dic objectForKey:@"tagList"]) {
            _tagList = [NSMutableArray array];
            NSMutableString *tagStr = [NSMutableString string];
            if ([[dic objectForKey:@"tagList"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"tagList"];
                if (arr.count > 0) {
                    for (NSString *s in arr) {
                        [_tagList addObject:s];
                        [tagStr  appendFormat:@"%@", [NSString stringWithFormat:@"%@、",s]];
                    }
                    _tag = [tagStr substringToIndex:tagStr.length-1];
                }else{
                    _tag = @"";
                }
            }
        }
        if ([dic objectForKey:@"type"]) {
            _type = [dic objectForKey:@"type"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]] : @"";
            if (_type.integerValue == 0) {
                _typeName = @"哆集设计师";
            }
            if (_type.integerValue == 1) {
                _typeName = @"特色设计师";
            }
            if (_type.integerValue == 2) {
                _typeName = @"品牌设计师";
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
