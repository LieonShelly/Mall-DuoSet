//
//  SingleProductWebView.h
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebViewPhoneCallBlock)(NSString *str);

@interface SingleProductWebView : UIView

-(instancetype)initWithFrame:(CGRect)frame andProductNum:(NSString *)productNum;

@property(nonatomic,copy) WebViewPhoneCallBlock webCallHandle;

@end
