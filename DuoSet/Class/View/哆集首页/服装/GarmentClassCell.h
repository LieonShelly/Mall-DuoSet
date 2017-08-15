//
//  GarmentClassCell.h
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GarmentClassCellBlock)(NSInteger);

@interface GarmentClassCell : UITableViewCell

@property(nonatomic,copy) GarmentClassCellBlock tapHandle;

@end
