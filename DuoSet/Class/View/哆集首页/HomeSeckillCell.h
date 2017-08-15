//
//  SeckillCell.h
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobSessionData.h"
#import "RobProductData.h"

typedef void(^SeckillSingleItemChickBlock)(NSInteger);

@interface HomeSeckillCell : UITableViewCell

@property(nonatomic,copy) SeckillSingleItemChickBlock singleItemTapHandle;

-(void)setupInfoWithSeckillArr:(NSArray *)itemArr;

-(void)setupInfoWithRobSessionData:(RobSessionData *)robSession andRobProductDataArr:(NSMutableArray *)robProductArr showCutDown:(BOOL)showCutDown;

@end
