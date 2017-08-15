//
//  ProductDetailFootView.h
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsData.h"

typedef void(^FootViewBtnActionBlock)(UIButton *);

@interface ProductDetailFootView : UIView

@property(nonatomic,copy) FootViewBtnActionBlock btnActionHandle;
@property(nonatomic,strong) UIButton *collectBtn;

-(void)resetShopcartCountlableShowCount:(NSString *)countStr;

-(instancetype)initWithFrame:(CGRect)frame andProductDetailsData:(ProductDetailsData *)item;

-(void)setupInfoWithProductDetailsData:(ProductDetailsData *)item;

@end
