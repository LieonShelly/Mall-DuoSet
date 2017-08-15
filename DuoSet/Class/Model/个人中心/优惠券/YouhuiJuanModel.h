//
//  YouhuiJuanModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/20.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YouhuiJuanModel : NSObject

@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *createDateStr;
@property (nonatomic, copy) NSString *endDateStr;
@property (nonatomic, copy) NSString *customerId;
@property (nonatomic, copy) NSString *doorsill;
@property (nonatomic, copy) NSString *couponId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *term;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
