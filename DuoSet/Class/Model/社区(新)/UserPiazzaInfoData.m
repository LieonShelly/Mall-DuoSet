//
//  UserPiazzaInfoData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/25.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserPiazzaInfoData.h"

@implementation UserPiazzaInfoData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _avastar = @"";
//        if ([dic objectForKey:@"cover"]) {
//            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
//            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
//        }
        if ([dic objectForKey:@"beCollectCount"]) {
            _beCollectCount = [dic objectForKey:@"beCollectCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"beCollectCount"]] : @"0";
        }
        if ([dic objectForKey:@"beConcernsCount"]) {
            _beConcernsCount = [dic objectForKey:@"beConcernsCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"beConcernsCount"]] : @"0";
        }
        if ([dic objectForKey:@"beLikeCount"]) {
            _beLikeCount = [dic objectForKey:@"beLikeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"beLikeCount"]] : @"0";
        }
        if ([dic objectForKey:@"collectCount"]) {
            _collectCount = [dic objectForKey:@"collectCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"collectCount"]] : @"0";
        }
        if ([dic objectForKey:@"concernsCount"]) {
            _concernsCount = [dic objectForKey:@"concernsCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"concernsCount"]] : @"0";
        }
        if ([dic objectForKey:@"likeCount"]) {
            _likeCount = [dic objectForKey:@"likeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeCount"]] : @"0";
        }
        if ([dic objectForKey:@"community"] && [[dic objectForKey:@"community"] isKindOfClass:[NSArray class]]) {
            NSArray *arr = [dic objectForKey:@"community"];
            _communityArr = [NSMutableArray array];
            for (NSDictionary *d in arr) {
                PiazzaItemData *item = [PiazzaItemData dataForDictionary:d];
                [_communityArr addObject:item];
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
