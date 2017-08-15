//
//  PiazzaDetailsController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PiazzaDetailsDeletedBlock)(NSString *itemId);
typedef void(^likeActionBlock)(BOOL liked);

@interface PiazzaDetailsController : BaseViewController

-(instancetype)initWithCommunityId:(NSString *)communityId;

@property(nonatomic,copy) PiazzaDetailsDeletedBlock deletedHandle;
@property(nonatomic,copy) likeActionBlock likeHandle;


@end
