//
//  UserPiazzaInfoData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/25.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PiazzaItemData.h"

@interface UserPiazzaInfoData : NSObject

@property(nonatomic,copy)   NSString *beCollectCount;
@property(nonatomic,copy)   NSString *beConcernsCount;
@property(nonatomic,copy)   NSString *beLikeCount;
@property(nonatomic,copy)   NSString *collectCount;
@property(nonatomic,copy)   NSString *concernsCount;
@property(nonatomic,copy)   NSString *likeCount;
@property(nonatomic,copy)   NSString *avastar;
@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,assign) BOOL concerns;
@property(nonatomic,copy)   NSString *phone;
@property(nonatomic,strong) NSMutableArray<PiazzaItemData *> *communityArr;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
