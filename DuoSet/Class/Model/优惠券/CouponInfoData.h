//
//  CouponInfoData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CouponSeletcedData.h"

typedef enum : NSUInteger {
    CouponfullMinus,
    CouponDiscount,
    CouponOther,
} CouponType;

typedef enum : NSUInteger {
    CouponUseWithNoGet,
    CouponUseWithNoUse,
    CouponUseWithUsed,
    CouponUseWithPastDue
} CouponUseType;


@interface CouponInfoData : NSObject

@property(nonatomic,assign) CouponUseType codeStatus;
@property(nonatomic,copy) NSString *amount;
@property(nonatomic,copy) NSString *couponId;
@property(nonatomic,assign) CouponType couponType;
@property(nonatomic,copy) NSString *descriptionStr;
@property(nonatomic,copy) NSString *endTime;
@property(nonatomic,copy) NSString *fullAmountUse;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *rangeType;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,copy) NSString *validDay;
@property(nonatomic,strong) CouponSeletcedData *couponSelectedResonse;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
