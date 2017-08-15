//
//  UserInfo.h
//  BossApp
//
//  Created by fanfans on 5/12/16.
//  Copyright © 2016 ZDJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(nonatomic,copy) NSString *avatar;
@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *refreshToken;
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *uuid;
@property(nonatomic,copy) NSString *currentCity;
@property(nonatomic,copy) NSString *currentProvince;
@property(nonatomic,copy) NSString *latitude;
@property(nonatomic,copy) NSString *longitude;
@property(nonatomic,copy) NSString *expiresIn;
@property(nonatomic,strong) NSDate *refreshTokenDate;

+(instancetype)dataForDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
