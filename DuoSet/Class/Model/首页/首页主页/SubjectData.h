//
//  SubjectData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeMatchProductData.h"

@interface SubjectData : NSObject

@property(nonatomic,copy) NSString *descr;
@property(nonatomic,copy) NSString *subject_id;
@property(nonatomic,copy) NSString *match_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *picture;
@property(nonatomic,assign) CGFloat cellHight;
@property(nonatomic,strong) NSMutableArray *productList;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
