//
//  AllOrderTableViewCell.h
//  DuoSet
//
//  Created by fanfans on 2017/4/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^OrderProductTapBlock)(NSInteger);

@interface AllOrderTableViewCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDuoSetOrder:(DuojiOrderData *)order;

-(void)setupInfoWithDuoSetOrder:(DuojiOrderData *)item;

@property(nonatomic,copy) OrderProductTapBlock productTapHandle;

@end
