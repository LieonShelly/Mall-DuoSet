//
//  RobSessionData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeTopBanner.h"

@interface RobSessionData : NSObject

@property(nonatomic,assign) BOOL isInRob;
@property(nonatomic,copy) NSString *isCurrentDay;
@property(nonatomic,copy) NSString *robSessionDisplay;
@property(nonatomic,copy) NSString *robSession;
@property(nonatomic,copy) NSString *countDown;
@property(nonatomic,strong) NSMutableArray *robTopBanners;
@property(nonatomic,copy)   NSString *robSessionName;


-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
