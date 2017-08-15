//
//  ActivityData.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityData : NSObject

@property(nonatomic,copy) NSString *object_id;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *descr;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *enabled;
@property(nonatomic,copy) NSString *createTime;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
