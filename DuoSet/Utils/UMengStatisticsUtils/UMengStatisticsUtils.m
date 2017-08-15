//
//  UMengStatisticsUtils.m
//  DuoSet
//
//  Created by fanfans on 2017/3/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UMengStatisticsUtils.h"
#import "UMMobClick/MobClick.h"

@implementation UMengStatisticsUtils

+(void)profileSignInWithPUID:(NSString *)PUID{
    [MobClick profileSignInWithPUID:PUID];
}

+(void)profileSignInWithPUID:(NSString *)PUID provider:(NSString *)provider{
    [MobClick profileSignInWithPUID:PUID provider:provider];
}

+(void)event:(NSString *)eventId{
    [MobClick event:eventId];
}

+(void)event:(NSString *)eventId attributes:(NSDictionary *)attributes{
    [MobClick event:eventId attributes:attributes];
}

@end
