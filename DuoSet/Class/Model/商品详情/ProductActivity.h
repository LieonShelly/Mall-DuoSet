//
//  ProductActivity.h
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductActivity : NSObject

@property(nonatomic,copy) NSString *beginDate;
@property(nonatomic,copy) NSString *endDate;
@property(nonatomic,copy) NSString *activityId;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
