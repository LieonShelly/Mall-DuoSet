//
//  ProductListData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductListData : NSObject

@property(nonatomic,copy) NSString *buyedCount;
@property(nonatomic,copy) NSString *carryPrice;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *product_id;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *orderCount;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *repertory;
@property(nonatomic,copy) NSString *seeCount;
@property(nonatomic,copy) NSString *productSubName;
@property(nonatomic,assign) CGFloat imgHight;
@property(nonatomic,assign) BOOL isSeletced;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
