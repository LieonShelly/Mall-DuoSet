//
//  SearchData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchData : NSObject

@property(nonatomic,copy) NSString *obj_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *create_time;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
