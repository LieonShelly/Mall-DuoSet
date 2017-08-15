//
//  ShopCartStandardRepertoryData.h
//  DuoSet
//
//  Created by fanfans on 2017/6/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartStandardRepertoryData : NSObject

@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *price;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
