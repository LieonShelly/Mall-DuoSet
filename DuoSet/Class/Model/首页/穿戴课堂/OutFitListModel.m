//
//  OutFitListModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/13.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "OutFitListModel.h"

@implementation OutFitListModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"url"]) {
            
        }
        if ([dic objectForKey:@"goodNum"]) {
            _goodNum = [dic objectForKey:@"goodNum"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"goodNum"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _outFitid = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
