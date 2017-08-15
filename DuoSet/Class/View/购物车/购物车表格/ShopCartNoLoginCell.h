//
//  ShopCartNoLoginCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginActionBlock)();

@interface ShopCartNoLoginCell : UITableViewCell

@property(nonatomic,copy) LoginActionBlock loginHandle;

@end
