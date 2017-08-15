//
//  OutFitDetail.h
//  DuoSet
//
//  Created by fanfans on 12/29/16.
//  Copyright © 2016 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OutFitDetailProduct.h"

@interface OutFitDetail : NSObject

@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *goodNum;
@property(nonatomic,strong) NSMutableArray *imgs;
@property(nonatomic,strong) NSMutableArray *lables;
@property(nonatomic,strong) NSMutableArray *products;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
