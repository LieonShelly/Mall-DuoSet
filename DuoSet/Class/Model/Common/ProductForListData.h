//
//  ProductForListData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductForListData : NSObject

@property(nonatomic,copy) NSString *pictureForCollectionCell;
@property(nonatomic,copy) NSString *picture;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *propertyCollection;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *seeCount;
@property(nonatomic,copy) NSString *count;
@property(nonatomic,copy) NSString *productSubName;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,assign) ShopCarProductSellStatus productStatus;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
