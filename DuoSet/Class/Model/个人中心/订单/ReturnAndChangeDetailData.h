//
//  ReturnAndChangeDetailData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnAndChangeDetailData : NSObject

@property(nonatomic,copy)   NSString *message;
@property(nonatomic,copy)   NSString *createTime;
@property(nonatomic,assign) CGFloat cellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
