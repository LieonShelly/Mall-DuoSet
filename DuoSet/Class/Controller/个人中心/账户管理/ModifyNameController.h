//
//  ModifyNameController.h
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^NameModifyBlock)();

@interface ModifyNameController : BaseViewController

@property(nonatomic,copy) NameModifyBlock nameChangeHandle;

@end
