//
//  SearchPiazzaDataDB.h
//  DuoSet
//
//  Created by fanfans on 2017/5/26.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchData.h"

@interface SearchPiazzaDataDB : NSObject

+ (SearchPiazzaDataDB *)shareManager;

- (NSArray *)allData;

- (BOOL)insertDataWithModel:(SearchData *)model;

- (BOOL)deleteAllData;

- (BOOL)deleteDataWithModel:(SearchData *)model;

@end
