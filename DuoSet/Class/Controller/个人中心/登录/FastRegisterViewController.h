//
//  FastRegisterViewController.h
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RegisteBlock)(NSString *);

@interface FastRegisterViewController : UIViewController

@property(nonatomic, assign) BOOL isFromthirdLogin;
@property(nonatomic, copy) RegisteBlock registerSuccecss;
- (void)configIsFastLoginPhoneNum: (NSString*)num AndCapchaCode: (NSString*)code;
- (void)configIsFindPasswordPhoneNum: (NSString*)num;
- (void)configWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info;

@end
