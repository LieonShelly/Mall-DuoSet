//
//  Order.m
//  DuoSet
//
//  Created by fanfans on 12/28/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "DuoSetOrder.h"

@implementation DuoSetOrder

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _mainCellHight = FitHeight(290.0);
        _commentCellHight = FitHeight(170);
        if ([dic objectForKey:@"createDate"]) {
            NSString *str = [dic objectForKey:@"createDate"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"createDate"]] : @"";
            if (str.length > 0) {
                _createDate = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd"];
            }else{
                _createDate = @"";
            }
        }
        if ([dic objectForKey:@"customerId"]) {
            _customerId = [dic objectForKey:@"customerId"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"customerId"]] : @"";
        }
        if ([dic objectForKey:@"id"]) {
            _orderId = [dic objectForKey:@"id"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"items"]) {
            if ([[dic objectForKey:@"items"] isKindOfClass:[NSArray class]]) {
                _items = [NSMutableArray array];
                NSArray *itmes =[dic objectForKey:@"items"];
                for (NSDictionary *d in itmes) {
                    OrderProduct *product = [OrderProduct dataForDictionary:d];
                    [_items addObject:product];
                }
                if (_items.count == 1) {
                    _mainCellHight += FitHeight(190.0);
                    _commentCellHight += FitHeight(190.0);
                }else{
                    _mainCellHight += (FitHeight(200.0) * _items.count);
                    _commentCellHight += (FitHeight(200.0) * _items.count);
                }
            }
        }
        
        if ([dic objectForKey:@"orderNo"]) {
            _orderNo = [dic objectForKey:@"orderNo"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderNo"]] : @"";
        }
        if ([dic objectForKey:@"payWay"]) {
            NSString *payStatu = [dic objectForKey:@"payWay"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"payWay"]] : @"";
            if (payStatu.length > 0) {
                if ([payStatu isEqualToString:@"WEIXI"]) {
                    _payWay = PayWayForWeChat;
                }else if ([payStatu isEqualToString:@"ALIPAY"]){
                    _payWay = PayWayForAlipay;
                }else if ([payStatu isEqualToString:@"WALLET"]){
                    _payWay = PayWayForDuoSet;
                }else{
                    _payWay = PayWayForOther;
                }
            }else{
                _payWay = PayWayForOther;
            }
        }
        if ([dic objectForKey:@"postage"]) {
            _postage = [dic objectForKey:@"postage"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"postage"]] : @"";
        }
        if ([dic objectForKey:@"totalPrice"]) {
            _totalPrice = [dic objectForKey:@"totalPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPrice"]] : @"";
        }
        if ([dic objectForKey:@"state"]) {
            NSString *str = [dic objectForKey:@"state"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"state"]] : @"";
            if ([str isEqualToString:@"CREATE"]) {
                _state = OrderStatesCreate;
            }
            if ([str isEqualToString:@"DELETE"]) {
                _state = OrderStatesDeleted;
            }
            if ([str isEqualToString:@"CANCEL"]) {
                _state = OrderStatesCancel;
            }
            if ([str isEqualToString:@"PAID"]) {
                _state = OrderStatesPaid;
            }
            if ([str isEqualToString:@"SENT"]) {
                _state = OrderStatesSend;
            }
            if ([str isEqualToString:@"RECIVE"]) {
                _state = OrderStatesRecive;
            }
            if ([str isEqualToString:@"DISCUSSED"]) {
                _state = OrderStatesDiscussed;
            }
            if ([str isEqualToString:@"RETURN"]) {
                _state = OrderStatesReturn;
            }
            if ([str isEqualToString:@"EXCHANGE"]) {
                _state = OrderStatesExchange;
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
