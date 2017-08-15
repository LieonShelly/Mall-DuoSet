//
//  AddressProvinceData.h
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressCity.h"

@interface AddressProvinceData : NSObject

@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSMutableArray *cities;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
