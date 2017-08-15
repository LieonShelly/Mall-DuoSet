//
//  OrderSureViewController.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressCell.h"
#import "ShangPinCell.h"
#import "YouHuiJuanCell.h"
#import "AddressViewController.h"
#import "PayViewController.h"
#import "ShopCarSureData.h"

@interface OrderSureViewController : BaseViewController

-(instancetype)initWithOrderSuerStatus:(OrderSuerStatus)status ShopCarSureData:(ShopCarSureData *)dataItem andShopCartIdArr:(NSArray *)cartIdArr;

//单个商品直接购买需要的参数
@property(nonatomic,copy) NSString *productNumber;
@property(nonatomic,copy) NSString *propertyCollection;
@property(nonatomic,copy) NSString *count;
//是否是全球购
@property(nonatomic,assign) BOOL isGlobal;

@end
