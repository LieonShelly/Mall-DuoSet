//
//  NewAllOrderTableView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^AllOrderTableViewBtnActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^AllOrderTableViewProductActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^AllOrderTableViewDetailBlock)(DuojiOrderData *order);
typedef void(^TableViewDeleteBlock)(DuojiOrderData *order);

@interface NewAllOrderTableView : UITableView

@property(nonatomic,copy) AllOrderTableViewBtnActionBlock cellBtnAction;
@property(nonatomic,copy) AllOrderTableViewProductActionBlock cellProductAction;
@property(nonatomic,copy) AllOrderTableViewDetailBlock cellSeletcedAction;
@property(nonatomic,copy) TableViewDeleteBlock deleteHandle;

+ (NewAllOrderTableView *)contentTableViewAndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock;
-(void)setupInfoWithDuoSetOrderArr:(NSMutableArray *)itemArr;

@end
