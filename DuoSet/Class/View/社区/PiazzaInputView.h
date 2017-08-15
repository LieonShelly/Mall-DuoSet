//
//  PiazzaInputView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnActionIndexBlock)(NSInteger);

@interface PiazzaInputView : UIView

@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UITextView *inputTexeView;

@property(nonatomic,copy) BtnActionIndexBlock btnActionHandle;

@end
