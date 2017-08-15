//
//  NavMoreActionView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavMoreActionViewActionBlock)(NSInteger index);

@interface NavMoreActionView : UIView

@property(nonatomic,copy) NavMoreActionViewActionBlock moreActionHanlde;

@end
