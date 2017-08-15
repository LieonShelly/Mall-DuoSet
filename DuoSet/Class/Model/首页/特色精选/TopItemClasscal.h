//
//  TopItemClasscal.h
//  DuoSet
//
//  Created by fanfans on 12/29/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopItemClasscal : NSObject

@property(nonatomic,copy) NSString *classcalId;
@property(nonatomic,copy) NSString *imgUrl;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
