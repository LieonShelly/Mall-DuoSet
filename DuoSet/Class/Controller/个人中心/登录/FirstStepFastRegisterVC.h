//
//  FirstStepFastRegisterVC.h
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Handler)(NSString*);

@interface FirstStepFastRegisterVC : UIViewController

@property(nonatomic, assign) BOOL isFromthirdLogin;
@property(nonatomic, copy) Handler nexBtntapAction;

-(void)configPhonum:(NSString *)num;

@end
