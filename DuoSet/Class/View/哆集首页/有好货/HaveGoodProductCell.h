//
//  HaveGoodProductCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductForListData.h"

typedef void(^CellBuybuttonActionBlock)();

@interface HaveGoodProductCell : UITableViewCell

@property(nonatomic,copy) CellBuybuttonActionBlock buyActionHandle;
@property(nonatomic,strong) UIButton *buyBtn;

-(void)setupInfoWithProductForListData:(ProductForListData *)item;

@end
