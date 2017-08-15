//
//  MustBuySmallView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MustBuyListTypeData.h"

@interface MustBuySmallView : UIView

@property(nonatomic,strong) UIView *markView;

-(void)setupInfoWithMustBuyListTypeData:(MustBuyListTypeData *)item;

@end
