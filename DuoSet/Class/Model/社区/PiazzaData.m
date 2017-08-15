//
//  PiazzaData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaData.h"

@implementation PiazzaData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _cellHight = 0.0;
        _detailCellHight = 0.0;
        _picHights = [NSMutableArray array];
        CGFloat imgsHight = 0.0;
        CGFloat detailsContentHight = 0.0;
        if ([dic objectForKey:@"avastar"]) {
            NSString *str = [dic objectForKey:@"avastar"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"avastar"]] : @"";
            _avastar = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"nickName"]) {
            _nickName = [dic objectForKey:@"nickName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"nickName"]] : @"";
        }
        if ([dic objectForKey:@"browseCount"]) {
            _browseCount = [dic objectForKey:@"browseCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"browseCount"]] : @"";
        }
        if ([dic objectForKey:@"commentCount"]) {
            _commentCount = [dic objectForKey:@"commentCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"commentCount"]] : @"";
        }
        if ([dic objectForKey:@"communityCommentResponses"]) {
            _communityCommentResponses = [NSMutableArray array];
            if ([[dic objectForKey:@"communityCommentResponses"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"communityCommentResponses"];
                for (NSDictionary *d in arr) {
                    PiazzaUserData *item = [PiazzaUserData dataForDictionary:d];
                    [_communityCommentResponses addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"communityLikeReponses"]) {
            _communityLikeReponses = [NSMutableArray array];
            if ([[dic objectForKey:@"communityLikeReponses"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"communityLikeReponses"];
                for (NSDictionary *d in arr) {
                    PiazzaUserData *item = [PiazzaUserData dataForDictionary:d];
                    [_communityLikeReponses addObject:item];
                }
            }
        }
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
            _cellHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(96.0) textString:_content textFont:12];
            detailsContentHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(56.0) textString:_content textFont:15];
        }
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
            _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd HH:mm"];
        }
        if ([dic objectForKey:@"id"]) {
            _communityId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"likeCommunity"]) {
            NSString *str = [dic objectForKey:@"likeCommunity"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeCommunity"]] : @"0";
            _likeCommunity = str.integerValue == 1;
        }
        if ([dic objectForKey:@"likeCount"]) {
            _likeCount = [dic objectForKey:@"likeCount"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"likeCount"]] : @"";
        }
        if ([dic objectForKey:@"pics"]) {
            _pics = [NSMutableArray array];
            if ([[dic objectForKey:@"pics"] isKindOfClass:[NSArray class]]) {
                NSArray *arr = [dic objectForKey:@"pics"];
                for (NSString *str in arr) {
                    NSString *imgUrl = [NSString stringWithFormat:@"%@%@",BaseImgUrl,str];
                    CGSize size = [Utils getImageSizeWithURLStr:imgUrl];
                    CGFloat scale = size.height / size.width;
                    CGFloat hight = (mainScreenWidth - FitWith(48.0)) * scale;
                    [_picHights addObject:[NSNumber numberWithFloat:hight]];
                    imgsHight += hight;
                    [_pics addObject:imgUrl];
                }
            }
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]] : @"";
        }
        if ([dic objectForKey:@"type"]) {
            _type = [dic objectForKey:@"type"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]] : @"";
        }
        if ([dic objectForKey:@"top"]) {
            NSString *str = [dic objectForKey:@"top"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"top"]] : @"0";
            _top = str.integerValue == 1;
        }
        if (_top) {
            _cellHight += FitHeight(820.0);
        }else{
            _cellHight += FitHeight(730.0);
        }
        _detailCellHight = imgsHight + detailsContentHight + FitHeight(96.0) + (_pics.count - 1 * FitHeight(20.0));
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
