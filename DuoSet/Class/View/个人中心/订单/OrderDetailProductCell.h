//
//  OrderDetailProductCell.h
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^ChatWithServerBlock)();


typedef void(^ProductViewTapBlock)(NSInteger index);

@interface OrderDetailProductCell : UITableViewCell

@property(nonatomic,copy) ChatWithServerBlock chatHandle;
@property(nonatomic,copy) ProductViewTapBlock productTapHandle;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order;
-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item;

@end
