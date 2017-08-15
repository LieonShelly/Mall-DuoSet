//
//  UserCenterItemCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterMainData.h"

typedef void(^ItemActionBlock)(NSInteger);

@interface UserCenterItemCell : UITableViewCell

@property(nonatomic,copy) ItemActionBlock itemTapHandle;

-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item;

-(void)clearUserCountData;

@end
