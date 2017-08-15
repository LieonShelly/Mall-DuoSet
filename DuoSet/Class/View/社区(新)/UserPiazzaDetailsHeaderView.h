//
//  UserPiazzaDetailsHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPiazzaInfoData.h"

typedef void(^UserPiazzaDetailsHeaderViewBtnActionBlock)(NSInteger index);

@interface UserPiazzaDetailsHeaderView : UIView

@property(nonatomic,copy) UserPiazzaDetailsHeaderViewBtnActionBlock headerBtnActionHandle;

-(void)setupInfoWithUserPiazzaInfoData:(UserPiazzaInfoData *)item;

@end
