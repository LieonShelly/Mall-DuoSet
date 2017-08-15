//
//  NewWaittingPayTableView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^WaittingPayTableViewBtnActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^WaittingPayTableViewProductActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^WaittingPayTableViewDetailBlock)(DuojiOrderData *order);
typedef void(^TableViewDeleteBlock)(DuojiOrderData *order);

@interface NewWaittingPayTableView : UITableView

@property(nonatomic,copy) WaittingPayTableViewBtnActionBlock cellBtnAction;
@property(nonatomic,copy) WaittingPayTableViewProductActionBlock productTapAction;
@property(nonatomic,copy) WaittingPayTableViewDetailBlock cellSeletcedAction;
@property(nonatomic,copy) TableViewDeleteBlock deleteHandle;

+ (NewWaittingPayTableView *)contentTableViewAndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock;

-(void)setupInfoWithDuoSetOrderArr:(NSMutableArray *)itemArr;

@end
