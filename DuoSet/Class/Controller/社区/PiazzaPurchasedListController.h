//
//  PiazzaPurchasedListController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"
#import "PiazzaPurchasedProduct.h"

typedef void(^PurchasedProductsActionBlock)(PiazzaPurchasedProduct *product);

@interface PiazzaPurchasedListController : BaseViewController

@property(nonatomic,copy) PurchasedProductsActionBlock seletcedHandle;

@end
