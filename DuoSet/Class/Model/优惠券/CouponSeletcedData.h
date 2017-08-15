//
//  CouponSeletcedData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponSeletcedData : NSObject

@property(nonatomic,assign) BOOL canSelected;
@property(nonatomic,assign) BOOL selected;
@property(nonatomic,copy) NSString *couponCodeId;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
