//
//  BrownRecordsFootView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BottomButtonAcitonBlock)(UIButton *);

@interface BrownRecordsFootView : UIView

@property(nonatomic,copy) BottomButtonAcitonBlock buttonActionHandle;
@property(nonatomic,strong) UIButton *allSelectedBtn;

@end
