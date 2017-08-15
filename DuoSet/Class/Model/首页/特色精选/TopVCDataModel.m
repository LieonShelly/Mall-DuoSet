//
//  TopVCDataModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "TopVCDataModel.h"

@implementation TopVCDataModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"bigImgs"]) {
            NSString *str = [dic objectForKey:@"bigImgs"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"bigImgs"]] : @"";
            if (str.length > 0) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_Img_Url, str];
                NSString *imgStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                _bigImgs = imgStr;
            }else{
                _bigImgs = @"";
            }
        }
        if ([dic objectForKey:@"desc"]) {
            _desc = [dic objectForKey:@"desc"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _topItemId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
