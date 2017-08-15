//
//  QualificationData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    CheckInfoNotBegin,
    CheckInfoSuccess,
    CheckInfoFailure,
} CheckInfoType;

@interface QualificationData : NSObject

@property(nonatomic,copy) NSString *bankAccount;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *entrustPicture;
@property(nonatomic,copy) NSString *obj_id;
@property(nonatomic,copy) NSString *openBank;
@property(nonatomic,copy) NSString *registerAddress;
@property(nonatomic,copy) NSString *registerPhone;
@property(nonatomic,assign) CheckInfoType status;
@property(nonatomic,copy) NSString *unitName;
@property(nonatomic,copy) NSString *userId;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
