//
//  RecommendToYou.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/13.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendToYou : NSObject


+ (NSString *)recommendToYouGetNetData: (NSDictionary *)dict;

+ (NSString *) styleChoiceTypeGetNetData: (NSDictionary *)dict;
@end
