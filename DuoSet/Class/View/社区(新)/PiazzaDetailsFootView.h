//
//  PiazzaDetailsFootView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiazzaItemCollectAndLikeData.h"

typedef void(^PiazzaDetailsFootViewBtnActionBlock)(UIButton *btn);

@interface PiazzaDetailsFootView : UIView

@property(nonatomic,copy) PiazzaDetailsFootViewBtnActionBlock btnActionHandle;

-(void)setupInfoWithPiazzaItemCollectAndLikeData:(PiazzaItemCollectAndLikeData *)item;

@end
