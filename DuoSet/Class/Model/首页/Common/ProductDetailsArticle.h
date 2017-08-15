//
//  ProductDetailsArticle.h
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailsArticle : NSObject

@property(nonatomic,copy) NSString *articleGroup;
@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *remark;
@property(nonatomic,assign) CGFloat cellHight;
@property(nonatomic,assign) CGFloat taxCellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
