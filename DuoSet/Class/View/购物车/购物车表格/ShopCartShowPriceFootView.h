//
//  ShopCartShowPriceFootView.h
//  DuoSet
//
//  Created by fanfans on 2017/6/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartSelectInfo.h"

typedef void(^AllSelecteBtnActionBlock)(UIButton *btn);
typedef void(^GotoPayBlock)();

@interface ShopCartShowPriceFootView : UIView

@property(nonatomic,strong) UIButton *allSelectedBtn;
@property(nonatomic,strong) UIButton *gotoPayBtn;
@property(nonatomic,copy) AllSelecteBtnActionBlock priceAllHandle;
@property(nonatomic,copy) GotoPayBlock gotoPayHandle;

-(void)setupInfoWithShopCartSelectInfo:(ShopCartSelectInfo *)item;

@end
