//
//  UMengStatisticsUtils.h
//  DuoSet
//
//  Created by fanfans on 2017/3/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMengStatisticsUtils : NSObject

+(void)profileSignInWithPUID:(NSString *)PUID;

+(void)profileSignInWithPUID:(NSString *)PUID provider:(NSString *)provider;

+(void)event:(NSString *)eventId;

+(void)event:(NSString *)eventId attributes:(NSDictionary *)attributes;

@end
