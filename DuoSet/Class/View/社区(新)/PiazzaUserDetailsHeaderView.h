//
//  PiazzaUserDetailsHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserPiazzaInfoData.h"

@interface PiazzaUserDetailsHeaderView : UICollectionReusableView

typedef void(^UserPiazzaDetailsHeaderViewBtnActionBlock)(NSInteger index);

@property(nonatomic,copy) UserPiazzaDetailsHeaderViewBtnActionBlock headerBtnActionHandle;

-(void)setupInfoWithUserPiazzaInfoData:(UserPiazzaInfoData *)item;

@end
