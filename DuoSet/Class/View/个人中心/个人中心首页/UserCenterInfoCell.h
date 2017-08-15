//
//  UserCenterInfoCell.h
//  DuoSet
//
//  Created by lieon on 2017/6/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterMainData.h"

typedef void(^UserCenterAvatarTapBlock)();
typedef void(^UserCenterAccountTapBlock)();
typedef void(^UserCentervipTapBlock)();
typedef void(^ItemActionBlock)(NSInteger);

@interface UserCenterInfoCell : UITableViewCell
-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item;
@property(nonatomic,copy) UserCenterAvatarTapBlock avatarHandle;
@property(nonatomic,copy) UserCenterAccountTapBlock accountHandle;
@property(nonatomic,copy) UserCentervipTapBlock vipHandle;
@property(nonatomic,copy) ItemActionBlock itemTapHandle;

-(void)clearUserInfo;
-(void)clearUserCountData;
@end
