//
//  ReturnAndChangeProductCell.h
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderProductData.h"

@interface ReturnAndChangeProductCell : UITableViewCell

-(void)setupInfoWithDuojiOrderProductData:(DuojiOrderProductData *)item;

@end
