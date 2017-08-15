//
//  CategoryChild.m
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "CategoryChild.h"

@implementation CategoryChild

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _childId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"coverImg"]) {
            NSString *str = [dic objectForKey:@"coverImg"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"coverImg"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _coverImg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
        if ([dic objectForKey:@"img"]) {
            NSString *str = [dic objectForKey:@"img"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"img"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _img = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
