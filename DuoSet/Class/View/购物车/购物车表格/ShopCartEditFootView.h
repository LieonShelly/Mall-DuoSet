//
//  ShopCartEditFootView.h
//  DuoSet
//
//  Created by fanfans on 2017/6/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EditFootViewAllSelecteBtnActionBlock)(UIButton *btn);
typedef void(^EditFootViewAddCollectBtnActionBlock)();
typedef void(^EditFootViewDeleteBtnActionBlock)();

@interface ShopCartEditFootView : UIView

@property(nonatomic,strong) UIButton *allSelectedBtn;
@property(nonatomic,copy) EditFootViewAllSelecteBtnActionBlock editAllBtnHandle;
@property(nonatomic,copy) EditFootViewAddCollectBtnActionBlock collectBtnHandle;
@property(nonatomic,copy) EditFootViewDeleteBtnActionBlock deleteBtnHandle;

-(void)setupSeletcedShopCartDataWithCount:(NSInteger)count;

@end
