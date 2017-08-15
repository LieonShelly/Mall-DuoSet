//
//  CouponsCell.h
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponInfoData.h"

@interface CouponsCell : UITableViewCell

-(void)setupInfoWithCouponInfoData:(CouponInfoData *)item;

-(void)setupListInfoWithCouponInfoData:(CouponInfoData *)item;

@property(nonatomic,strong) UIButton *getBtn;


@end
