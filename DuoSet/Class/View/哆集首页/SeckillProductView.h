//
//  SeckillProductView.h
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillListData.h"
#import "RobProductData.h"

@interface SeckillProductView : UIView

-(void)setupInfoWithSeckillListData:(SeckillListData *)item;

-(void)setupInfoWithRobProductData:(RobProductData *)item;

@end
