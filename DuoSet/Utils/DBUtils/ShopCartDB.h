//
//  DBUtils.h
//  DuoSet
//
//  Created by fanfans on 2017/2/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCarModel.h"

@interface ShopCartDB : NSObject

+ (ShopCartDB *)shareManager;

- (BOOL)isExistsDataWithModel:(ShopCarModel *)model;
- (NSArray *)allData;

- (BOOL)insertDataWithModel:(ShopCarModel *)model;
- (BOOL)insertDataWithShopCarModelItems:(NSArray *)items;

- (BOOL)deleteDataWithModel:(ShopCarModel *)model;
- (BOOL)deleteDataWithModels:(NSArray *)items;

- (BOOL)deleteAll;

- (BOOL)changeDataWithModel:(ShopCarModel *)model newStr:(NSString *)str;

@end
