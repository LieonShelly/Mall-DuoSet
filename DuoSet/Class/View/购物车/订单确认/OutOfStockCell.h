//
//  OutOfStockCell.h
//  DuoSet
//
//  Created by fanfans on 2017/6/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellOutProductData.h"

@interface OutOfStockCell : UITableViewCell

-(void)setupInfoWithSellOutProductData:(SellOutProductData *)item;

@end
