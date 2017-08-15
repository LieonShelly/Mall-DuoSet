//
//  PiazzaItemData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CommunityStautsDefault,
    CommunityStautsNoCheck,
    CommunityStautsCheckFail
} CommunityStauts;


@interface PiazzaItemData : NSObject

@property(nonatomic,copy)   NSString *communityId;
@property(nonatomic,copy)   NSString *avastar;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,assign) BOOL isLike;
@property(nonatomic,assign) BOOL isCollect;
@property(nonatomic,copy)   NSString *collectNum;
@property(nonatomic,copy)   NSString *likeCount;
@property(nonatomic,copy)   NSString *title;
@property(nonatomic,copy)   NSString *content;
@property(nonatomic,copy)   NSString *coverPic;
@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,copy)   NSString *checkReason;
@property(nonatomic,assign) CommunityStauts status;

@property(nonatomic,assign) CGFloat cellHight;
@property(nonatomic,assign) CGFloat titleHight;
@property(nonatomic,assign) CGFloat contentHight;
@property(nonatomic,assign) CGFloat coverHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
