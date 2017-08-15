//
//  DesignerProductData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignerProductData : NSObject

@property(nonatomic,assign) BOOL collect;
@property(nonatomic,copy) NSString *collectCount;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *descr;
@property(nonatomic,copy) NSString *designerId;
@property(nonatomic,copy) NSString *obj_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *sellCount;
@property(nonatomic,assign) CGFloat cellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
