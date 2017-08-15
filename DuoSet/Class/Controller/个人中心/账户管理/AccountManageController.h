//
//  AccountManageController.h
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^UserInfoModfyBlock)();

@interface AccountManageController : BaseViewController

@property(nonatomic,copy) UserInfoModfyBlock infoModfyHandle;

@end
