//
//  OrderDetailBottomView.h
//  DuoSet
//
//  Created by mac on 2017/1/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

typedef void(^BottomBtnsActionBlock)(UIButton *);
typedef void(^BottomCutDownTimeEndBlock)();

@interface OrderDetailBottomView : UIView

@property(nonatomic,strong) UILabel *cutDownTimeLable;
@property(nonatomic,copy) BottomBtnsActionBlock btnActionHandle;
@property(nonatomic,copy) BottomCutDownTimeEndBlock cutdownEndHandle;

-(void)setupInfoWithDuojiOrderData:(DuojiOrderData *)item;

-(void)relessTimer;

@end
