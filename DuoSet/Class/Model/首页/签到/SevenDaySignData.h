//
//  SevenDaySignData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SevenDaySignData : NSObject

@property(nonatomic,copy) NSString *day;
@property(nonatomic,assign) BOOL isSign;
@property(nonatomic,copy) NSString *pointCount;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
