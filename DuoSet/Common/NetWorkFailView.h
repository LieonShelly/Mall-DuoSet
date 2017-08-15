//
//  NetWorkFailView.h
//  DuoSet
//
//  Created by fanfans on 2017/7/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetWorkFailView : UIView

-(instancetype)initWithFrame:(CGRect)frame andDefeatedImageName:(NSString *)defeatedName messageName:(NSString *)message backBlockBtnName:(NSString *)btnName backBlock:(void (^)())backBlock;

@end
