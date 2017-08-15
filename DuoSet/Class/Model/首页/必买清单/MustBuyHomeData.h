//
//  MustBuyHomeData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MustBuyRecommendData.h"
#import "MustBuyListTypeData.h"


@interface MustBuyHomeData : NSObject

@property(nonatomic,strong) NSMutableArray *recommend;
@property(nonatomic,strong) NSMutableArray *buyListType;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;




@end
