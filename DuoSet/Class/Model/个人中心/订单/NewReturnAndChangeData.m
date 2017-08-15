//
//  NewReturnAndChangeData.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NewReturnAndChangeData.h"

@implementation NewReturnAndChangeData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"address"]) {
            if ([[dic objectForKey:@"address"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *addressDic = [dic objectForKey:@"address"];
                _address = [AddressModel dataForDictionary:addressDic];
            }
        }
        if ([dic objectForKey:@"articles"]) {
            if ([[dic objectForKey:@"articles"] isKindOfClass:[NSArray class]]) {
                NSArray *articlesArr = [dic objectForKey:@"articles"];
                _articles = [NSMutableArray array];
                _articleCellHightArr = [NSMutableArray array];
                for (NSDictionary *d in articlesArr) {
                    NSString *str = [NSString stringWithFormat:@"%@",[d objectForKey:@"remark"]];
                    [_articles addObject:str];
                    CGFloat cellHight = [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(48.0) textString:str textFont:13];
                    [_articleCellHightArr addObject:[NSNumber numberWithFloat:cellHight]];
                }
            }
        }
        if ([dic objectForKey:@"isChange"]) {
            NSString *str = [dic objectForKey:@"isChange"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"isChange"]] : @"0";
            _isChange = str.integerValue == 1;
        }
        if ([dic objectForKey:@"isReturn"]) {
            NSString *str = [dic objectForKey:@"isReturn"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"isReturn"]] : @"0";
            _isReturn = str.integerValue == 1;
        }
        if ([dic objectForKey:@"user"]) {
            if ([[dic objectForKey:@"user"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *d = [dic objectForKey:@"user"];
                _nickName = [NSString stringWithFormat:@"%@",[d objectForKey:@"nickName"]];
                _phone = [NSString stringWithFormat:@"%@",[d objectForKey:@"phone"]];
            }
        }
        if ([dic objectForKey:@"orderDetail"]) {
            if ([[dic objectForKey:@"orderDetail"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *d = [dic objectForKey:@"orderDetail"];
                _count = [NSString stringWithFormat:@"%@",[d objectForKey:@"count"]];
                _finalPrice = [NSString stringWithFormat:@"%@",[d objectForKey:@"finalPrice"]];
                _propertyName = [NSString stringWithFormat:@"%@",[d objectForKey:@"propertyName"]];
                _productName = [NSString stringWithFormat:@"%@",[d objectForKey:@"productName"]];
                _no = [NSString stringWithFormat:@"%@",[d objectForKey:@"no"]];
                _cover = [NSString stringWithFormat:@"%@%@",BaseImgUrl,[d objectForKey:@"cover"]];
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
