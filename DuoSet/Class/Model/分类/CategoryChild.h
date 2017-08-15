//
//  CategoryChild.h
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryChild : NSObject

@property(nonatomic,copy) NSString *coverImg;
@property(nonatomic,copy) NSString *childId;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
