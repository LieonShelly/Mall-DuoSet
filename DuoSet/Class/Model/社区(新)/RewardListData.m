//
//  RewardListData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RewardListData.h"

@implementation RewardListData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"communityId"]) {
            _communityId = [dic objectForKey:@"communityId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"communityId"]] : @"";
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
        if ([dic objectForKey:@"rewarCount"]) {
            _rewarCount = [dic objectForKey:@"rewarCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"rewarCount"]] : @"";
        }
        if ([dic objectForKey:@"rewarLimitCount"]) {
            _rewarLimitCount = [dic objectForKey:@"rewarLimitCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"rewarLimitCount"]] : @"";
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
    }
    _showContent = [NSString stringWithFormat:@"《%@》文章被赞%@次，特此奖励%@哆豆!",_title,_rewarLimitCount,_rewarCount];
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
