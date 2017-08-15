//
//  PiazzaUserData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiazzaUserData : NSObject

@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *avastar;
@property(nonatomic,copy) NSString *createTime;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
