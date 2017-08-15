//
//  RecommendListData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendListData : NSObject

@property(nonatomic,copy) NSString *adId;
@property(nonatomic,copy) NSString *adName;
@property(nonatomic,copy) NSString *picture;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productNo;
@property(nonatomic,copy) NSString *seeCount;
@property(nonatomic,copy) NSString *sequence;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
