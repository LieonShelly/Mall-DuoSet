//
//  RegisterViewController.h
//  DuoSet
//
//  Created by fanfans on 2017/2/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^RegisterSucceed)();
typedef void(^RegisteBlock)(NSString *);

@interface RegisterViewController : BaseViewController

@property(nonatomic,copy) RegisterSucceed succeedBlock;
@property(nonatomic,copy) RegisteBlock isRegisteBlock;
@property(nonatomic,copy) NSString *phoneNum;

-(instancetype)initWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info;

@end
