//
//  ProductStandards.h
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Standard.h"

@interface ProductStandards : NSObject

@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,copy) NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
