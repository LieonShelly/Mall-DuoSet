//
//  ShopCarSureProduct.h
//  DuoSet
//
//  Created by fanfans on 2017/3/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarSureProduct : NSObject

@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *productNumber;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *properties;
@property (nonatomic,copy) NSString *propertiesId;
@property (nonatomic,copy) NSString *price;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
