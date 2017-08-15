//
//  NewWaittingReceiveTableView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^WaittingReceiveTableViewBtnActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^WaittingReceiveTableViewProductActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^WaittingReceiveTableViewDetailBlock)(DuojiOrderData *order);
typedef void(^TableViewDeleteBlock)(DuojiOrderData *order);

@interface NewWaittingReceiveTableView : UITableView

+ (NewWaittingReceiveTableView *)contentTableViewAndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock;

@property(nonatomic,copy) WaittingReceiveTableViewBtnActionBlock cellBtnAction;
@property(nonatomic,copy) WaittingReceiveTableViewProductActionBlock productTapAction;
@property(nonatomic,copy) WaittingReceiveTableViewDetailBlock cellSeletcedAction;
@property(nonatomic,copy) TableViewDeleteBlock deleteHandle;

-(void)setupInfoWithDuoSetOrderArr:(NSMutableArray *)itemArr;

@end
