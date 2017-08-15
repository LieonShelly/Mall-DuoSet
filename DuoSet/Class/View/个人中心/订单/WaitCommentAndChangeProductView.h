//
//  WaitCommentAndChangeProductView.h
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"
#import "DuojiOrderProductData.h"
#import "ReturnAndChangeData.h"

typedef void(^ProductViewBtnsActionBlock)(NSInteger);

@interface WaitCommentAndChangeProductView : UIView

-(void)setupInfoWithOrderProduct:(DuojiOrderProductData *)item;

-(void)setupIndoWithDuojiOrderData:(DuojiOrderData *)order andDuojiOrderProductData:(DuojiOrderProductData *)item;

-(void)setupInfoReturnAndChangeData:(ReturnAndChangeData *)item;

@property(nonatomic,copy) ProductViewBtnsActionBlock btnActionHandle;

@property(nonatomic,strong) UIButton *btn0;
@property(nonatomic,strong) UIButton *btn1;
@property(nonatomic,strong) UIButton *btn2;

@end
