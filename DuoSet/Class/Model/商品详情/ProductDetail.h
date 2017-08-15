//
//  ProductDetail.h
//  DuoSet
//
//  Created by fanfans on 12/27/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductStandards.h"

@interface ProductDetail : NSObject

@property(nonatomic,copy) NSString *amount;
@property(nonatomic,copy) NSString *bigImg;
@property(nonatomic,copy) NSString *code;
@property(nonatomic,copy) NSString *depotCode;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *detailsImg;
@property(nonatomic,strong) NSMutableArray *detailImgs;
@property(nonatomic,strong) NSMutableArray *detailImgsHightArr;
@property(nonatomic,assign) CGFloat detailImgsHight;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *postage;
@property(nonatomic,copy) NSString *prePrice;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *smallImg;
@property(nonatomic,copy) NSString *soldAmount;
@property(nonatomic,copy) NSString *titleImg;
@property(nonatomic,strong) NSMutableArray *standardsArr;


-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;



@end
