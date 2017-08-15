//
//  PiazzaUserListController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^LikeCollcationBLock)();

@interface PiazzaUserListController : BaseViewController

-(instancetype)initWithUserId:(NSString *)userId andRequestTypeStr:(NSString *)requestTypeStr;

@property(nonatomic,copy) LikeCollcationBLock likeHandle;

@end
