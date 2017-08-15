//
//  PiazzaPublishController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^PubishSuccessBlock)();

@interface PiazzaPublishController : BaseViewController

-(instancetype)initWithPiazzaItemId:(NSString *)communityId;

@property(nonatomic,copy) PubishSuccessBlock uploadSuccessHandle;

@end
