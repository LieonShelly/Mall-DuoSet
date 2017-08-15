//
//  CommentHomeData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentHomeData.h"

@implementation CommentHomeData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _totalCount = @"0";
        _highGrade = @"0";
        _positiveGrade = @"0";
        _badGrade = @"0";
        _hasPic = @"0";
        if ([dic objectForKey:@"totalCount"]) {
            _totalCount = [dic objectForKey:@"totalCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalCount"]] : @"";
        }
        if ([dic objectForKey:@"highGrade"]) {
            _highGrade = [dic objectForKey:@"highGrade"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"highGrade"]] : @"";
        }
        if ([dic objectForKey:@"positiveGrade"]) {
            _positiveGrade = [dic objectForKey:@"positiveGrade"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"positiveGrade"]] : @"";
        }
        if ([dic objectForKey:@"badGrade"]) {
            _badGrade = [dic objectForKey:@"badGrade"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"badGrade"]] : @"";
        }
        if ([dic objectForKey:@"hasPic"]) {
            _hasPic = [dic objectForKey:@"hasPic"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"hasPic"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
