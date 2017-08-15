//
//  ThirdStepFastRegisterVC.h
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Action)();
@interface ThirdStepFastRegisterVC : UIViewController
@property(nonatomic, copy) Action registerAction;
- (void)configPhoneNum: (NSString*)phoneNum Captcha:(NSString*) captcha;
- (void)configWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info;
@end
