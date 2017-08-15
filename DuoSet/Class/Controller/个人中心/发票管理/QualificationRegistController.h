//
//  QualificationRegistController.h
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RegistUploadBlock)();

@interface QualificationRegistController : BaseViewController

@property(nonatomic,assign) BOOL isLikeStatus;
@property(nonatomic,copy) RegistUploadBlock uploadHandle;

@end
