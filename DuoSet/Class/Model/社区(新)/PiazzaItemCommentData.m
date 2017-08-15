//
//  PiazzaItemCommentData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaItemCommentData.h"

@implementation PiazzaItemCommentData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _noReplyCellHight = FitHeight(180.0);
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"childTotalCount"]) {
            _childTotalCount = [dic objectForKey:@"childTotalCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"childTotalCount"]] : @"";
        }
        if ([dic objectForKey:@"communityId"]) {
            _communityId = [dic objectForKey:@"communityId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"communityId"]] : @"";
        }
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
            NSString *replaceStr = _content;
//            replaceStr = [replaceStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//            replaceStr = [replaceStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            CGSize size = [replaceStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(mainScreenWidth - FitWith(130.0), 1000)];
//            _noReplyCellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(120.0) textString:replaceStr lineSpacing:2 textFont:13];
            _noReplyCellHight += size.height;
        }
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
            _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"MM-dd"];
        }
        if ([dic objectForKey:@"id"]) {
            _communityCommentId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
        if ([dic objectForKey:@"childResponses"] && [[dic objectForKey:@"childResponses"] isKindOfClass:[NSArray class]]) {
            _childResponses = [NSMutableArray array];
            NSArray *childArr = [dic objectForKey:@"childResponses"];
            for (NSDictionary *d in childArr) {
                PiazzaItemChildCommentData *item = [PiazzaItemChildCommentData dataForDictionary:d];
                [_childResponses addObject:item];
            }
        }
        if ([dic objectForKey:@"likeCount"]) {
            _likeCount = [dic objectForKey:@"likeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeCount"]] : @"";
        }
        if ([dic objectForKey:@"liked"]) {
            NSString *str = [dic objectForKey:@"liked"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"liked"]] : @"0";
            _liked = str.integerValue == 1;
        }
    }
    if (_childResponses.count > 0) {
        PiazzaItemChildCommentData *item = _childResponses[0];
        _cellHight = item.mainChildHight + _noReplyCellHight + 30;
    }else{
        _cellHight = _noReplyCellHight;
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
