//
//  PiazzaItemChildCommentData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaItemChildCommentData.h"

@implementation PiazzaItemChildCommentData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _mainChildHight = FitHeight(80.0);
        _cellHight = FitHeight(160.0);
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"communityId"]) {
            _communityId = [dic objectForKey:@"communityId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"communityId"]] : @"";
        }
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
        }
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
            _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"MM-dd"];
        }
        if ([dic objectForKey:@"id"]) {
            _objId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"isChildReply"]) {
            NSString *str = [dic objectForKey:@"isChildReply"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isChildReply"]] : @"";
            _isChildReply = str.integerValue == 1;
        }
        if ([dic objectForKey:@"liked"]) {
            NSString *str = [dic objectForKey:@"liked"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"liked"]] : @"";
            _liked = str.integerValue == 1;
        }
        if ([dic objectForKey:@"likeCount"]) {
            _likeCount = [dic objectForKey:@"likeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeCount"]] : @"";
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
        if ([dic objectForKey:@"pid"]) {
            _pid = [dic objectForKey:@"pid"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"pid"]] : @"";
        }
        if ([dic objectForKey:@"relatedUserId"]) {
            _relatedUserId = [dic objectForKey:@"relatedUserId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"relatedUserId"]] : @"";
        }
        if ([dic objectForKey:@"relatedUserNickName"]) {
            _relatedUserNickName = [dic objectForKey:@"relatedUserNickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"relatedUserNickName"]] : @"";
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
    }
    if (_isChildReply) {
        _commentListContent = [NSString stringWithFormat:@"回复：@%@ %@",_relatedUserNickName,_content];
        NSString *replaceStr = _commentListContent;
        CGSize size = [replaceStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(mainScreenWidth - FitWith(130.0), 1000)];
        _cellHight += size.height;
    }else{
        NSString *replaceStr = _content;
        CGSize size = [replaceStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(mainScreenWidth - FitWith(130.0), 1000)];
        _cellHight += size.height;
        //主评论的灰色区域显示内容
        _mainChildContent = [NSString stringWithFormat:@"%@：%@",_nickName,_content];
        NSString *replaceStr1 = _mainChildContent;
        CGSize size1 = [replaceStr1 sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(mainScreenWidth - FitWith(130.0), 1000)];
        _mainChildHight += size1.height;
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
