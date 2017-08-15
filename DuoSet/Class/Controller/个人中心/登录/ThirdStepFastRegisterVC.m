//
//  ThirdStepFastRegisterVC.m
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ThirdStepFastRegisterVC.h"
#import "CustomAlert.h"

@interface ThirdStepFastRegisterVC ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *pwdTF;
@property(nonatomic, strong) UIImageView *pwdLog;
@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, assign) BOOL isValidNum;
@property(nonatomic, strong) UILabel *descLabel;
@property(nonatomic, strong) UILabel *descPwdLabel;
@property(nonatomic, strong) UIButton *contactBtn;
@property(nonatomic, copy) NSString * phoneNum;
@property(nonatomic, copy) NSString *capchCode;
@property(nonatomic,assign)ThirdpartyLoginType loginType;
@property(nonatomic,copy) NSString *accessToken;
@property(nonatomic,copy) NSString *openId;
@property(nonatomic,copy) NSString *unionId;
@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,assign) BOOL isthirdParty;

@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) CustomAlert *alertView;

@end

@implementation ThirdStepFastRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pwdLog];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.contactBtn];
    [self.view addSubview:self.descPwdLabel];
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - layout
- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.descLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.descLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:104];
        [self.pwdLog autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.descLabel];
        [self.pwdLog autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.descLabel withOffset:25];
        [self.pwdLog autoSetDimension:ALDimensionWidth toSize:20];
        [self.pwdTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.pwdLog withOffset:20];
        [self.pwdTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:60];
        [self.pwdTF autoSetDimension:ALDimensionHeight toSize:35];
        [self.pwdTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.pwdLog];
        [self.line1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.line1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [self.line1 autoSetDimension:ALDimensionHeight toSize:0.1];
        [self.line1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pwdLog withOffset:12];
        [self.descPwdLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line1 withOffset:10];
        [self.descPwdLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.descPwdLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line1 withOffset:70];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.loginBtn autoSetDimension:ALDimensionHeight toSize:45];
        [self.contactBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.contactBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:20];
        self.didSetupConstraints = true;
    }
    [super updateViewConstraints];
}


#pragma mark - lazy load
- (UIButton *)contactBtn {
    if (_contactBtn == nil) {
        _contactBtn = [[UIButton alloc]init];
        _contactBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_contactBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [_contactBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_contactBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
        [_contactBtn sizeToFit];
    }
    return _contactBtn;
}

- (UITextField *)pwdTF {
    if (_pwdTF == nil) {
        _pwdTF = [[UITextField alloc]init];
        _pwdTF.secureTextEntry = YES;
        _pwdTF.placeholder = @"请输入6-20位字符";
        _pwdTF.textColor = [UIColor colorFromHex:0x333333];
        _pwdTF.font = CUSFONT(13);
        _pwdTF.tintColor = [UIColor mainColor];
        _pwdTF.returnKeyType = UIReturnKeyDone;
        _pwdTF.delegate = self;
        [_pwdTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTF;
}

- (UIImageView *)pwdLog {
    if (_pwdLog == nil) {
        _pwdLog = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_center_pwd"]];
        _pwdLog.contentMode = UIViewContentModeCenter;
    }
    return _pwdLog;
}

- (UIView *)line1 {
    if (_line1 == nil) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    }
    return _line1;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateDisabled];
        _loginBtn.titleLabel.font = CUSFONT(16);
        [_loginBtn setTitle:@"完 成" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginHandleAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.enabled = false;
    }
    return _loginBtn;
}

- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = [UIColor colorFromHex:0x808080];
        _descLabel.text = @"请设置登录密码";
    }
    return _descLabel;
}

- (UILabel *)descPwdLabel {
    if (_descPwdLabel == nil) {
        _descPwdLabel = [[UILabel alloc]init];
        _descPwdLabel.font = [UIFont systemFontOfSize:11];
        _descPwdLabel.textColor = [UIColor colorFromHex:0x808080];
        _descPwdLabel.numberOfLines = 0;
        _descPwdLabel.text = @"密码由6-20位字母组成、数字组成，不能有特殊符号，字母需区分大小写";
    }
    return _descPwdLabel;
}

#pragma mark - action
-(void)textFiledEditChange:(UITextField *)textField{
    if (textField == _pwdTF) {
        if (textField.text.length > 20) {
            NSString *s = [textField.text substringToIndex:20];
            _pwdTF.text = s;
        }
    }
    self.loginBtn.enabled = textField.text.length >= 6 &&  textField.text.length <= 20;
}

-(void)sendVerifyCodeWithBtn:(UIButton *)btn{
    NSDictionary *params = @{
                             @"type": @"1",
                             @"phone": self.phoneNum
                             };
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sms/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            btn.userInteractionEnabled = true;
//            [[UIApplication sharedApplication].keyWindow makeToast:@"短信发送成功，请查收"];
            [btn startWithTime:120 title:@"获取验证码" countDownTitle:@"S后重发" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
            [btn sizeToFit];
        }
        if ([responseDic objectForKey:@"errorMsg"]) {
            NSString *msg = [NSString stringWithFormat:@"%@", [responseDic objectForKey:@"errorMsg"]];
            [[UIApplication sharedApplication].keyWindow makeToast:msg];
        }
        
    } fail:^(NSError *error) {
        btn.userInteractionEnabled = true;
        [[UIApplication sharedApplication].keyWindow makeToast:error.localizedDescription];
    }];
}

- (void)progressLeftSignInButton{
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

-(void)viewTapClosekeyBoard{
    [self.view endEditing:true];
}

- (void)loginHandleAction {
    [self.pwdTF endEditing:true];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:self.phoneNum forKey:@"username"];
        [params setObject:self.capchCode forKey:@"code"];
        [params setObject:[Utils md5:self.pwdTF.text] forKey:@"password"];
        NSString *urlStr = @"user/reg";
        if (_isthirdParty) {
            [params setObject:_accessToken forKey:@"accessToken"];
            [params setObject:_openId forKey:@"openId"];
            if (_loginType == ThirdpartyLoginWithWechat) {
                [params setObject:_unionId forKey:@"unionId"];
            }
            [params setObject:_info forKey:@"info"];
            if (_loginType == ThirdpartyLoginWithQQ) {
                urlStr = @"user/fastCreate/qq";
            }
            if (_loginType == ThirdpartyLoginWithWechat) {
                urlStr = @"user/fastCreate/wechat";
            }
            if (_loginType == ThirdpartyLoginWithSina) {
                urlStr = @"user/fastCreate/weibo";
            }
        }
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic =[responseDic objectForKey:@"object"];
                    UserInfo *info = [[UserInfo alloc]init];
                    if ([objDic objectForKey:@"refreshToken"]) {
                        info.refreshToken = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"refreshToken"]];
                    }
                    if ([objDic objectForKey:@"token"]) {
                        info.token = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"token"]];
                    }
                    if ([objDic objectForKey:@"expiresIn"]) {
                        info.expiresIn = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"expiresIn"]];
                    }
                    if ([objDic objectForKey:@"info"] && [[objDic objectForKey:@"info"] isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *infoDic = [objDic objectForKey:@"info"];
                        if ([infoDic objectForKey:@"avastar"]) {
                            info.avatar = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"avastar"]];
                        }
                        if ([infoDic objectForKey:@"id"]) {
                            info.userId = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"id"]];
                        }
                        if ([infoDic objectForKey:@"nickName"]) {
                            info.name = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"nickName"]];
                        }
                        if ([infoDic objectForKey:@"phone"]) {
                            info.phone = [NSString stringWithFormat:@"%@",[infoDic objectForKey:@"phone"]];
                        }
                        
                    }
                    [Utils setUserInfo:info];
                    [UMengStatisticsUtils profileSignInWithPUID:info.userId];
                    if (self.registerAction) {
                        self.registerAction();
                    }
                }
            } else {
                 [MQToast showToast:@"注册失败" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            }
        } fail:^(NSError *error) {
            //
        }];
    });
   
}

- (void)contactAction {
    [self showAlertView:true];
}

#pragma mark - showAlertView
-(void)showAlertView:(BOOL)show{
    if (show) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.markView];
        [self.markView addSubview:self.alertView];
        self.markView.alpha = 0.f;
        self.alertView.alpha = 0.f;
        self.alertView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        [UIView animateWithDuration:0.25f animations:^{
            self.markView.alpha = 1;
            self.alertView.alpha = 1;
            self.alertView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            //
        }];
    }else{
        [UIView animateWithDuration:0.25f animations:^{
            self.markView.alpha = 0.f;
            self.alertView.alpha = 0.f;
            self.alertView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        } completion:^(BOOL finished) {
            [self.alertView removeFromSuperview];
            self.alertView = nil;
            [self.markView removeFromSuperview];
            self.markView = nil;
        }];
    }
}

-(CustomAlert *)alertView{
    if (_alertView == nil) {
        CGFloat width = self.view.bounds.size.width - 30 * 2;
        CGFloat height = 135;
        _alertView = [[CustomAlert alloc]initWithFrame:CGRectMake(0, 0, width, height) title:@"致电人工客服" message:@"400-189-0090" leftTitle:@"拨打" leftColor:[UIColor mainColor] leftTextColor:[UIColor whiteColor] rightTitle:@"取消" rightColor:[UIColor whiteColor] rightTextColor:[UIColor colorFromHex:0x222222]];
        _alertView.alertActionHandle = ^(NSInteger index) {
            if (index == 0) {
                [self showAlertView:false];
                NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-189-0090"];
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                }
            }
            if (index == 1) {
                [self showAlertView:false];
            }
        };
        _alertView.center = _markView.center;
    }
    return _alertView;
}

-(UIView *)markView{
    if (_markView == nil) {
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return _markView;
}

- (void)configPhoneNum: (NSString*)num {
    self.phoneNum = num;
//    self.descLabel.text = [NSString stringWithFormat:@"手机验证码已发送至%@", [num implicitPhoneNumFormat]];
}

- (void)configPhoneNum: (NSString*)phoneNum Captcha:(NSString*) captcha {
    [self.pwdTF becomeFirstResponder];
    self.phoneNum = phoneNum;
    self.capchCode = captcha;
    self.descLabel.text = [NSString stringWithFormat:@"手机验证码已发送至%@", [phoneNum implicitPhoneNumFormat]];
    [self.pwdTF becomeFirstResponder];
}

- (void)configWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info {
    _isthirdParty = true;
    _loginType = loginType;
    _accessToken = accessToken;
    _openId = openId;
    _unionId = unionId;
    _info = info;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
@end
