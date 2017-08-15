//
//  RobProductData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurDetailResponse.h"

@interface RobProductData : NSObject

@property(nonatomic,copy) NSString *cover;
@property(nonatomic,strong) CurDetailResponse *curDetailResponse;
@property(nonatomic,copy) NSString *obj_id;
@property(nonatomic,assign) BOOL isInRob;
@property(nonatomic,assign) BOOL isRemind;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *remindCode;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *progress;
@property(nonatomic,copy) NSString *remindCount;
@property(nonatomic,copy) NSString *robDate;
@property(nonatomic,copy) NSString *robSession;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *totalCount;
@property(nonatomic,copy) NSString *totalSellCount;
@property(nonatomic,copy) NSString *sessionStartTime;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
