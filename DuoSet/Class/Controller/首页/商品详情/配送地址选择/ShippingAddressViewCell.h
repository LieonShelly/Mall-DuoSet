//
//  ShippingAddressViewCell.h
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

@interface ShippingAddressViewCell : UITableViewCell

-(void)setupInfoWithAddressModel:(AddressModel *)item;

@end
