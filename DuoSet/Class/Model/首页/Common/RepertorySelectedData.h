//
//  RepertorySelectedData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepertorySelectedData : NSObject

@property(nonatomic,copy) NSString *propertyCollection;
@property(nonatomic,copy) NSString *count;
@property(nonatomic,copy) NSString *picture;
@property(nonatomic,copy) NSString *propertyName;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
