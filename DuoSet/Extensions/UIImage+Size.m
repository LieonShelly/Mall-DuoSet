//
//  UIImage+Size.m
//  BossApp
//
//  Created by fanfans on 9/7/16.
//  Copyright © 2016 ZDJY. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)

+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
