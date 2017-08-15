//
//  WeekFashionSixPicCell.h
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WeekFashionSixPicCellBlock)(NSInteger);

@interface WeekFashionSixPicCell : UITableViewCell

@property(nonatomic,copy) WeekFashionSixPicCellBlock picHandle;

@end
