//
//  OrderInvoice.m
//  DuoSet
//
//  Created by fanfans on 2017/4/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderInvoice.h"

@implementation OrderInvoice

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _invoiceHight = FitHeight(140.0);
        if ([dic objectForKey:@"type"]) {
            _type = [dic objectForKey:@"type"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"type"]] : @"";
        }
        if ([dic objectForKey:@"orderNo"]) {
            _orderNo = [dic objectForKey:@"orderNo"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderNo"]] : @"";
        }
        if ([dic objectForKey:@"title"]) {
            _title = [dic objectForKey:@"title"] != [NSNull null] ?  [NSString stringWithFormat:@"发票抬头:%@",[dic objectForKey:@"title"]] : @"";
            _invoiceHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(60.0) textString:_title textFont:11];
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
        }
        if ([dic objectForKey:@"createTime"]) {
            _createTime = [dic objectForKey:@"createTime"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"";
        }
        if ([dic objectForKey:@"invoiceCode"]) {
            _invoiceCode = [dic objectForKey:@"invoiceCode"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"invoiceCode"]] : @"";
        }
        if ([dic objectForKey:@"invoiceNumber"]) {
            _invoiceNumber = [dic objectForKey:@"invoiceNumber"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"invoiceNumber"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}


@end
