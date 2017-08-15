//
//  NewDoneOrderTableView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^DoneOrderTableViewBtnActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^DoneOrderTableViewProductActionBlock)(DuojiOrderData *order,NSInteger);
typedef void(^DoneOrderTableViewDetailBlock)(DuojiOrderData *order);
typedef void(^TableViewDeleteBlock)(DuojiOrderData *order);

@interface NewDoneOrderTableView : UITableView

+ (NewDoneOrderTableView *)contentTableViewAndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock;

@property(nonatomic,copy) DoneOrderTableViewBtnActionBlock cellBtnAction;
@property(nonatomic,copy) DoneOrderTableViewProductActionBlock productTapAction;
@property(nonatomic,copy) DoneOrderTableViewDetailBlock cellSeletcedAction;
@property(nonatomic,copy) TableViewDeleteBlock deleteHandle;

-(void)setupInfoWithDuoSetOrderArr:(NSMutableArray *)itemArr;
@end
