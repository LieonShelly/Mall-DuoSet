//
//  HomeDressUpCell.h
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DressUpSingleItemBlock)(NSInteger);

@interface HomeDressUpCell : UITableViewCell

@property(nonatomic,copy) DressUpSingleItemBlock dressupHandle;

@end
