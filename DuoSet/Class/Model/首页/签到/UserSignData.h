//
//  UserSignData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSignData : NSObject

@property(nonatomic,copy) NSString *pointCount;
@property(nonatomic,copy) NSString *signDays;
@property(nonatomic,assign) BOOL todayIsSign;
@property(nonatomic,copy) NSString *signRemark;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
