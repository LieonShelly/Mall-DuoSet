//
//  NavIconData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NavIconData.h"

@implementation NavIconData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"code"]) {
            _code = [dic objectForKey:@"code"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]] : @"-1";
            switch (_code.integerValue) {
                    //5表示今日新品；6表示设计馆；7表示全球购；8表示客服中心；0表示分类
                case 0:
                    _navIconStatus = AppNavIconClassification;
                    break;
                case 5:
                    _navIconStatus = AppNavIconTodayNewItem;
                    break;
                case 6:
                    _navIconStatus = AppNavIconDesigning;
                    break;
                case 7:
                    _navIconStatus = AppNavIconGlobalBuy;
                    break;
                case 8:
                    _navIconStatus = AppNavIconService;
                    break;
                    
                default:
                    break;
            }
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
        }
        if ([dic objectForKey:@"classifyId"]) {
            _classifyId = [dic objectForKey:@"classifyId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"classifyId"]] : @"";
        }
        if ([dic objectForKey:@"titleIcon"]) {
            NSString *str = [dic objectForKey:@"titleIcon"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"titleIcon"]] : @"";
            _titleIcon = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
