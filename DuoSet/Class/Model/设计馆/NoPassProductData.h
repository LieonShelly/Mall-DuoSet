//
//  NoPassProductData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoPassProductData : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *reason;
@property(nonatomic,assign) CGFloat backReasonCellHight;
@property(nonatomic,copy) NSString *objId;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *descr;
@property(nonatomic,strong) NSMutableArray *worksPictureList;
@property(nonatomic,strong) NSMutableArray *allworksPictureList;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
