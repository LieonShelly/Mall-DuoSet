//
//  CommentHomeData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentHomeData : NSObject

@property(nonatomic,copy) NSString *totalCount;
@property(nonatomic,copy) NSString *highGrade;
@property(nonatomic,copy) NSString *positiveGrade;
@property(nonatomic,copy) NSString *badGrade;
@property(nonatomic,copy) NSString *hasPic;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
