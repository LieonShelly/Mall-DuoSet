//
//  ProductDetailsArticle.m
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductDetailsArticle.h"

@implementation ProductDetailsArticle

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = FitHeight(80.0);
        _taxCellHight = FitHeight(20.0);
        if ([dic objectForKey:@"articleGroup"]) {
            _articleGroup = [dic objectForKey:@"articleGroup"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"articleGroup"]] : @"";
        }
        if ([dic objectForKey:@"icon"]) {
            NSString *str = [dic objectForKey:@"icon"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"icon"]] : @"";
            _icon = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"remark"]) {
            _remark = [dic objectForKey:@"remark"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"remark"]] : @"";
            _cellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(94.0) textString:_remark textFont:12];
            _taxCellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(94.0) textString:_remark textFont:12];
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
