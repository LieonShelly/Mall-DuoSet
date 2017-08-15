//
//  DSPublishToolbar.h
//  DuoSet
//
//  Created by HuangChao on 2017/5/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//  发布内容界面键盘工具条

#import <UIKit/UIKit.h>

typedef void(^DSPublishToolbarBtnActionBlock)(UIButton *btn);

@interface DSPublishToolbar : UIView

@property(nonatomic,copy) DSPublishToolbarBtnActionBlock btnActionHandle;

@end
