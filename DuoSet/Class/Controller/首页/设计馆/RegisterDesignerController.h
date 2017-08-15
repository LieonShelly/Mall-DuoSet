//
//  RegisterDesignerController.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RegisterUploadSucceedBlock)();

@interface RegisterDesignerController : BaseViewController

@property(nonatomic,assign) BOOL isEdit;

@property(nonatomic,copy) RegisterUploadSucceedBlock registerHandle;

@end
