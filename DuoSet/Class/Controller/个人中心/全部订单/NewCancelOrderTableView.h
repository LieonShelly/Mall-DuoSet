//
//  NewCancelOrderTableView.h
//  DuoSet
//
//  Created by fanfans on 2017/8/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^CancelOrderTableViewBtnActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^CancelOrderTableViewProductActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^CancelOrderTableViewDetailBlock)(DuojiOrderData *order);
typedef void(^TableViewDeleteBlock)(DuojiOrderData *order);

@interface NewCancelOrderTableView : UITableView

+ (NewCancelOrderTableView *)contentTableViewAndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock;

@property(nonatomic,copy) CancelOrderTableViewBtnActionBlock cellBtnAction;
@property(nonatomic,copy) CancelOrderTableViewProductActionBlock productTapAction;
@property(nonatomic,copy) CancelOrderTableViewDetailBlock cellSeletcedAction;
@property(nonatomic,copy) TableViewDeleteBlock deleteHandle;

-(void)setupInfoWithDuoSetOrderArr:(NSMutableArray *)itemArr;

@end
