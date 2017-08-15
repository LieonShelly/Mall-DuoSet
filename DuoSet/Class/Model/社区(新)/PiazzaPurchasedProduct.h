//
//  PiazzaPurchasedProduct.h
//  DuoSet
//
//  Created by fanfans on 2017/5/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiazzaPurchasedProduct : NSObject

@property(nonatomic,copy)   NSString *cover;
@property(nonatomic,copy)   NSString *productId;
@property(nonatomic,copy)   NSString *productName;
@property(nonatomic,copy)   NSString *productNumber;
@property(nonatomic,copy)   NSString *price;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
