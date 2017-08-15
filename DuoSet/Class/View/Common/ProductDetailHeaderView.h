//
//  ProductDetailHeaderView.h
//  DuoSet
//
//  Created by mac on 2017/1/20.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailsData.h"

typedef void(^DetailImgChickBlock)(NSInteger);

@interface ProductDetailHeaderView : UIView

@property(nonatomic,copy) DetailImgChickBlock imgTapHandle;

-(instancetype)initWithFrame:(CGRect)frame AndProductDetailStyle:(ProductDetailStyle)status;

-(void)setupinfoWithImgArr:(NSArray *)imgArr;
-(void)setupinfoWithProductDetailsData:(ProductDetailsData *)item;

@end
