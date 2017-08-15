//
//  SeckillListTableView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobSessionData.h"
#import "RobProductData.h"

typedef void(^TableViewCellSeletcedBlock)(NSIndexPath *indexPath);
typedef void(^CellBtnActionBlock)(NSInteger index);
typedef void(^CutDownEndActionBlock)();
typedef void(^TableViewHeaderViewBannerBlock)(NSInteger index);


@interface SeckillListTableView : UITableView

+ (SeckillListTableView *)contentTableViewWithFrame:(CGRect)frame AndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock;

@property(nonatomic,copy) TableViewCellSeletcedBlock cellSeletcedHandle;
@property(nonatomic,copy) CellBtnActionBlock btnAction;
@property(nonatomic,copy) CutDownEndActionBlock cutdownEndHandle;
@property(nonatomic,copy) TableViewHeaderViewBannerBlock bannerTapHandle;

-(void)setupInfoWithTopBannerArr:(NSMutableArray *)topBannerArr;

-(void)setupInfoWithRobProductDataArr:(NSMutableArray *)items;

-(void)setupInfoWithRobSessionData:(RobSessionData *)robSession;

@end
