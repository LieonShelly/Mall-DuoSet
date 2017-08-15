//
//  GloballistData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductForListData.h"

@interface GloballistData : NSObject

@property (nonatomic, copy) NSString *obj_id;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, strong) NSMutableArray *productList;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
