//
//  HotTypeModel.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/14.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotTypeModel : NSObject

@property (nonatomic, copy) NSString *bannerImg;
@property (nonatomic, copy) NSString *hotTypeId;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
