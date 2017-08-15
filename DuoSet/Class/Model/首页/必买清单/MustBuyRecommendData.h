//
//  MustBuyRecommendData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MustBuyRecommendData : NSObject

@property(nonatomic,copy) NSString *list_id;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *headeCover;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,copy) NSString *pv;
@property(nonatomic,copy) NSString *shareCount;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;


@end
