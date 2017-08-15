//
//  FindListModel.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/21.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "FindListModel.h"

@implementation FindListModel

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"content"]) {
            _content = [dic objectForKey:@"content"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]] : @"";
        }
        if ([dic objectForKey:@"customerHeadImg"]) {
            NSString *str = [dic objectForKey:@"customerHeadImg"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"customerHeadImg"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _customerHeadImg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
        if ([dic objectForKey:@"customerName"]) {
            _customerName = [dic objectForKey:@"customerName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"customerName"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _productShareId = [dic objectForKey:@"id"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"imgs"]) {
            NSString *str = [dic objectForKey:@"imgs"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"imgs"]] : @"";
            _imgs = [NSMutableArray array];
//            _detailImgsHightArr = [NSMutableArray array];
//            _detailImgsHight = 0.0;
            if (str.length > 0) {
                NSArray *arr = [str componentsSeparatedByString:@","];
                for (NSString *s in arr) {
                    NSString *imgStr = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSString *imgStrUrl = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
                    [_imgs addObject:imgStrUrl];
//                    CGSize size = [Utils getImageSizeWithURLStr:_detailsImg];
//                    [_detailImgsHightArr addObject:[NSNumber numberWithFloat:size.height]];
//                    _detailImgsHight += size.height;
                    
                    //                    _imageHeight = (mainScreen_Width - FitWith(60.0))/size.width * size.height;
                    //                    if (_imageHeight > mainScreen_height) {
                    //                        _imageHeight = mainScreen_height;
                    //                    }
                }
            }
        }
        if ([dic objectForKey:@"isBad"]) {
            _isBad = [dic objectForKey:@"isBad"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isBad"]] : @"0";
        }
        if ([dic objectForKey:@"isGood"]) {
            _isGood = [dic objectForKey:@"isGood"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"isGood"]] : @"0";
        }
        if ([dic objectForKey:@"productId"]) {
            _productId = [dic objectForKey:@"productId"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productPrice"]) {
            _productPrice = [dic objectForKey:@"productPrice"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[dic objectForKey:@"productPrice"]] : @"";
        }
        if ([dic objectForKey:@"productSmallImg"]) {
            NSString *str = [dic objectForKey:@"productSmallImg"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productSmallImg"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _productSmallImg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
        
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
