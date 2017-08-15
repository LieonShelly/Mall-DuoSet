//
//  ShopCartSurebuyChoiceView.h
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopCartSurebuyChoiceViewBtnActionBlock)(NSInteger btnIndex,BOOL isGloble);

@interface ShopCartSurebuyChoiceView : UIView

@property(nonatomic,copy) ShopCartSurebuyChoiceViewBtnActionBlock chioceHandle;

-(void)setupInfoWithGlobalCount:(NSInteger)globalCount andOtherCount:(NSInteger)otherCount;

@end
