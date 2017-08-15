//
//  OrderDetailGlobalAmountCell.h
//  DuoSet
//
//  Created by fanfans on 2017/6/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuojiOrderData.h"

@interface OrderDetailGlobalAmountCell : UITableViewCell

@property (nonatomic,strong) UILabel *productPrice;
@property (nonatomic,strong) UILabel *postAmountLable;
@property (nonatomic,strong) UILabel *taxLable;
@property (nonatomic,strong) UILabel *cutLable;
@property (nonatomic,strong) UILabel *realPayAmountLable;
@property (nonatomic,strong) UILabel *createTimeLable;
@property (nonatomic,strong) UILabel *realPayTipsLable;

-(void)setupDuojiOrderData:(DuojiOrderData *)item;

@end
