//
//  FindShareItem.h
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindShareItem : NSObject

@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *isDiscuss;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *productDesc;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productSmallImg;
@property (nonatomic, copy) NSString *standard;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
