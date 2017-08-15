//
//  OrderSureGlobalTotalPriceCell.h
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarSureData.h"

typedef void(^TaxDesBlock)();
typedef void(^ReadProtocolBlock)();
typedef void(^AgreeProtocolBlock)(UIButton *btn);

@interface OrderSureGlobalTotalPriceCell : UITableViewCell

-(void)setupInfoWithShopCarSureData:(ShopCarSureData *)item;

@property(nonatomic,copy) TaxDesBlock taxDexHandle;
@property(nonatomic,copy) ReadProtocolBlock readProtocolHandle;
@property(nonatomic,copy) AgreeProtocolBlock agreeProtocolHandle;

@end
