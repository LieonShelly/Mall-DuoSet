//
//  ProductPropertyData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductPropertyDetails.h"

@interface ProductPropertyData : NSObject

@property(nonatomic,copy) NSString *property_id;
@property(nonatomic,copy) NSString *propertyName;
@property(nonatomic,strong) NSMutableArray *childValues;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
