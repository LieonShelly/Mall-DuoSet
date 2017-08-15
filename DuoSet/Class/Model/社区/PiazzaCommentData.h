//
//  PiazzaCommentData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiazzaCommentData : NSObject

@property(nonatomic,copy) NSString *avastar;
@property(nonatomic,copy) NSString *communityId;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,assign) CGFloat cellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
