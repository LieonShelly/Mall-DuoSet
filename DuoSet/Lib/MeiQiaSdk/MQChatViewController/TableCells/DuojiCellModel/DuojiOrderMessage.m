//
//  DuojiOrderMessage.m
//  DuoSet
//
//  Created by fanfans on 2017/4/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiOrderMessage.h"
#import "DuojiOrderProductData.h"

@implementation DuojiOrderMessage

-(instancetype)initWithProductDetailsData:(DuojiOrderData *)item{
    self = [super init];
    if (self) {
        _orderNo = item.no;
        _price = item.totalPrice != nil ? item.totalPrice :item.amountPrice;
        if (item.orderDetailResponses.count > 0) {
            DuojiOrderProductData *data = item.orderDetailResponses[0];
            _cover = data.cover;
            _productName = data.productName;
        }
    }
    return self;
}

@end
