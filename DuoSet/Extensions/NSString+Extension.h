//
//  NSString+Extension.h
//  gulu
//
//  Created by fanfans on 16/2/2.
//  Copyright © 2016年 BraveSoft. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

+(CGFloat)countTextHightLabelWidth:(CGFloat)width textString:(NSString *)string lineSpacing:(CGFloat)lineSpacing textFont:(NSInteger)font;

+(CGFloat)countTextHightLabelWidth:(CGFloat)width textString:(NSString *)string textFont:(NSInteger)font;

- (NSString*)implicitPhoneNumFormat;

+ (NSString *)randomStrWithLength:(NSInteger)length;
@end
