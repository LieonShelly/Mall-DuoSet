//
//  GetCouponsTableView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetCouponsAcitonBlock)(NSInteger);
typedef void(^CloseBtnAction)();

@interface GetCouponsTableView : UIView

-(void)setupInfoWithCouponInfoDataArr:(NSMutableArray *)items;

@property(nonatomic,copy) GetCouponsAcitonBlock getCouponsHandle;
@property(nonatomic,copy) CloseBtnAction closeHandle;

@end
