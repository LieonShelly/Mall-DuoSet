//
//  CouponHeaderView.h
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CouponHeaderViewTapBlock)(NSInteger);
@interface CouponHeaderView : UIView

@property(nonatomic,strong) UIButton *unUseBtn;
@property(nonatomic,strong) UIButton *expireEBtn;
@property(nonatomic,copy) CouponHeaderViewTapBlock headerBtnActionHandle;

-(void)setBtnChangeWithIndex:(NSInteger)index;

@end
