//
//  SeckillListData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeckillListData : NSObject

@property(nonatomic,copy) NSString *count;
@property(nonatomic,copy) NSString *buyCount;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *endTime;
@property(nonatomic,copy) NSString *seckill_id;
@property(nonatomic,copy) NSString *limitCount;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *robPrice;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,copy) NSString *startTimeStr;
@property(nonatomic,assign) SecKillStatus status;
@property(nonatomic,copy) NSString *systemTime;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
