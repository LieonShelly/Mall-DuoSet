//
//  SeckillProduct.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeckillProduct : NSObject

@property(nonatomic,copy) NSString *seckillId;
@property(nonatomic,copy) NSString *killedAmount;
@property(nonatomic,copy) NSString *originalPrice;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *seckillPrice;
@property(nonatomic,copy) NSString *smallImg;
@property(nonatomic,copy) NSString *totalAmount;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
