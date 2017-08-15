//
//  ProductNavTitleView.h
//  DuoSet
//
//  Created by fanfans on 2017/4/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ProductNavTitleViewShowSubViews,
    ProductNavTitleViewShowWebDetails
} ProductNavTitleViewShowStyle;

typedef void(^NavTitleButtonActionBlock)(NSInteger index);

@interface ProductNavTitleView : UIView

@property(nonatomic,copy) NavTitleButtonActionBlock navbuttonHandle;
-(void)setupViewProductNavTitleViewShowStyle:(ProductNavTitleViewShowStyle)style LineFrameChangeWithIndex:(NSInteger)index;

@end
