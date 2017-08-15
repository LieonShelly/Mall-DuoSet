//
//  HomeMatchProductData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeMatchProductData : NSObject

@property(nonatomic,copy) NSString *buyedCount;
@property(nonatomic,copy) NSString *carryPrice;
@property(nonatomic,copy) NSString *commentCount;
@property(nonatomic,copy) NSString *commentGood;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,assign) BOOL isCollect;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *orderCount;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *repertory;
@property(nonatomic,copy) NSString *seeCount;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *productSubName;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
