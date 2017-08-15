//
//  DuojiOrderProductData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/4.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiOrderProductData.h"

@implementation DuojiOrderProductData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _mainCellHight = FitHeight(290.0);
        _commentCellHight = FitHeight(170);
        
        if ([dic objectForKey:@"addPrice"]) {
            _addPrice = [dic objectForKey:@"addPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"addPrice"]] : @"";
        }
        if ([dic objectForKey:@"count"]) {
            _count = [dic objectForKey:@"count"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"count"]] : @"";
        }
        if ([dic objectForKey:@"productId"]) {
            _productId = [dic objectForKey:@"productId"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productId"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _orderDetailId = [dic objectForKey:@"id"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"price"]) {
            NSString *str = [dic objectForKey:@"price"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]] : @"0";
//            _price = [NSString stringWithFormat:@"%.2lf",str.floatValue];
            _price = str;
        }
        if ([dic objectForKey:@"productName"]) {
            _productName = [dic objectForKey:@"productName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productName"]] : @"";
        }
        if ([dic objectForKey:@"productNumber"]) {
            _productNumber = [dic objectForKey:@"productNumber"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productNumber"]] : @"";
        }
        if ([dic objectForKey:@"propertyCollection"]) {
            _propertyCollection = [dic objectForKey:@"propertyCollection"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyCollection"]] : @"";
        }
        if ([dic objectForKey:@"propertyCount"]) {
            _propertyCount = [dic objectForKey:@"propertyCount"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyCount"]] : @"";
        }
        if ([dic objectForKey:@"propertyId"]) {
            _propertyId = [dic objectForKey:@"propertyId"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyId"]] : @"";
        }
        if ([dic objectForKey:@"propertyName"]) {
            _propertyName = [dic objectForKey:@"propertyName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"propertyName"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"";
            switch (_status.integerValue) {
                case 30:
                    _productStatus = OrderProductStatesdefault;
                    break;
                case 50:
                    _productStatus = OrderProductStatesExchangeCheking;
                    break;
                case 60:
                    _productStatus = OrderProductStatesReturnCheking;
                    break;
                case 70:
                    _productStatus = OrderProductStatesExchangeHandling;
                    break;
                case 80:
                    _productStatus = OrderProductStatesReturnHandling;
                    break;
                case 90:
                    _productStatus = OrderProductStatesExchangeRefuse;
                    break;
                case 100:
                    _productStatus = OrderProductStatesReturnRefuse;
                    break;
                case 95:
                    _productStatus = OrderProductStatesExchangeFinish;
                    break;
                case 110:
                    _productStatus = OrderProductStatesReturnFinish;
                    break;
                default:
                    _productStatus = OrderProductStatesOther;
                    break;
            }
        }//commentStatus
        if ([dic objectForKey:@"commentStatus"]) {
            NSString *str = [dic objectForKey:@"commentStatus"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"commentStatus"]] : @"";
            switch (str.integerValue) {
                case 0:
                    _commentStatus = OrderProductCommentNoComment;
                    break;
                case 1:
                    _commentStatus = OrderProductCommentCommented;
                    break;
                    
                default:
                    _commentStatus = OrderProductCommentNoComment;
                    break;
            }
        }
        if ([dic objectForKey:@"cover"]) {
            NSString *str = [dic objectForKey:@"cover"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"cover"]] : @"";
            _cover = [NSString stringWithFormat:@"%@%@!750x550",BaseImgUrl,str];
        }
        if ([dic objectForKey:@"statusName"]) {
            _statusName = [dic objectForKey:@"statusName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"statusName"]] : @"";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
