//
//  CommentData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentData.h"

@implementation CommentData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _contentHight = 0.0;
        _imgHight = 0.0;
        _cellHight = 0.0;
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"clickLike"]) {
            NSString *str = [dic objectForKey:@"clickLike"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"clickLike"]] : @"0";
            _isLike = str.integerValue == 1;
        }
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
            _contentHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(60.0) textString:_content textFont:12];
        }
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
            _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd"];
        }
        if ([dic objectForKey:@"goodCount"]) {
            _goodCount = [dic objectForKey:@"goodCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"goodCount"]] : @"";
        }
        if ([dic objectForKey:@"grade"]) {
            _grade = [dic objectForKey:@"grade"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"grade"]] : @"30";
        }
        if ([dic objectForKey:@"id"]) {
            _comment_id = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
        if ([dic objectForKey:@"orderDetailId"]) {
            _orderDetailId = [dic objectForKey:@"orderDetailId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderDetailId"]] : @"";
        }
        if ([dic objectForKey:@"productId"]) {
            _productId = [dic objectForKey:@"productId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"score"]) {
            _score = [dic objectForKey:@"score"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"score"]] : @"";
        }
        if ([dic objectForKey:@"seeCount"]) {
            _seeCount = [dic objectForKey:@"seeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"seeCount"]] : @"";
        }
        if ([dic objectForKey:@"speedScore"]) {
            _speedScore = [dic objectForKey:@"speedScore"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"speedScore"]] : @"";
        }
        if ([dic objectForKey:@"propertyName"]) {
            _propertyName = [dic objectForKey:@"propertyName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyName"]] : @"";
        }
        if ([dic objectForKey:@"pics"]) {
            if ([[dic objectForKey:@"pics"] isKindOfClass:[NSArray class]]) {
                _pics = [NSMutableArray array];
                NSArray *strArr = [dic objectForKey:@"pics"];
                for (NSString *str in strArr) {
                    NSString *imgStr = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                    [_pics addObject:imgStr];
                }
                _imgHight =_pics.count > 0 ?  FitHeight(220.0) : 0.0;
            }
        }
        _cellHight = _contentHight + _imgHight + FitHeight(260.0);
        _productCellHight = _contentHight + _imgHight + FitHeight(130.0);
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
