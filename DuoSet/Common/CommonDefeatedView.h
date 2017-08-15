//
//  CommonDefeatedView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/31.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonDefeatedView : UIView

-(instancetype)initWithFrame:(CGRect)frame andDefeatedImageName:(NSString *)defeatedName messageName:(NSString *)message backBlockBtnName:(NSString *)btnName backBlock:(void (^)())backBlock;

@end
