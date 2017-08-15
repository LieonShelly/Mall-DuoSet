//
//  UIButton+DLL.m
//  Category
//
//  Created by issuser on 16/10/19.
//  Copyright © 2016年 dll. All rights reserved.
//

#import "UIButton+DLL.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@implementation UIButton (DLL)
- (void)dll_setImage:(UIImage *)image placeholderImage:(UIImage *)placeholder forState:(UIControlState)state {
    if (image) {
        [self setImage:image forState:state];
    } else {
        [self setImage:placeholder forState:state];
    }
}

- (void)dll_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *backImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self setBackgroundImage:backImage forState:state];
}

static char verticalIamgeAndTitleKey;
static char spacingKey;

- (void)setVerticalImageAndTitle:(BOOL)verticalImageAndTitle {
    objc_setAssociatedObject(self, &verticalIamgeAndTitleKey, @(verticalImageAndTitle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)verticalImageAndTitle {
    return [objc_getAssociatedObject(self,&verticalIamgeAndTitleKey) boolValue];
}

- (void)setSpacing:(CGFloat)spacing {
    objc_setAssociatedObject(self, &spacingKey, @(spacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)spacing {
    return [objc_getAssociatedObject(self, &spacingKey) floatValue];
}

- (void)dll_setTitle:(nullable NSString *)title forState:(UIControlState)state {
    [self setTitle:title forState:state];
    
    if (self.verticalImageAndTitle) {
        [self dll_verticalImageAndTitle];
    }
}

- (void)dll_setImage:(nullable UIImage *)image forState:(UIControlState)state {
    [self setImage:image forState:state];
    
    if (self.verticalImageAndTitle) {
        [self dll_verticalImageAndTitle];
    }
}

- (void)dll_verticalImageAndTitle {
    
    NSDictionary * attributes = @{NSFontAttributeName:self.titleLabel.font};
    
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:self.bounds.size
                                                          options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                       attributes:attributes
                                                          context:nil].size;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, titleSize.height + self.spacing, -titleSize.width)];
    
    CGSize imageSize = self.imageView.image.size;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageSize.height + self.spacing, -imageSize.width, 0, 0)];
}

@end
NS_ASSUME_NONNULL_END
