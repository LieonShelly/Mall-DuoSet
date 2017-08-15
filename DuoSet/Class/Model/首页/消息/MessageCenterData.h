//
//  MessageCenterData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SystemMessageModel.h"

@interface MessageCenterData : NSObject

@property(nonatomic,copy) NSString *unReadCount;
@property(nonatomic,copy) NSString *typeIcon;
@property(nonatomic,copy) NSString *typeName;
@property(nonatomic,strong) SystemMessageModel *message;
@property(nonatomic,assign) MessageType messageType;
@property(nonatomic,copy) NSString *type_id;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
