//
//  Order.h
//  DuoSet
//
//  Created by fanfans on 12/28/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderProduct.h"

@interface DuoSetOrder : NSObject

@property(nonatomic,copy) NSString *createDate;
@property(nonatomic,copy) NSString *customerId;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,copy) NSString *orderNo;
@property(nonatomic,assign) DuoSetPayWay payWay;
@property(nonatomic,copy) NSString *postage;
@property(nonatomic,assign) OrderStates state;
@property(nonatomic,copy) NSString *totalPrice;
@property(nonatomic,assign) CGFloat mainCellHight;
@property(nonatomic,assign) CGFloat commentCellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
