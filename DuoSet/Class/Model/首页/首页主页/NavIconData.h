//
//  NavIconData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavIconData : NSObject

@property(nonatomic,copy) NSString *code;
@property(nonatomic,assign) AppNavIconStatus navIconStatus;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *classifyId;
@property(nonatomic,copy) NSString *titleIcon;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
