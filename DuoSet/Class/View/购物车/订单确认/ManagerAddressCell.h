//
//  ManagerAddressCell.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UIButton *stateBtn;//设为默认地址按钮
@property (nonatomic, copy) void(^updateAddress)();
@property (nonatomic, assign) int addressId;
@property (nonatomic, copy) void(^deleAddress)();

@end
