//
//  OrderSureOutOfStockView.h
//  DuoSet
//
//  Created by fanfans on 2017/6/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellOutProductData.h"

@interface OrderSureOutOfStockView : UIView

-(instancetype)initWithFrame:(CGRect)frame leftBtnTitle:(NSString *)leftTitle leftBtnBlock:(void (^)())leftBtnBlock rightBtnBlock:(void (^)())rightBtnBlock;

-(void)setupInfoWithSellOutProductDataArr:(NSMutableArray *)items;

@end
