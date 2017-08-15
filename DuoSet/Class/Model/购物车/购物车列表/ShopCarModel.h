//
//  ShopCarModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/21.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarModel : NSObject

@property (nonatomic,copy) NSString *carryPrice;
@property (nonatomic,copy) NSString *cartId;
@property (nonatomic,assign) BOOL cartSelect;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *cover;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *detail;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *productSubName;
@property (nonatomic,copy) NSString *propertyCollection;
@property (nonatomic,copy) NSString *propertyName;
@property (nonatomic,copy) NSString *repertoryCount;
@property (nonatomic,copy) NSString *repertoryId;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *productNumber;
@property (nonatomic,assign) BOOL isGlobal;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,assign) BOOL canSelect;
@property (nonatomic,copy) NSString *words;
@property (nonatomic,assign) ShopCarProductSellStatus productStatus;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
