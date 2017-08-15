//
//  TopItemClasscal.m
//  DuoSet
//
//  Created by fanfans on 12/29/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "TopItemClasscal.h"

@implementation TopItemClasscal

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"imgUrl"]) {
            NSString *str = [dic objectForKey:@"imgUrl"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] : @"";
            if (str.length > 0) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_Img_Url, str];
                NSString *imgStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                _imgUrl = imgStr;
            }else{
                _imgUrl = @"";
            }
        }
        if ([dic objectForKey:@"id"]) {
            _classcalId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
