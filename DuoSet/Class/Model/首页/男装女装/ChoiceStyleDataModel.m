//
//  ChoiceStyleDataModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "ChoiceStyleDataModel.h"

@implementation ChoiceStyleDataModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"coverImg"]) {
            NSString *str = [dic objectForKey:@"coverImg"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"coverImg"]] : @"";
            if (str.length > 0) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_Img_Url, str];
                NSString *imgStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                _coverImg = imgStr;
            }else{
                _coverImg = @"";
            }
        }
        if ([dic objectForKey:@"id"]) {
            _styleId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"img"]) {
            NSString *str = [dic objectForKey:@"img"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"img"]] : @"";
            if (str.length > 0) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_Img_Url, str];
                NSString *imgStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                _img = imgStr;
            }else{
                _img = @"";
            }
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
