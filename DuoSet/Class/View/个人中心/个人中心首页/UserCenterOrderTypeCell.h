//
//  UserCenterOrderTypeCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterMainData.h"

typedef void(^OrderTypeChoiceBlock)(NSInteger);

@interface UserCenterOrderTypeCell : UITableViewCell

@property(nonatomic,copy) OrderTypeChoiceBlock choiceHanlde;

-(void)setupInfoWithUserCenterMainData:(UserCenterMainData *)item;

-(void)clearCount;

@end
