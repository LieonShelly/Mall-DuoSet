//
//  SecondStepFastRegisterVC.h
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(NSString*, NSString*);

@interface SecondStepFastRegisterVC : UIViewController
@property(nonatomic, copy) Block nextAction;
- (void)configPhoneNum: (NSString*)num;
@end
