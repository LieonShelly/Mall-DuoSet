//
//  DuojiProductMessage.h
//  DuoSet
//
//  Created by fanfans on 2017/4/7.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailsData.h"

@interface DuojiProductMessage : MQBaseMessage

@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productSubName;
@property(nonatomic,copy) NSString *price;

-(instancetype)initWithProductDetailsData:(ProductDetailsData *)item;


@end
