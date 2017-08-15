//
//  AppSpecialIconData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AppSpecialIconData.h"

@implementation AppSpecialIconData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"id"]) {
            _item_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
        }
        if ([dic objectForKey:@"titleIcon"]) {
            NSString *str = [dic objectForKey:@"titleIcon"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"titleIcon"]] : @"";
            _titleIcon = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"url"]) {
            _url = [dic objectForKey:@"url"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"url"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
