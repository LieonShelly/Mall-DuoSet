//
//  NoPassProductData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NoPassProductData.h"

@implementation NoPassProductData
-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"reason"]) {
            _reason = [dic objectForKey:@"reason"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"reason"]] : @"";
            _backReasonCellHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(48.0) textString:_reason textFont:14] + FitHeight(30.0);
        }
        if ([dic objectForKey:@"id"]) {
            _objId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"descr"]) {
            _descr = [dic objectForKey:@"descr"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"descr"]] : @"";
        }
        if ([dic objectForKey:@"worksPictureList"]) {
            _worksPictureList = [NSMutableArray array];
            _allworksPictureList = [NSMutableArray array];
            if ([[dic objectForKey:@"worksPictureList"] isKindOfClass:[NSArray class]]) {
                NSArray *picList = [dic objectForKey:@"worksPictureList"];
                for (NSDictionary *d in picList) {
                    if ([d objectForKey:@"picture"]) {
                        NSString *str = [NSString stringWithFormat:@"%@",[d objectForKey:@"picture"]];
                        [_worksPictureList addObject:str];
                        NSString *allStr = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                        [_allworksPictureList addObject:allStr];
                    }
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
