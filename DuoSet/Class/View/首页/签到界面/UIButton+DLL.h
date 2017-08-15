//
//  UIButton+DLL.h
//  Category
//
//  Created by issuser on 16/10/19.
//  Copyright © 2016年 dll. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIButton (DLL)
///设置图片
- (void)dll_setImage:(UIImage *)image placeholderImage:(UIImage *)placeholder forState:(UIControlState)state;

///设置背景色
- (void)dll_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

///设置图片和标题居中显示
@property (nonatomic, assign) BOOL verticalImageAndTitle;
@property (nonatomic, assign) CGFloat spacing;

- (void)dll_setImage:(nullable UIImage *)image forState:(UIControlState)state;
- (void)dll_setTitle:(nullable NSString *)title forState:(UIControlState)state;
- (void)dll_verticalImageAndTitle;

@end
NS_ASSUME_NONNULL_END