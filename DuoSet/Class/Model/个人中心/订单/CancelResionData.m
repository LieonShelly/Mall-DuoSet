//
//  CancelResionData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CancelResionData.h"

@implementation CancelResionData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _isSeletced = false;
        _cellHight = FitHeight(30.0);
        if ([dic objectForKey:@"text"]) {
            _text = [dic objectForKey:@"text"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"text"]] : @"";
            _cellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(66.0) - FitWith(24.0) textString:_text textFont:13];
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
