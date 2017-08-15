//
//  HomeDressUpStyleOneCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMainData.h"

typedef void(^DressUpSingleItemBlock)(NSInteger);

@interface HomeDressUpStyleOneCell : UITableViewCell

@property(nonatomic,copy) DressUpSingleItemBlock dressupHandle;

-(void)setupInfoWithHomeMainData:(HomeMainData *)item;

@end
