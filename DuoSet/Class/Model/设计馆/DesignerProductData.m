//
//  DesignerProductData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerProductData.h"

@implementation DesignerProductData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = FitHeight(570.0);
        if ([dic objectForKey:@"collect"]) {
            NSString *str = [dic objectForKey:@"collect"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"collect"]] : @"0";
            _collect = str.integerValue == 1;
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"collectCount"]) {
            _collectCount = [dic objectForKey:@"collectCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"collectCount"]] : @"";
        }
        if ([dic objectForKey:@"createTime"]) {
            _createTime = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
        }
        if ([dic objectForKey:@"descr"]) {
            _descr = [dic objectForKey:@"descr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"descr"]] : @"";
            CGFloat destrHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(48.0) textString:_descr textFont:12];
            if (destrHight > 60) {
                destrHight = 60;
            }
            _cellHight += destrHight;
        }
        if ([dic objectForKey:@"designerId"]) {
            _designerId = [dic objectForKey:@"designerId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"designerId"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _obj_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"sellCount"]) {
            _sellCount = [dic objectForKey:@"sellCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"sellCount"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
