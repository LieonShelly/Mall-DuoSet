//
//  CategoryItem.m
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "CategoryItem.h"

@implementation CategoryItem

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _isSeletced = false;
        if ([dic objectForKey:@"id"]) {
            _categoryId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"picture"]) {
            NSString *str = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"childs"]) {
            if ([[dic objectForKey:@"childs"] isKindOfClass:[NSArray class]]) {
                NSArray *childsArr = [dic objectForKey:@"childs"];
                _childs = [NSMutableArray array];
                for (NSDictionary *d in childsArr) {
                    CategoryItem *item = [CategoryItem dataForDictionary:d];
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
