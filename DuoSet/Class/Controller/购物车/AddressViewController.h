//
//  AddressViewController.h
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerAddressCell.h"
#import "AddressModel.h"

typedef void(^AddressSeletcedBlock)(AddressModel *);

@interface AddressViewController : UIViewController

@property(nonatomic,assign) BOOL isChoice;

@property(nonatomic,copy) AddressSeletcedBlock seletcedHandle;

@end
