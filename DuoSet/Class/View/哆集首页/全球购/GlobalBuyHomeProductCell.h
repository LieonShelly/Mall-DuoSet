//
//  GlobalBuyHomeProductCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductForListData.h"

typedef void(^ProductTapBlock)(NSInteger);

@interface GlobalBuyHomeProductCell : UITableViewCell

-(void)setupInfoWithProductForListDataArr:(NSArray *)items;

@property(nonatomic,copy) ProductTapBlock productTapHandle;

@end
