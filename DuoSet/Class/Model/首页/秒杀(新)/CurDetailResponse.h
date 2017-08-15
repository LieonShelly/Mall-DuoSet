//
//  CurDetailResponse.h
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurDetailResponse : NSObject

@property(nonatomic,strong) NSString *count;
@property(nonatomic,strong) NSString *obj_id;
@property(nonatomic,strong) NSString *price;
@property(nonatomic,strong) NSString *propertyCollection;
@property(nonatomic,strong) NSString *propertyName;
@property(nonatomic,strong) NSString *repertoryId;
@property(nonatomic,strong) NSString *robCount;
@property(nonatomic,strong) NSString *robDate;
@property(nonatomic,strong) NSString *robId;
@property(nonatomic,strong) NSString *robPrice;
@property(nonatomic,strong) NSString *robSession;
@property(nonatomic,strong) NSString *sellCount;
@property(nonatomic,strong) NSString *surplusCount;
@property(nonatomic,strong) NSString *userRobCount;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
