//
//  DesignerTagData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignerTagData : NSObject

@property(nonatomic,copy) NSString *tag_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) BOOL isSeletced;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
