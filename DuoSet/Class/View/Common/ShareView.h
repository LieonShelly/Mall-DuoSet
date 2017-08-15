//
//  ShareView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareBtnActionBlock)(NSInteger);
typedef void(^CancelBtnActionBlock)();

@interface ShareView : UIView

@property(nonatomic,copy) ShareBtnActionBlock shareHandle;
@property(nonatomic,copy) CancelBtnActionBlock cancelHandle;

@end
