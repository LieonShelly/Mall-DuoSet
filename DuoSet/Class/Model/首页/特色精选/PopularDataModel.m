//
//  PopularDataModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "PopularDataModel.h"

@implementation PopularDataModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"coverImg"]) {
            NSString *str = [dic objectForKey:@"coverImg"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"coverImg"]] : @"";
            if (str.length > 0) {
                
            }else{
                _coverImg = @"";
            }
        }
        if ([dic objectForKey:@"desc"]) {
            _desc = [dic objectForKey:@"desc"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]] : @"";
        }
        if ([dic objectForKey:@"level"]) {
            _level = [dic objectForKey:@"level"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"level"]].integerValue : 0;
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"labels"]) {
            if ([[dic objectForKey:@"labels"] isKindOfClass:[NSArray class]]) {
                NSArray *labels = [dic objectForKey:@"labels"];
                _labels = [NSMutableArray array];
                for (NSString *str in labels) {
                    [_labels addObject:str];
                }
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
