//
//  ShopCartInputToolBar.h
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopCartInputToolBarBtnACtionBlock)(NSInteger index);

@interface ShopCartInputToolBar : UIView

@property(nonatomic,copy) ShopCartInputToolBarBtnACtionBlock btnActionHandle;

@end
