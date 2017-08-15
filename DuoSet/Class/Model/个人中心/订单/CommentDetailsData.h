//
//  CommentDetailsData.h
//  DuoSet
//
//  Created by fanfans on 2017/4/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentDetailsData : NSObject

@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *createTime;
@property(nonatomic,copy) NSString *goodCount;
@property(nonatomic,copy) NSString *grade;
@property(nonatomic,copy) NSString *comment_id;
@property(nonatomic,copy) NSString *orderDetailId;
@property(nonatomic,copy) NSString *productId;
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *repertoryId;
@property(nonatomic,copy) NSString *score;
@property(nonatomic,copy) NSString *seeCount;
@property(nonatomic,copy) NSString *speedScore;
@property(nonatomic,copy) NSString *status;
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,strong) NSMutableArray *pics;
@property(nonatomic,strong) NSMutableArray *picHightArr;
@property(nonatomic,assign) CGFloat contentHight;
@property(nonatomic,assign) CGFloat imgHight;
@property(nonatomic,assign) CGFloat cellHight;

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;


@end
