//
//  Product.h
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductActivity.h"
#import "ProductDetail.h"

@interface Product : NSObject

@property(nonatomic,strong) ProductActivity *activity;
@property(nonatomic,strong) ProductDetail *productDetail;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
