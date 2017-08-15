//
//  ProductDetail.m
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "ProductDetail.h"

@implementation ProductDetail

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"standards"]) {
            if ([[dic objectForKey:@"standards"] isKindOfClass:[NSArray class]]) {
                NSArray *standards = [dic objectForKey:@"standards"];
                _standardsArr =[NSMutableArray array];
                for (NSDictionary *d in standards) {
                    ProductStandards *s = [ProductStandards dataForDictionary:d];
                    [_standardsArr addObject:s];
                }
            }
        }
        if ([dic objectForKey:@"amount"]) {
            _amount = [dic objectForKey:@"amount"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"amount"]] : @"";
        }
        if ([dic objectForKey:@"bigImg"]) {
            NSString *str = [dic objectForKey:@"bigImg"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"bigImg"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _bigImg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
        if ([dic objectForKey:@"code"]) {
            _code = [dic objectForKey:@"code"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]] : @"";
        }
        if ([dic objectForKey:@"depotCode"]) {
            _depotCode = [dic objectForKey:@"depotCode"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"depotCode"]] : @"";
        }
        if ([dic objectForKey:@"desc"]) {
            _desc = [dic objectForKey:@"desc"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]] : @"";
        }
        if ([dic objectForKey:@"detailsImg"]) {
            NSString *str = [dic objectForKey:@"detailsImg"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"detailsImg"]] : @"";
            _detailImgs = [NSMutableArray array];
            _detailImgsHightArr = [NSMutableArray array];
            _detailImgsHight = 0.0;
            if (str.length > 0) {
                NSArray *arr = [str componentsSeparatedByString:@","];
                for (NSString *s in arr) {
                    NSString *imgStr = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    _detailsImg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
                    [_detailImgs addObject:_detailsImg];
                    CGSize size = [Utils getImageSizeWithURLStr:_detailsImg];
                    [_detailImgsHightArr addObject:[NSNumber numberWithFloat:size.height]];
                    _detailImgsHight += size.height;
//                    _imageHeight = (mainScreen_Width - FitWith(60.0))/size.width * size.height;
//                    if (_imageHeight > mainScreen_height) {
//                        _imageHeight = mainScreen_height;
//                    }
                }
            }
        }
        if ([dic objectForKey:@"id"]) {
            _productId = [dic objectForKey:@"id"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"name"]) {
            _name = [dic objectForKey:@"name"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]] : @"";
        }
        if ([dic objectForKey:@"postage"]) {
            _postage = [dic objectForKey:@"postage"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"postage"]] : @"";
        }
        if ([dic objectForKey:@"prePrice"]) {
            _prePrice = [dic objectForKey:@"prePrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"prePrice"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            _price = [dic objectForKey:@"price"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"";
        }
        if ([dic objectForKey:@"smallImg"]) {
            NSString *str = [dic objectForKey:@"smallImg"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"smallImg"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _smallImg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
        if ([dic objectForKey:@"soldAmount"]) {
            _soldAmount = [dic objectForKey:@"soldAmount"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"soldAmount"]] : @"";
        }
        if ([dic objectForKey:@"titleImg"]) {
            NSString *str = [dic objectForKey:@"titleImg"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"titleImg"]] : @"";
            NSString *imgStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            _titleImg = [NSString stringWithFormat:@"%@%@",Img_url,imgStr];
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
