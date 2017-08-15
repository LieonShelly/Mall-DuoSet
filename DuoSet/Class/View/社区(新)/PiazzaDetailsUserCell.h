//
//  PiazzaDetailsUserCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaItemCollectAndLikeData.h"

typedef void(^AvatarTapBLock)();
typedef void(^UserCellCollectBtnBlock)(UIButton *btn);

@interface PiazzaDetailsUserCell : UITableViewCell

-(void)setupInfoWithPiazzaItemCollectAndLikeData:(PiazzaItemCollectAndLikeData *)item;

@property(nonatomic,copy) UserCellCollectBtnBlock collectHandle;
@property(nonatomic,copy) AvatarTapBLock avatarHandle;

@end
