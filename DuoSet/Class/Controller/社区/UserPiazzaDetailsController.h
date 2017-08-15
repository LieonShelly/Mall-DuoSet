//
//  UserPiazzaDetailsController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^UserLikeBlock)(BOOL isLike);

@interface UserPiazzaDetailsController : BaseViewController

-(instancetype)initWithUserid:(NSString *)userId;

@property (nonatomic,copy) UserLikeBlock likeHandle;

@end
