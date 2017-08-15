//
//  ReturnAndChangeChoiceCountCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

typedef void(^CountButtonACtionBlock)(NSInteger num);

@interface ReturnAndChangeChoiceCountCell : UITableViewCell

@property(nonatomic,copy) CountButtonACtionBlock btnActionHandle;
@property(nonatomic,strong) PPNumberButton *numBtn;

@end
