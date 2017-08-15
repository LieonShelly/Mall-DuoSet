//
//  PiazzaTypeHeaderView.h
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PiazzaTypeHeaderView : UIView

-(void)setupInfoWithType:(NSInteger)type;

@property(nonatomic,strong) UILabel *subTitle;

@end
