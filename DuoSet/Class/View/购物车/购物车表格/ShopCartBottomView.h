//
//  ShopCartBottomView.h
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    BottomViewShowStyleAmountForMoney,
    BottomViewShowStyleOtherAciton
} ShopCartBottomViewStatus;


typedef void(^BottomPayActionBlock)();
typedef void(^BottomBtnsActionBlock)(UIButton *);

@interface ShopCartBottomView : UIView

@property(nonatomic,copy) BottomBtnsActionBlock btnActionHandle;
@property(nonatomic,copy) BottomPayActionBlock payActionHandle;
@property(nonatomic,strong) UILabel *allPriceLable;
@property(nonatomic,strong) UIButton *allSelectedBtn;

-(instancetype)initWithFrame:(CGRect)frame andShopCartBottomViewStatus:(ShopCartBottomViewStatus)status;

-(void)resetShopCartBottomViewStatus:(ShopCartBottomViewStatus)status;


@end
