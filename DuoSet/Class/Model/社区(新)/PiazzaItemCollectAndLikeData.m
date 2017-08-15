//
//  PiazzaItemCollectAndLikeData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaItemCollectAndLikeData.h"

@implementation PiazzaItemCollectAndLikeData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"community"] && [[dic objectForKey:@"community"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *communityDic = [dic objectForKey:@"community"];
            if ([communityDic objectForKey:@"collectCount"]) {
                _collectCount = [communityDic objectForKey:@"collectCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"collectCount"]] : @"";
            }
            if ([communityDic objectForKey:@"id"]) {
                _communityId = [communityDic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"id"]] : @"";
            }
            if ([communityDic objectForKey:@"likeCount"]) {
                _likeCount = [communityDic objectForKey:@"likeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"likeCount"]] : @"";
            }
            if ([communityDic objectForKey:@"commentCount"]) {
                _commentCount = [communityDic objectForKey:@"commentCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"commentCount"]] : @"";
            }
            if ([communityDic objectForKey:@"title"]) {
                _title = [communityDic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"title"]] : @"";
            }
            if ([communityDic objectForKey:@"content"]) {
                _content = [communityDic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"content"]] : @"";
            }
            if ([communityDic objectForKey:@"coverPic"]) {
                NSString *str = [communityDic objectForKey:@"coverPic"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"coverPic"]] : @"";
                _coverPic = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
            }
            if ([communityDic objectForKey:@"isCollect"]) {
                NSString *str = [communityDic objectForKey:@"isCollect"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"isCollect"]] : @"0";
                _isCollect = str.integerValue == 1;
            }
            if ([communityDic objectForKey:@"isLike"]) {
                NSString *str = [communityDic objectForKey:@"isLike"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"isLike"]] : @"0";
                _isLike = str.integerValue == 1;
            }
            if ([communityDic objectForKey:@"createTime"]) {
                NSString *str = [communityDic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[communityDic objectForKey:@"createTime"]] : @"";
                if (str.length == 0) {
                    _createTime = @"";
                }else{
                    _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"MM-dd"];
                }
            }
        }
        if ([dic objectForKey:@"communityPicture"] && [[dic objectForKey:@"communityPicture"] isKindOfClass:[NSArray class]]) {
            NSArray *picArr = [dic objectForKey:@"communityPicture"];
            _communityPictureArr = [NSMutableArray array];
            _communityfullPictureArr = [NSMutableArray array];
            for (NSDictionary *d in picArr) {
                if ([d objectForKey:@"picture"]) {
                    NSString *imgUrl = [NSString stringWithFormat:@"%@%@!750x750",BaseImgUrl,[d objectForKey:@"picture"]];
                    [_communityPictureArr addObject:imgUrl];
                    NSString *imgUrl2 = [NSString stringWithFormat:@"%@%@",BaseImgUrl,[d objectForKey:@"picture"]];
                    [_communityfullPictureArr addObject:imgUrl2];
                }
            }
        }
        if ([dic objectForKey:@"user"] && [[dic objectForKey:@"user"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *userDic = [dic objectForKey:@"user"];
            if ([userDic objectForKey:@"avastar"]) {
                NSString *str = [userDic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[userDic objectForKey:@"avastar"]] : @"";
                _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
            }
            if ([userDic objectForKey:@"concerns"]) {
                NSString *str = [userDic objectForKey:@"concerns"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[userDic objectForKey:@"concerns"]] : @"0";
                _concerns = str.integerValue == 1;
            }
            if ([userDic objectForKey:@"id"]) {
                _userId = [userDic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[userDic objectForKey:@"id"]] : @"";
            }
            if ([userDic objectForKey:@"nickName"]) {
                _nickName = [userDic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[userDic objectForKey:@"nickName"]] : @"";
            }
            if ([userDic objectForKey:@"phone"]) {
                _phone = [userDic objectForKey:@"phone"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[userDic objectForKey:@"phone"]] : @"";
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
