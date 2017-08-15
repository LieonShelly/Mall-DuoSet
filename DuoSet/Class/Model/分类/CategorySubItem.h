//
//  CategorySubItem.h
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryChild.h"

@interface CategorySubItem : NSObject

@property(nonatomic,strong) NSMutableArray *childs;
@property(nonatomic,copy) NSString *subCategoryId;
@property(nonatomic,copy) NSString *subimg;
@property(nonatomic,copy) NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
