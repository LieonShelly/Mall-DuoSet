//
//  SystemMessageModel.h
//  DuoSet
//
//  Created by fanfans on 2017/2/25.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageModel : NSObject

@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *message_id;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,assign) CGFloat cellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
