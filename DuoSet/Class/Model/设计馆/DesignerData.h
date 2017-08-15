//
//  DesignerData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignerData : NSObject

@property(nonatomic,copy) NSString *avastar;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,assign) BOOL follow;
@property(nonatomic,copy) NSString *followCount;
@property(nonatomic,copy) NSString *designer_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong) NSMutableArray *tagList;
@property(nonatomic,copy) NSString *tag;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *typeName;

//
@property(nonatomic,copy) NSString *phone;
@property(nonatomic,copy) NSString *weixin;
@property(nonatomic,copy) NSString *qq;
@property(nonatomic,copy) NSString *backReason;
@property(nonatomic,copy) NSString *idcardFront;
@property(nonatomic,copy) NSString *idcardBack;
@property(nonatomic,copy) NSString *reason;
@property(nonatomic,assign) CGFloat backReasonCellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
