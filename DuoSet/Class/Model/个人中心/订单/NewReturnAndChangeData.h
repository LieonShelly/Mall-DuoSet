//
//  NewReturnAndChangeData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@interface NewReturnAndChangeData : NSObject

@property(nonatomic,strong) AddressModel *address;
@property(nonatomic,strong) NSMutableArray *articles;
@property(nonatomic,strong) NSMutableArray *articleCellHightArr;
@property(nonatomic,assign) BOOL isChange;
@property(nonatomic,assign) BOOL isReturn;
@property(nonatomic,copy)   NSString *count;
@property(nonatomic,copy)   NSString *cover;
@property(nonatomic,copy)   NSString *finalPrice;
@property(nonatomic,copy)   NSString *no;
@property(nonatomic,copy)   NSString *productName;
@property(nonatomic,copy)   NSString *propertyName;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,copy)   NSString *phone;


-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
