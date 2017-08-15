//
//  SeckillHeaderView.h
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderBtnActionBlock)(NSInteger);

@interface SeckillHeaderView : UIView

-(void)setBtnChangeWithIndex:(NSInteger)index;

@property(nonatomic,copy)HeaderBtnActionBlock btnActionHandle;

@end
