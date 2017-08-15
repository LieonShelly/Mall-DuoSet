//
//  SearchDataDB.h
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchData.h"

@interface SearchDataDB : NSObject

+ (SearchDataDB *)shareManager;

- (NSArray *)allData;

- (BOOL)insertDataWithModel:(SearchData *)model;

- (BOOL)deleteAllData;

- (BOOL)deleteDataWithModel:(SearchData *)model;

@end
