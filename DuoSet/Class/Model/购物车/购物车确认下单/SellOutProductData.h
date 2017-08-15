//
//  SellOutProductData.h
//  DuoSet
//
//  Created by fanfans on 2017/6/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SellOutProductData : NSObject

@property (nonatomic,copy) NSString *productNumber;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *repertory;
@property (nonatomic,copy) NSString *cartId;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
