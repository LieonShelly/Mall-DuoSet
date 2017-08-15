//
//  SeckillBasicCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillListData.h"

@interface SeckillBasicCell : UITableViewCell

-(void)setupInfoWithSeckillListData:(SeckillListData *)item;

@end
