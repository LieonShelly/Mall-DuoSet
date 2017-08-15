//
//  CurrentFashionData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentFashionData : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *picture;
@property(nonatomic,copy) NSString *positionCode;
@property(nonatomic,copy) NSString *positionId;
@property(nonatomic,copy) NSString *positionName;
@property(nonatomic,copy) NSString *sequence;
@property(nonatomic,copy) NSString *classifyLevel;
@property(nonatomic,assign) HomePageTopBannerStyle type;
@property(nonatomic,copy) NSString *typeValue;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
