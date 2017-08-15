//
//  DressChoiceDataModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DressChoiceDataModel : NSObject
@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *dressid;
@property (nonatomic, copy) NSString *img;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
