//
//  AppSpecialIconData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSpecialIconData : NSObject

@property(nonatomic,copy) NSString *item_id;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *titleIcon;
@property(nonatomic,copy) NSString *url;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
