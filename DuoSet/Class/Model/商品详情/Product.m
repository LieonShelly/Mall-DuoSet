//
//  Product.m
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        if ([dic objectForKey:@"activity"]) {
            if ([[dic objectForKey:@"activity"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *d = [dic objectForKey:@"activity"];
                _activity = [ProductActivity dataForDictionary:d];
            }
        }
        if ([dic objectForKey:@"productDetail"]) {
            if ([[dic objectForKey:@"productDetail"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *d = [dic objectForKey:@"productDetail"];
                _productDetail = [ProductDetail dataForDictionary:d];
            }
        }
    }
    return self;
}

+(instancetype)dataForDictionary:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

@end
