//
//  CustomAlert.h
//  DuoSet
//
//  Created by fanfans on 2017/6/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertButtonActionBlock)(NSInteger index);

@interface CustomAlert : UIView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)alertTitle message:(NSString *)message leftTitle:(NSString *)leftTitle leftColor:(UIColor *)leftColor leftTextColor:(UIColor *)leftTextColor rightTitle:(NSString*)rightTitle rightColor:(UIColor *)rightColor rightTextColor:(UIColor *)rightTextColor;

@property(nonatomic,copy) AlertButtonActionBlock alertActionHandle;

@end
