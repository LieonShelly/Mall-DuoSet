//
//  AllOrderViewController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^GoHomeBlock)();

@interface AllOrderViewController : BaseViewController

@property(nonatomic,copy) GoHomeBlock gohomeHandle;

@end
