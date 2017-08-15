//
//  DesignerUploadController.h
//  DuoSet
//
//  Created by fanfans on 2017/3/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"
#import "NoPassProductData.h"

typedef void(^EditSucceedBlock)();

@interface DesignerUploadController : BaseViewController

@property(nonatomic,assign) BOOL isEdit;

@property(nonatomic,copy) NSString *objId;

@property(nonatomic,copy) EditSucceedBlock editHanlde;

@property(nonatomic,strong) NoPassProductData *noPassData;

@end
