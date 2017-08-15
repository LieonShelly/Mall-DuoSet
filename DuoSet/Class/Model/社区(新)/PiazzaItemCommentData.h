//
//  PiazzaItemCommentData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PiazzaItemChildCommentData.h"

@interface PiazzaItemCommentData : NSObject

@property(nonatomic,copy)   NSString *avastar;
@property(nonatomic,copy)   NSString *childTotalCount;
@property(nonatomic,copy)   NSString *communityId;
@property(nonatomic,copy)   NSString *content;
@property(nonatomic,copy)   NSString *createTime;
@property(nonatomic,copy)   NSString *communityCommentId;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,strong) NSMutableArray<PiazzaItemChildCommentData *> *childResponses;
@property(nonatomic,assign) CGFloat cellHight;
@property(nonatomic,assign) CGFloat noReplyCellHight;
@property(nonatomic,assign) BOOL liked;
@property(nonatomic,copy)   NSString *likeCount;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
