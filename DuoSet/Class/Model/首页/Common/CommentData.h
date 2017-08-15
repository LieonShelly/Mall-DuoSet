//
//  CommentData.h
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentData : NSObject

@property(nonatomic,copy) NSString *avastar;
@property(nonatomic,assign) BOOL isLike;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *goodCount;
@property(nonatomic,copy) NSString *grade;
@property(nonatomic,copy) NSString *comment_id;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *orderDetailId;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *score;
@property(nonatomic,copy) NSString *seeCount;
@property(nonatomic,copy) NSString *speedScore;
@property(nonatomic,copy) NSString *propertyName;
@property(nonatomic,strong) NSMutableArray *pics;
@property(nonatomic,assign) CGFloat contentHight;
@property(nonatomic,assign) CGFloat imgHight;
@property(nonatomic,assign) CGFloat cellHight;
@property(nonatomic,assign) CGFloat productCellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
