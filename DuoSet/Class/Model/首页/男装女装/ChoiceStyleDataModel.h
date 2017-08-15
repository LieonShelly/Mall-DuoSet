//
//  ChoiceStyleDataModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoiceStyleDataModel : NSObject

@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, copy) NSString *styleId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
