//
//  NSString+Extension.m
//  gulu
//
//  Created by fanfans on 16/2/2.
//  Copyright © 2016年 BraveSoft. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(CGFloat)countTextHightLabelWidth:(CGFloat)width textString:(NSString *)string lineSpacing:(CGFloat)lineSpacing textFont:(NSInteger)font{
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
        paragraph.lineSpacing = 10;
    NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                            NSParagraphStyleAttributeName:paragraph};
    
    NSAttributedString * attribute = [[NSAttributedString alloc]
                                      initWithString:string attributes:dict];
    //一定要先确定宽度，再根据宽度和字体计算size
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    return size.height;
}

+(CGFloat)countTextHightLabelWidth:(CGFloat)width textString:(NSString *)string textFont:(NSInteger)font{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName:CUSFONT(font),
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    CGSize theSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return theSize.height;
}

- (NSString*)implicitPhoneNumFormat {
    if (self.length != 11) {
        return self;
    }
    NSString * subStr0 = [self substringWithRange:NSMakeRange(0, 3)];
    NSString * subStr1 = [self substringWithRange:NSMakeRange(self.length - 4 , 4)];
    return [NSString stringWithFormat:@"%@*****%@", subStr0, subStr1];
}


+ (NSString *)randomStrWithLength:(NSInteger)length {
    NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (int i = 0; i < length; i++) {
        [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
    }
    return randomString;
}
@end
