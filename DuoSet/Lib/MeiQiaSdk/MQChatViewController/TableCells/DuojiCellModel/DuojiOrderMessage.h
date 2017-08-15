//
//  DuojiOrderMessage.h
//  DuoSet
//
//  Created by fanfans on 2017/4/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MQBaseMessage.h"
#import "DuojiOrderData.h"

@interface DuojiOrderMessage : MQBaseMessage

@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *orderNo;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *price;

-(instancetype)initWithProductDetailsData:(DuojiOrderData *)item;

@end
