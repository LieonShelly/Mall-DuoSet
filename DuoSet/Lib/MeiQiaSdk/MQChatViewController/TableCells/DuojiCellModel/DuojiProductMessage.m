//
//  DuojiProductMessage.m
//  DuoSet
//
//  Created by fanfans on 2017/4/7.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiProductMessage.h"

@implementation DuojiProductMessage

-(instancetype)initWithProductDetailsData:(ProductDetailsData *)item{
    self = [super init];
    if (self) {
        if (item.repertorySelect.picture) {
            _cover = item.repertorySelect.picture;
        }
        if (item.productName) {
            _productName = item.productName;
        }
        if (item.productNumber) {
            _productSubName = [NSString stringWithFormat:@"商品编号:%@",item.productNumber];
        }
        if (item.price) {
            _price = [NSString stringWithFormat:@"￥ %@",item.price];
        }
    }
    return self;
}

@end
