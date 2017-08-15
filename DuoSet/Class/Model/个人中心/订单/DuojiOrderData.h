//
//  DuojiOrderData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/4.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DuojiOrderProductData.h"

@interface DuojiOrderData : NSObject

@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *amountPrice;
@property(nonatomic,copy) NSString *contact;
@property(nonatomic,copy) NSString *couponCount;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *orderId;
@property(nonatomic,copy) NSString *no;
@property(nonatomic,strong) NSMutableArray *orderDetailResponses;
@property(nonatomic,copy) NSString *orderName;
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *pointCount;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,assign) OrderStates orderState;
@property(nonatomic,copy) NSString *statusName;
@property(nonatomic,copy) NSString *totalPrice;
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,copy) NSString *payType;
@property(nonatomic,copy) NSString *carrierPrice;
@property(nonatomic,copy) NSString *remainTime;
@property(nonatomic,copy) NSString *taxPrice;
@property(nonatomic,copy) NSString *productPrice;
@property(nonatomic,copy) NSString *subtractPrice;
@property(nonatomic,assign) BOOL isGlobal;
@property(nonatomic,assign) BOOL isChange;//是否是退换货生成的订单

@property(nonatomic,assign) CGFloat mainCellHight;
@property(nonatomic,assign) CGFloat allTableViewCellHight;
@property(nonatomic,assign) CGFloat commentCellHight;
@property(nonatomic,assign) CGFloat detailsCellHight;
@property(nonatomic,assign) CGFloat LogisticCellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
