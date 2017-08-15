//
//  NSString+JsonString.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JsonString)

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

@end
