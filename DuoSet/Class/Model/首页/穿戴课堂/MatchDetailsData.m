//
//  MatchDetailsData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MatchDetailsData.h"

@implementation MatchDetailsData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _headerDesHight = 0.0;
        _subDesHight = 0.0;
        if ([dic objectForKey:@"descr"]) {
            _descr = [dic objectForKey:@"descr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"descr"]] : @"";
            _headerDesHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(48) textString:_descr textFont:14];
        }
        if ([dic objectForKey:@"home"]) {
            _home = [dic objectForKey:@"home"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"home"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _match_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"moreDescr"]) {
            _moreDescr = [dic objectForKey:@"moreDescr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"moreDescr"]] : @"";
            _subDesHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(48) textString:_moreDescr textFont:14];
        }
        if ([dic objectForKey:@"picture"]) {
            NSString *str = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"sequence"]) {
            _sequence = [dic objectForKey:@"sequence"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"sequence"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
        }
        if ([dic objectForKey:@"style"]) {
            _style = [dic objectForKey:@"style"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"style"]] : @"";
        }
        if ([dic objectForKey:@"tag"]) {
            NSString *str = [dic objectForKey:@"tag"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"tag"]] : @"";
            if (str.length > 0) {
                _tag = [str componentsSeparatedByString:@","];
            }
        }
        if ([dic objectForKey:@"productEntityOne"]) {
            if ([[dic objectForKey:@"productEntityOne"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDic = [dic objectForKey:@"productEntityOne"];
                _productEntityOne = [HomeMatchProductData dataForDictionary:itemDic];
            }
        }
        if ([dic objectForKey:@"productEntityTwo"]) {
            if ([[dic objectForKey:@"productEntityTwo"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDic = [dic objectForKey:@"productEntityTwo"];
                _productEntityTwo = [HomeMatchProductData dataForDictionary:itemDic];
            }
        }
        if ([dic objectForKey:@"productEntityThree"]) {
            if ([[dic objectForKey:@"productEntityThree"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *itemDic = [dic objectForKey:@"productEntityThree"];
                _productEntityThree = [HomeMatchProductData dataForDictionary:itemDic];
            }
        }
        if ([dic objectForKey:@"productList"]) {
            _productList = [NSMutableArray array];
            if ([[dic objectForKey:@"productList"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"productList"];
                for (NSDictionary *d in arr) {
                    HomeMatchProductData *item = [HomeMatchProductData dataForDictionary:d];
                    [_productList addObject:item];
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
