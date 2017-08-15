//
//  PiazzaUserCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaFansUserInfo.h"

typedef void(^CellBtnActionBlock)(UIButton *btn);

@interface PiazzaUserCell : UITableViewCell

-(void)setupInfoWithPiazzaFansUserInfo:(PiazzaFansUserInfo *)item;

@property(nonatomic,strong) UIButton *rightBtn;

@property(nonatomic,copy) CellBtnActionBlock btnActionHandle;

@end
