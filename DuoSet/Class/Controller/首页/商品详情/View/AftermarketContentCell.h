//
//  AftermarketContentCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsData.h"

@interface AftermarketContentCell : UITableViewCell

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item;

@end
