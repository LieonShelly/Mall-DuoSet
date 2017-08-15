//
//  NewProductDetailsHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailImgChickBlock)(NSInteger index);

@interface NewProductDetailsHeaderView : UIView

-(void)setupinfoWithProductDetailsData:(ProductDetailsData *)item;

-(void)setupinfoWithImgArr:(NSArray *)imgArr;

@property(nonatomic,copy) DetailImgChickBlock imgTapHandle;

@end
