//
//  TodayBargainPriceCell.h
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TodayBargainPriceCellBlock)(NSInteger);

@interface TodayBargainPriceCell : UITableViewCell

@property(nonatomic,copy) TodayBargainPriceCellBlock cellHandle;

@end
