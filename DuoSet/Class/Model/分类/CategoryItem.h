//
//  CategoryItem.h
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryItem : NSObject

@property(nonatomic,copy) NSString *categoryId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *picture;
@property(nonatomic,strong) NSMutableArray *childs;
@property(nonatomic,assign) BOOL isSeletced;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
