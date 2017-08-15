//
//  OutFitDetail.m
//  DuoSet
//
//  Created by fanfans on 12/29/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "OutFitDetail.h"

@implementation OutFitDetail

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"imgs"]) {
            if ([[dic objectForKey:@"imgs"] isKindOfClass:[NSArray class]]) {
                NSArray *imgs = [dic objectForKey:@"imgs"];
                _imgs = [NSMutableArray array];
                for (NSString *str in imgs) {
                    if (str.length > 0) {
                        NSString *urlStr = [NSString stringWithFormat:@"%@%@", Base_Img_Url, str];
                        NSString *imgStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        [_imgs addObject:imgStr];
                    }
                }
            }
        }
        if ([dic objectForKey:@"lables"]) {
            if ([[dic objectForKey:@"lables"] isKindOfClass:[NSArray class]]) {
                _lables = [NSMutableArray array];
                NSArray *lables = [dic objectForKey:@"lables"];
                for (NSString *str in lables) {
                    [_lables addObject:str];
                }
            }
        }
        if ([dic objectForKey:@"products"]) {
            if ([[dic objectForKey:@"products"] isKindOfClass:[NSArray class]]) {
                _products = [NSMutableArray array];
                NSArray *products = [dic objectForKey:@"products"];
                for (NSDictionary *d in products) {
                    OutFitDetailProduct *product = [OutFitDetailProduct dataForDictionary:d];
                    [_products addObject:product];
                }
            }
        }
        if ([dic objectForKey:@"goodNum"]) {
            _goodNum = [dic objectForKey:@"goodNum"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"goodNum"]] : @"";
        }
        if ([dic objectForKey:@"desc"]) {
            _desc = [dic objectForKey:@"desc"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
