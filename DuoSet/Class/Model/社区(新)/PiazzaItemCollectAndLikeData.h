//
//  PiazzaItemCollectAndLikeData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiazzaItemCollectAndLikeData : NSObject

@property(nonatomic,copy)   NSString *communityId;
@property(nonatomic,copy)   NSString *collectCount;
@property(nonatomic,copy)   NSString *likeCount;
@property(nonatomic,copy)   NSString *commentCount;
@property(nonatomic,copy)   NSString *title;
@property(nonatomic,copy)   NSString *content;
@property(nonatomic,copy)   NSString *coverPic;
@property(nonatomic,copy)   NSString *createTime;
@property(nonatomic,assign) BOOL isCollect;
@property(nonatomic,assign) BOOL isLike;
@property(nonatomic,strong) NSMutableArray *communityPictureArr;
@property(nonatomic,strong) NSMutableArray *communityfullPictureArr;

@property(nonatomic,assign) BOOL concerns;
@property(nonatomic,copy)   NSString *avastar;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,copy)   NSString *phone;
@property(nonatomic,copy)   NSString *userId;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
