//
//  SeckillHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SeckillHeaderViewBtnViewAtionBlock)(NSInteger index);

@interface SeckillHeaderView : UIView

-(void)setupInfoWithRobSessionDataArr:(NSMutableArray *)items;

-(void)setupSeletcedWithIndex:(NSInteger)index;

@property(nonatomic,copy) SeckillHeaderViewBtnViewAtionBlock btnViewHandle;


@end
