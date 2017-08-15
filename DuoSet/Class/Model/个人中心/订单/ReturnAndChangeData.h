//
//  ReturnAndChangeData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReturnAndChangeData : NSObject

@property(nonatomic,copy) NSString *addPrice;
@property(nonatomic,copy) NSString *count;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *orderDetailId;
@property(nonatomic,copy) NSString *no;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *propertyCollection;
@property(nonatomic,copy) NSString *propertyName;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,assign) OrderProductStates productStatus;
@property(nonatomic,assign) OrderProductCommentStates commentStatus;
@property(nonatomic,copy) NSString *statusName;
@property(nonatomic,copy) NSString *createTime;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
