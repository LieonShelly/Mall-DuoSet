//
//  OrderProductCell.h
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarModel.h"
#import "ShopCarSureProduct.h"

@interface OrderProductCell : UITableViewCell

-(void)setUpdataInfoWithShopCarModel:(ShopCarModel *)item;
-(void)setUpdataInfoWithShopCarSureProduct:(ShopCarSureProduct *)item;

@end
