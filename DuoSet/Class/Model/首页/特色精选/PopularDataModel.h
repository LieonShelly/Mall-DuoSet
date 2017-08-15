//
//  PopularDataModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopularDataModel : NSObject
@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSMutableArray *labels;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
