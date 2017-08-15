//
//  UserCenterMainData.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenterMainData : NSObject

@property(nonatomic,copy) NSString *collectCount;
@property(nonatomic,copy) NSString *balance;
@property(nonatomic,copy) NSString *vipLevel;
@property(nonatomic,copy) NSString *couponCodeCount;
@property(nonatomic,copy) NSString *pointCount;

@property(nonatomic,copy) NSString *waitPayCount;
@property(nonatomic,copy) NSString *waitResiveCount;
@property(nonatomic,copy) NSString *waitCommentCount;
@property(nonatomic,copy) NSString *exchangeAndReturnCount;
@property(nonatomic,copy) NSString *allCount;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
