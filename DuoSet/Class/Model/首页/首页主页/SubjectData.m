//
//  SubjectData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SubjectData.h"

@implementation SubjectData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = 0.0;
        if ([dic objectForKey:@"descr"]) {
            _descr = [dic objectForKey:@"descr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"descr"]] : @"";
            CGFloat hight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(48.0) textString:_descr textFont:14];
            _cellHight = hight;
        }
        if ([dic objectForKey:@"id"]) {
            _subject_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"picture"]) {
            NSString *str = [dic objectForKey:@"picture"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"picture"]] : @"";
            _picture = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"productList"]) {//
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
    _cellHight += FitHeight(410.0);
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
