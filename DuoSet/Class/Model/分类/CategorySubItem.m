//
//  CategorySubItem.m
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "CategorySubItem.h"

@implementation CategorySubItem

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _subCategoryId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"img"]) {
            NSString *str = [dic objectForKey:@"img"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"img"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _subimg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"childs"]) {
            if ([[dic objectForKey:@"childs"] isKindOfClass:[NSArray class]]) {
                NSArray *childs = [dic objectForKey:@"childs"];
                _childs = [NSMutableArray array];
                for (NSDictionary *d in childs) {
                    CategoryChild *item = [CategoryChild dataForDictionary:d];
                    [_childs addObject:item];
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
