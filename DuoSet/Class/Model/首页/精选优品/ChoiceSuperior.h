//
//  ChoiceSuperior.h
//  DuoSet
//
//  Created by fanfans on 12/30/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//  精选优品

#import <Foundation/Foundation.h>
#import "ChoiceSuperiorProduct.h"

@interface ChoiceSuperior : NSObject

@property(nonatomic,strong) NSMutableArray *coverImgs;
@property(nonatomic,assign) CGFloat coverImgsHight;
@property(nonatomic,strong) NSMutableArray *coverImgsHightArr;
@property(nonatomic,copy) NSString *img;
@property(nonatomic,copy) NSString *itemId;
@property(nonatomic,strong) NSMutableArray *products;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
