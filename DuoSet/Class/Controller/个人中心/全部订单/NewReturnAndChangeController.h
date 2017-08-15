//
//  NewReturnAndChangeController.h
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnOrChangedSucceedBlock)(NSString *orderNo);

@interface NewReturnAndChangeController : UIViewController

@property(nonatomic,copy) ReturnOrChangedSucceedBlock succeedHandle;
-(instancetype)initWithOrderDetailId:(NSString *)detailId;

@end
