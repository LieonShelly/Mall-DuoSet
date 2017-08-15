//
//  PiazzaItemData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaItemData.h"

@implementation PiazzaItemData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = 50;
        _coverHight = 200.0;
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
        if ([dic objectForKey:@"collectNum"]) {
            _collectNum = [dic objectForKey:@"collectNum"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"collectNum"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            NSString *str = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"40";
            switch (str.integerValue) {
                case 30:
                    _status = CommunityStautsNoCheck;
                    break;
                case 40:
                    _status = CommunityStautsDefault;
                    break;
                case 50:
                    _status = CommunityStautsCheckFail;
                    break;
                    
                default:
                    break;
            }
        }
        if ([dic objectForKey:@"id"]) {
            _communityId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
        if ([dic objectForKey:@"checkReason"]) {
            _checkReason = [dic objectForKey:@"checkReason"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"checkReason"]] : @"";
        }
        if ([dic objectForKey:@"isLike"]) {
            NSString *str = [dic objectForKey:@"isLike"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isLike"]] : @"0";
            _isLike = str.integerValue == 1;
        }
        if ([dic objectForKey:@"isCollect"]) {
            NSString *str = [dic objectForKey:@"isCollect"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isCollect"]] : @"0";
            _isCollect = str.integerValue == 1;
        }
        if ([dic objectForKey:@"likeCount"]) {
            _likeCount = [dic objectForKey:@"likeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeCount"]] : @"";
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
            if (_title.length == 0) {
                _titleHight = 0.0;
            }else{
                CGFloat hight = [NSString countTextHightLabelWidth:FitWith(320.0) textString:_title textFont:13];
                if (hight >= 30) {
                    _titleHight = 30;
                }else{
                    _titleHight = hight;
                }
            }
        }
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
            if (_content.length == 0) {
                _contentHight = 0.0;
            }else{
                NSString *replaceStr = _content;
//                replaceStr = [replaceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
//                replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//                replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                CGSize size = [replaceStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(FitWith(320.0), 1000)];
//                CGFloat hight = [NSString countTextHightLabelWidth:FitWith(320.0) textString:replaceStr textFont:13];
                CGFloat hight = size.height;
                if (hight >= 35) {
                    _contentHight = 35;
                }else{
                    _contentHight = hight;
                }
            }
        }
        if ([dic objectForKey:@"coverPic"]) {
            NSString *str = [dic objectForKey:@"coverPic"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"coverPic"]] : @"";
            _coverPic = [NSString stringWithFormat:@"%@%@!w750",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"coverSize"]) {
            NSString *str = [dic objectForKey:@"coverSize"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"coverSize"]] : @"";
            if (str.length > 0) {
                NSArray *sizeArr = [str componentsSeparatedByString:@"x"];
                CGFloat hight = ((NSString *)sizeArr[1]).floatValue;
                CGFloat width = ((NSString *)sizeArr[0]).floatValue;
                CGFloat scale = hight/ width;
                CGFloat picHight =  FitWith(342.0) * scale;
                _coverHight = picHight >= 212 ? 212 : picHight;
            }
        }
    }
    _cellHight = _cellHight + _coverHight + _contentHight + _titleHight;
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
