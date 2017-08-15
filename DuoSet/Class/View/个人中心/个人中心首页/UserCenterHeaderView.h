//
//  UserCenterHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterMainData.h"

typedef void(^UserCenterAvatarTapBlock)();
typedef void(^UserCenterAccountTapBlock)();
typedef void(^UserCentervipTapBlock)();

@interface UserCenterHeaderView : UIView

@property(nonatomic,copy) UserCenterAvatarTapBlock avatarHandle;
@property(nonatomic,copy) UserCenterAccountTapBlock accountHandle;
@property(nonatomic,copy) UserCentervipTapBlock vipHandle;

-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item;

-(void)resetHeaderViewInfo;

-(void)clearUserInfo;

@end
