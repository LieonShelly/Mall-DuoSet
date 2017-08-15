//
//  MustBuyHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MustBuyHomeData.h"

typedef void(^BigViewTapAcitonBlock)(NSInteger);
typedef void(^SmallViewTapAcitonBlock)(NSInteger);

@interface MustBuyHeaderView : UIView

-(void)setupInfoWithMustBuyHomeData:(MustBuyHomeData *)item;

@property(nonatomic,copy) BigViewTapAcitonBlock bigViewHandle;
@property(nonatomic,copy) SmallViewTapAcitonBlock smallViewHandle;

@end
