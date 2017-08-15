//
//  OrderListMainCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DuojiOrderData.h"

typedef void(^OrderCellBtnActionBlock)(DuojiOrderData *order,NSInteger index);
typedef void(^CellProductViewTapBlock)(DuojiOrderData *order,NSInteger index);
typedef void(^CellDeletedButtonActionBlock)(DuojiOrderData *order);

@interface OrderListMainCell : UITableViewCell

@property (nonatomic, copy) OrderCellBtnActionBlock btnActionHandle;
@property (nonatomic, copy) CellProductViewTapBlock productTapHandle;
@property (nonatomic, copy) CellDeletedButtonActionBlock cellDeletedHandle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order;

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item;

@end
