//
//  PiazzaData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PiazzaUserData.h"

@interface PiazzaData : NSObject

@property(nonatomic,copy) NSString *avastar;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *browseCount;
@property(nonatomic,copy) NSString *commentCount;
@property(nonatomic,copy) NSMutableArray *communityCommentResponses;
@property(nonatomic,copy) NSMutableArray *communityLikeReponses;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *communityId;
@property(nonatomic,assign) BOOL likeCommunity;
@property(nonatomic,copy) NSString *likeCount;
@property(nonatomic,copy) NSMutableArray *pics;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,assign) BOOL top;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,assign) CGFloat cellHight;
@property(nonatomic,strong) NSMutableArray *picHights;
@property(nonatomic,assign) CGFloat detailCellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
