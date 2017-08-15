//
//  GlobalHomeData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalAreaData.h"
#import "ProductForListData.h"
#import "CurrentFashionData.h"

@interface GlobalHomeData : NSObject

@property (nonatomic, strong) NSMutableArray *globalList;
@property (nonatomic, strong) NSMutableArray *globalMiddleBanner;
@property (nonatomic, strong) NSMutableArray *globalTopBanner;
@property (nonatomic, strong) NSMutableArray *productList;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;



@end
