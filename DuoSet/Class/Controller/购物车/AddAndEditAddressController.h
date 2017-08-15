//
//  AddAndEditAddressController.h
//  DuoSet
//
//  Created by fanfans on 2017/2/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressModel.h"


typedef enum : NSUInteger {
    AddressAdd,
    AddressEdit
} AddressEditStatus;

typedef void(^AddressChangeBlock)();

@interface AddAndEditAddressController : BaseViewController

-(instancetype)initWithAddressEditStatus:(AddressEditStatus)status;

@property(nonatomic,copy) AddressChangeBlock changeHandle;
@property(nonatomic,strong) AddressModel *addressItem;

@end
