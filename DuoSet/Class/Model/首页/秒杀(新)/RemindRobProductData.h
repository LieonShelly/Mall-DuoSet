//
//  RemindRobProductData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RobProductData.h"

@interface RemindRobProductData : NSObject

@property(nonatomic,copy) NSString *robSessionDisplay;
@property(nonatomic,strong) NSMutableArray *robResponses;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
