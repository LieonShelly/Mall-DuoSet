//
//  SuperBenefitModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/12.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperBenefitModel : NSObject

@property (nonatomic, copy) NSString *bannerImg;
@property (nonatomic, copy) NSString *themeId;
@property (nonatomic, copy) NSString *themeImg;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
