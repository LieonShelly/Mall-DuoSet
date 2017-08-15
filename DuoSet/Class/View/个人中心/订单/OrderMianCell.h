//
//  OrderMianCell.h
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^OrderCellBtnActionBlock)(DuojiOrderData *order,NSInteger index);
typedef void(^CellProductViewTapBlock)(DuojiOrderData *order,NSInteger index);

@interface OrderMianCell : UITableViewCell

@property (nonatomic, copy) OrderCellBtnActionBlock btnActionHandle;
@property (nonatomic, copy) CellProductViewTapBlock productTapHandle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order;

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item;

@end
