//
//  RewardListData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RewardListData : NSObject

@property(nonatomic,copy)   NSString *communityId;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,copy)   NSString *rewarCount;
@property(nonatomic,copy)   NSString *rewarLimitCount;
@property(nonatomic,copy)   NSString *title;
@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,copy)   NSString *showContent;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
