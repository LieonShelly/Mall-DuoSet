//
//  InputAddressController.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NewAddressEditBlock)();

@interface InputAddressController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;

@property (weak, nonatomic) IBOutlet UITextField *addressLabel;

@property (weak, nonatomic) IBOutlet UITextField *detailAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *progressBtn;

@property (nonatomic,copy) NewAddressEditBlock addressEditHandle;

@end
