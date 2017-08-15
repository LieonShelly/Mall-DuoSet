//
//  SeckillProductCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobProductData.h"

typedef void(^CellButtonnActionBlock)();

@interface SeckillProductCell : UITableViewCell

@property(nonatomic,copy) CellButtonnActionBlock cellBtnActionHandle;

-(void)setupInfoWithRobProductData:(RobProductData *)item andRobSessionData:(RobSessionData *)robSession;

-(void)setupInfoRemindWithRobProductData:(RobProductData *)item;

@end
