//
//  DuojiOrderData.m
//  DuoSet
//
//  Created by fanfans on 2017/3/4.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiOrderData.h"

@implementation DuojiOrderData

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _mainCellHight = FitHeight(310.0);
        _allTableViewCellHight = FitHeight(190.0);
        _commentCellHight = FitHeight(230.0);
        _detailsCellHight = FitHeight(250.0);
        _LogisticCellHight = FitHeight(110.0);
        if ([dic objectForKey:@"address"]) {
            _address = [dic objectForKey:@"address"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"address"]] : @"";
            _LogisticCellHight += [NSString countTextHightLabelWidth:mainScreenWidth - FitWith(60.0) textString:_address textFont:12];
        }
        if ([dic objectForKey:@"amountPrice"]) {
            NSString *str = [dic objectForKey:@"amountPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"amountPrice"]] : @"0";
            _amountPrice = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"contact"]) {
            _contact = [dic objectForKey:@"contact"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"contact"]] : @"";
        }
        if ([dic objectForKey:@"couponCount"]) {
            _couponCount = [dic objectForKey:@"couponCount"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"couponCount"]] : @"";
        }
        if ([dic objectForKey:@"createTime"]) {
            NSString *str = [dic objectForKey:@"createTime"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"createTime"]] : @"0";
            _createTime = [NSString dateStrFormTimeInterval:str andFormatStr:@"yyyy-MM-dd HH:mm"];
        }
        if ([dic objectForKey:@"id"]) {
            _orderId = [dic objectForKey:@"id"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] : @"";
        }
        if ([dic objectForKey:@"no"]) {
            _no = [dic objectForKey:@"no"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"no"]] : @"";
        }
        if ([dic objectForKey:@"orderDetailResponses"]) {
            _orderDetailResponses = [NSMutableArray array];
            if ([[dic objectForKey:@"orderDetailResponses"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *Arr = [dic objectForKey:@"orderDetailResponses"];
                for (NSDictionary *d in Arr) {
                    DuojiOrderProductData *item = [DuojiOrderProductData dataForDictionary:d];
                    [_orderDetailResponses addObject:item];
                }
                if (_orderDetailResponses.count == 1) {
                    _mainCellHight += FitHeight(150.0);
                    _detailsCellHight += FitHeight(150.0);
                    
                    _allTableViewCellHight += FitHeight(190.0);
                    _commentCellHight += FitHeight(190.0);
                }else{
                    _mainCellHight += (FitHeight(166.0) * _orderDetailResponses.count);
                    _commentCellHight += FitHeight(190.0);
                    
                    _allTableViewCellHight += (FitHeight(200.0) * _orderDetailResponses.count);
                    _detailsCellHight += (FitHeight(170.0) * _orderDetailResponses.count);
                }
            }
        }
        if ([dic objectForKey:@"orderName"]) {
            _orderName = [dic objectForKey:@"orderName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderName"]] : @"";
        }
        if ([dic objectForKey:@"phone"]) {
            _phone = [dic objectForKey:@"phone"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"phone"]] : @"";
        }
        if ([dic objectForKey:@"pointCount"]) {
            _pointCount = [dic objectForKey:@"pointCount"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"pointCount"]] : @"";
        }
        if ([dic objectForKey:@"status"]) {
            _status = [dic objectForKey:@"status"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] : @"50";
            switch (_status.integerValue) {
                case 0:
                    _orderState = OrderStatesCreate;
                    break;
                case 10:
                    _orderState = OrderStatesPaid;
                    break;
                case 15:
                    _orderState = OrderStatesBeforSendCancel;
                    break;
                case 20:
                    _orderState = OrderStatesSend;
                    break;
                case 25:
                    _orderState = OrderStatesWaitComment;
                    break;
                case 30:
                    _orderState = OrderStatesDone;
                    break;
                case 40:
                    _orderState = OrderStatesCancel;
                    break;
                case 50:
                    _orderState = OrderStatesDeleted;
                    break;
                    
                default:
                    _orderState = OrderStatesOther;
                    break;
            }
        }
        if ([dic objectForKey:@"statusName"]) {
            _statusName = [dic objectForKey:@"statusName"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"statusName"]] : @"";
        }
        if ([dic objectForKey:@"payType"]) {
            NSString *str = [dic objectForKey:@"payType"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"payType"]] : @"";
            if ([str isEqualToString:@"alipay"]) {
                _payType = @"支付宝支付";
            }
            if ([str isEqualToString:@"wechatPay"]) {
                _payType = @"微信支付";
            }
            if ([str isEqualToString:@"accountPay"]) {
                _payType = @"账户余额支付";
            }
            if ([str isEqualToString:@"officialPay"]) {
                _payType = @"微信代支付";
            }
        }
        
        if ([dic objectForKey:@"totalPrice"]) {
            NSString *str = [dic objectForKey:@"totalPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"totalPrice"]] : @"0";
            _totalPrice = [NSString stringWithFormat:@"%.2lf",str.floatValue];
        }
        if ([dic objectForKey:@"userId"]) {
            _userId = [dic objectForKey:@"userId"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"userId"]] : @"";
        }
        if ([dic objectForKey:@"taxPrice"]) {
            _taxPrice = [dic objectForKey:@"taxPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"taxPrice"]] : @"";
        }
        if ([dic objectForKey:@"isGlobal"]) {
            NSString *str = [dic objectForKey:@"isGlobal"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"isGlobal"]] : @"0";
            _isGlobal = str.integerValue == 1;
        }
        if ([dic objectForKey:@"isChange"]) {
            NSString *str = [dic objectForKey:@"isChange"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"isChange"]] : @"0";
            _isChange = str.integerValue == 1;
        }
        if ([dic objectForKey:@"carrierPrice"]) {
            _carrierPrice = [dic objectForKey:@"carrierPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"carrierPrice"]] : @"";
        }
        if ([dic objectForKey:@"productPrice"]) {
            _productPrice = [dic objectForKey:@"productPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"productPrice"]] : @"";
        }
        if ([dic objectForKey:@"subtractPrice"]) {
            _subtractPrice = [dic objectForKey:@"subtractPrice"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"subtractPrice"]] : @"";
        }
        if ([dic objectForKey:@"remainTime"]) {
            _remainTime = [dic objectForKey:@"remainTime"] != [NSNull null] ?  [NSString stringWithFormat:@"%@",[dic objectForKey:@"remainTime"]] : @"0";
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
