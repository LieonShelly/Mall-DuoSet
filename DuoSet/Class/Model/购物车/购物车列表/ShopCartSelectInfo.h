//
//  ShopCartSelectInfo.h
//  DuoSet
//
//  Created by fanfans on 2017/6/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartSelectInfo : NSObject

@property (nonatomic, copy) NSString *allPrice;
@property (nonatomic, copy) NSString *allCarryPrice;
@property (nonatomic, copy) NSString *selectCount;
@property (nonatomic, assign) BOOL isSelectAll;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
