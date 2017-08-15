//
//  TopNewVersion.h
//  DuoSet
//
//  Created by fanfans on 2017/4/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopNewVersion : NSObject

@property(nonatomic,copy) NSString *appExplain;
@property(nonatomic,copy) NSString *appType;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *version;
@property(nonatomic,assign) BOOL forcedUpdating;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
