//
//  MustBuyListTypeData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MustBuyListTypeData : NSObject

@property(nonatomic,copy) NSString *buyListCount;
@property(nonatomic,copy) NSString *type_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *recommend;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
