//
//  CallServiceViewController.h
//  DuoSet
//
//  Created by lieon on 2017/6/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapBlock)(void);

@interface CallServiceViewController : UIViewController

@property(nonatomic, copy) TapBlock enterAction;
@property(nonatomic, copy) TapBlock cancelAction;

-(instancetype)initWithTitle:(NSString *)alertTitle message:(NSString *)message enterTitle:(NSString *)enterTitle enterColor:(UIColor *)enterColor enterTextColor:(UIColor *)enterTextColor cancelTitle:(NSString*)cancelTitle cancelColor:(UIColor *)cancelColor cancelTextColor:(UIColor *)cancelTextColor;

- (void)configMsg: (NSString*)msg WithEnterTitle: (NSString*)enterTitle;
- (void)configMsg: (NSString*)msg WithEnterTitle: (NSString*)enterTitle CancelTitle: (NSString*)cancelTitle;


@end
