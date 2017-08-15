//
//  ProductDetailsSeckillData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailsSeckillData : NSObject

@property(nonatomic,copy) NSString *endTime;
@property(nonatomic,copy) NSString *robId;
@property(nonatomic,copy) NSString *robPrice;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,copy) NSString *systemTime;
@property(nonatomic,copy) NSString *buyCount;
@property(nonatomic,copy) NSString *count;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
