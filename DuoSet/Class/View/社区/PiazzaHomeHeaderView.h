//
//  PiazzaHomeHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PiazzaHeaderViewActionBlock)(NSInteger);

@interface PiazzaHomeHeaderView : UIView

@property(nonatomic,copy) PiazzaHeaderViewActionBlock tapHandle;

@end
