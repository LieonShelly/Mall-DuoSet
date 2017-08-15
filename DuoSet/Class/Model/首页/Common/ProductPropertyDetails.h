//
//  ProductPropertyDetails.h
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductPropertyDetails : NSObject

@property(nonatomic,copy) NSString *addPrice;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *itemId;
@property(nonatomic,assign) BOOL selected;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
