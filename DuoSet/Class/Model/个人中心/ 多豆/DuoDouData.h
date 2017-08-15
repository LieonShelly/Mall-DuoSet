//
//  DuoDouData.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DuoDouData : NSObject

@property(nonatomic,copy) NSString *count;
@property(nonatomic,copy) NSString *reason;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,assign) CGFloat cellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
