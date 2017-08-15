//
//  AddressCity.h
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCounty.h"

@interface AddressCity : NSObject

@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSMutableArray *counties;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
