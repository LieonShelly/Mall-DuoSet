//
//  ChangeAddressController.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/21.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeAddressController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIView *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextField;
@property (nonatomic, assign) int addressID;

@end
