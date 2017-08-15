//
//  FindListModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/21.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindListModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *customerHeadImg;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *productShareId;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, copy) NSString *isBad;
@property (nonatomic, copy) NSString *isGood;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productPrice;
@property (nonatomic, copy) NSString *productSmallImg;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
