//
//  HomeSixPicCell.h
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HomeSixPicCellBlock)(NSInteger);

@interface HomeSixPicCell : UITableViewCell

@property(nonatomic,copy) HomeSixPicCellBlock imgVActionHandle;

@end
