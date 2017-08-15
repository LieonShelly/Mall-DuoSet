//
//  OrderInvoice.h
//  DuoSet
//
//  Created by fanfans on 2017/4/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInvoice : NSObject

@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *orderNo;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *invoiceCode;
@property(nonatomic,copy) NSString *invoiceNumber;
@property(nonatomic,assign) CGFloat invoiceHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
