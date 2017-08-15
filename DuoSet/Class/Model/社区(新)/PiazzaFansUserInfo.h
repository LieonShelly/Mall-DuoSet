//
//  PiazzaFansUserInfo.h
//  DuoSet
//
//  Created by fanfans on 2017/5/25.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiazzaFansUserInfo : NSObject

@property(nonatomic,copy)   NSString *avastar;
@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,assign) BOOL concerns;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
