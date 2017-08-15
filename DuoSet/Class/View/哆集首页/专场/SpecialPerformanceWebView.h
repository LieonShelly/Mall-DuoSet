//
//  SpecialPerformanceWebView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol webHeightDelegate <NSObject>

-(void)countWebViewHeight:(CGFloat)height;

-(void)countWebViewNavTitle:(NSString *)titleStr;

-(void)tapWebViewImageProductNum:(NSString *)productNum;

@end

@interface SpecialPerformanceWebView : UIView

-(instancetype)initWithFrame:(CGRect)frame andwebUrl:(NSString *)webUrlStr;
@property (nonatomic, strong) id<webHeightDelegate>delegate;

@end
