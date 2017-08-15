//
//  UIFont+Name.m
//  DuoSet
//
//  Created by fanfans on 2017/6/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UIFont+Name.h"

@implementation UIFont (Name)

+(UIFont *)fontWithPingFang_SC_MediumAndsize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFang_SC_Medium" size:fontSize];
}

+(UIFont *)fontWithPingFang_SC_BoldAndsize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFang-SC-Bold" size:fontSize];
}

@end
