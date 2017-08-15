//
//  CommentDetailsData.m
//  DuoSet
//
//  Created by fanfans on 2017/4/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentDetailsData.h"

@implementation CommentDetailsData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _contentHight = 0.0;
        _imgHight = 0.0;
        _cellHight = 0.0;
        if ([dic objectForKey:@"comment"] && [[dic objectForKey:@"comment"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *commentDic = [dic objectForKey:@"comment"];
            if ([commentDic objectForKey:@"content"]) {
                _content = [commentDic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"content"]] : @"";
                _contentHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(60.0) textString:_content textFont:12];
            }
            if ([commentDic objectForKey:@"createTime"]) {
                NSString *str = [commentDic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"createTime"]] : @"";
                _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd HH:mm:ss"];
            }
            if ([commentDic objectForKey:@"goodCount"]) {
                _goodCount = [commentDic objectForKey:@"goodCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"goodCount"]] : @"";
            }
            if ([commentDic objectForKey:@"grade"]) {
                _grade = [commentDic objectForKey:@"grade"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"grade"]] : @"30";
            }
            if ([commentDic objectForKey:@"id"]) {
                _comment_id = [commentDic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"id"]] : @"";
            }
            if ([commentDic objectForKey:@"orderDetailId"]) {
                _orderDetailId = [commentDic objectForKey:@"orderDetailId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"orderDetailId"]] : @"";
            }
            if ([commentDic objectForKey:@"productId"]) {
                _productId = [commentDic objectForKey:@"productId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"productId"]] : @"";
            }
            if ([commentDic objectForKey:@"productNumber"]) {
                _productNumber = [commentDic objectForKey:@"productNumber"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"productNumber"]] : @"";
            }
            if ([commentDic objectForKey:@"repertoryId"]) {
                _repertoryId = [commentDic objectForKey:@"repertoryId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"repertoryId"]] : @"";
            }
            if ([commentDic objectForKey:@"score"]) {
                _score = [commentDic objectForKey:@"score"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"score"]] : @"";
            }
            if ([commentDic objectForKey:@"seeCount"]) {
                _seeCount = [commentDic objectForKey:@"seeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"seeCount"]] : @"";
            }
            if ([commentDic objectForKey:@"speedScore"]) {
                _speedScore = [commentDic objectForKey:@"speedScore"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"speedScore"]] : @"";
            }
            if ([commentDic objectForKey:@"status"]) {
                _status = [commentDic objectForKey:@"status"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"status"]] : @"";
            }
            if ([commentDic objectForKey:@"userId"]) {
                _userId = [dic objectForKey:@"userId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[commentDic objectForKey:@"userId"]] : @"";
            }
        }
        if ([dic objectForKey:@"commentPictureList"]) {
            _pics = [NSMutableArray array];
            _picHightArr = [NSMutableArray array];
            if ([[dic objectForKey:@"commentPictureList"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"commentPictureList"];
                for (NSDictionary *d in arr) {
                    if ([d objectForKey:@"picture"]) {
                        NSString *str = [NSString stringWithFormat:@"%@",[d objectForKey:@"picture"]];
                        NSString *pic = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                        [_pics addObject:pic];
                    }
                }
            }
        }
        _cellHight = _contentHight + FitHeight(200.0);
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
