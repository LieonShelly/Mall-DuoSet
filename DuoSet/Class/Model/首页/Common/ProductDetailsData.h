//
//  ProductDetailsData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductPropertyData.h"
#import "ProductDetailsSeckillData.h"
#import "ProductDetailsArticle.h"
#import "RobSessionData.h"
#import "RobProductData.h"
#import "RepertorySelectedData.h"

typedef enum : NSUInteger {
    ProductDetailsDefault,
    ProductDetailsSeckilling,
    ProductDetailsSeckillWillBegin
} ProductDetailsSekillStatus;

@interface ProductDetailsData : NSObject

@property(nonatomic,assign) ProductDetailsSekillStatus seckillStatus;
@property(nonatomic,copy) NSString *buyedCount;
@property(nonatomic,copy) NSString *carryPrice;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *detail;
@property(nonatomic,strong) NSMutableArray *detailPics;
@property(nonatomic,copy) NSString *product_id;
@property(nonatomic,copy) NSString *productName;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *orderCount;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *repertory;
@property(nonatomic,strong) NSMutableArray *showPics;
@property(nonatomic,assign) ProductDetailsStatus status;
@property(nonatomic,copy) NSString *productSubName;
@property(nonatomic,copy) NSString *commentCount;
@property(nonatomic,copy) NSString *commentGood;
@property(nonatomic,strong) NSMutableArray *detailPicsHight;
@property(nonatomic,assign) CGFloat detailImgHight;
@property(nonatomic,assign) BOOL isGlobal;
@property(nonatomic,copy) NSString *tax;
@property(nonatomic,assign) BOOL isCollect;
@property(nonatomic,strong) NSMutableArray *propertyProductEntities;
@property(nonatomic,assign) CGFloat headerViewImgHight;
@property(nonatomic,strong) ProductDetailsSeckillData *robResponse;
@property(nonatomic,strong) NSMutableArray *articles;
@property(nonatomic,assign) CGFloat baseInfoCellHight;
@property(nonatomic,assign) CGFloat seckillCellHight;
@property(nonatomic,assign) CGFloat seckillWillBeginCellHight;
@property(nonatomic,strong) RobSessionData *robSessionResponse;
@property(nonatomic,strong) RobProductData *productNewRobResponse;
@property(nonatomic,strong) RepertorySelectedData *repertorySelect;
@property(nonatomic,strong) NSMutableArray *articlesGlobal;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
