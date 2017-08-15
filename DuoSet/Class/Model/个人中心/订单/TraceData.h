//
//  ExpressData.h
//  DuoSet
//
//  Created by fanfans on 2017/4/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TraceData : NSObject

@property(nonatomic,copy) NSString *acceptTime;
@property(nonatomic,copy) NSString *acceptStation;
@property(nonatomic,assign) CGFloat cellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
