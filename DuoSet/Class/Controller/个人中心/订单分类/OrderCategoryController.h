//
//  OrderCategoryController.h
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^GoHomeBlock)();

@interface OrderCategoryController : BaseViewController

-(instancetype)initWithOrderStates:(OrderStates)state;

@property(nonatomic,copy) GoHomeBlock gohomeHandle;

@end
