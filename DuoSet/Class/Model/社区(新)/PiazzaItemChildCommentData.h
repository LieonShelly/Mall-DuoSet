//
//  PiazzaItemChildCommentData.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PiazzaItemChildCommentData : NSObject

@property(nonatomic,copy)   NSString *avastar;
@property(nonatomic,copy)   NSString *communityId;
@property(nonatomic,copy)   NSString *content;
@property(nonatomic,copy)   NSString *createTime;
@property(nonatomic,copy)   NSString *objId;
@property(nonatomic,assign) BOOL isChildReply;
@property(nonatomic,copy)   NSString *likeCount;
@property(nonatomic,assign) BOOL liked;
@property(nonatomic,copy)   NSString *nickName;
@property(nonatomic,copy)   NSString *userId;
@property(nonatomic,copy)   NSString *pid;
@property(nonatomic,copy)   NSString *relatedUserId;
@property(nonatomic,copy)   NSString *relatedUserNickName;

@property(nonatomic,assign) CGFloat mainChildHight;//帖子详情页展示在住评论下方的灰色区域的高度
@property(nonatomic,copy)   NSString *mainChildContent;//帖子详情页展示在住评论下方的灰色区域的内容
@property(nonatomic,copy)   NSString *commentListContent;//评论列表也显示的内容 有直接显示的，也有回复某人的 例如：回复：@xxxx 内容
@property(nonatomic,assign) CGFloat cellHight;//评论列表 子评论的 cell高度

-(instancetype)initWithDic:(NSDictionary *)dic;
+(instancetype)dataForDictionary:(NSDictionary *)dic;

@end
