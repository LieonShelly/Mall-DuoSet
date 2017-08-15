//
//  FastLoginViewController.m
//  DuoSet
//
//  Created by lieon on 2017/6/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FastLoginViewController.h"
#import "FastRegisterViewController.h"

@interface FastLoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *phoneNumTF;
@property(nonatomic,strong) UITextField *pwdTF;
@property(nonatomic, strong) UIImageView *userLog;
@property(nonatomic, strong) UIImageView *pwdLog;
@property(nonatomic, strong) UIView *line0;
@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIView *line2;
@property(nonatomic, strong) UIButton *getVerifiedCodeBtn;
@property(nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, assign) BOOL isValidPhoneNum;
@property(nonatomic, strong) UILabel *descLabel;
@property(nonatomic, assign) BOOL isNeedRegister;
@property(nonatomic, strong) TransitionAnimator *animator;

@end

@implementation FastLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.phoneNum.length > 0) {
        self.phoneNumTF.text = self.phoneNum;
        _isValidPhoneNum = true;
    }
    self.getVerifiedCodeBtn.enabled = self.phoneNum.length > 0;
}
#pragma mark - UI

- (void)setupUI{
    self.title = @"手机快速登录";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userLog];
    [self.view addSubview:self.phoneNumTF];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.pwdLog];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.getVerifiedCodeBtn];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.descLabel];
    [self.view setNeedsUpdateConstraints];
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClosekeyBoard)];
    [self.view addGestureRecognizer:g];
}

#pragma mark - layout

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.userLog autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
        [self.userLog autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:124];
        [self.userLog autoSetDimension:ALDimensionWidth toSize:20];
        [self.phoneNumTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userLog withOffset:20];
        [self.phoneNumTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.userLog];
        [self.phoneNumTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:120];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.line0 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userLog withOffset:12];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [self.line0 autoSetDimension:ALDimensionHeight toSize:0.5];
        [self.pwdLog autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.userLog withOffset:3];
        [self.pwdLog autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line0 withOffset:12];
        [self.pwdLog autoSetDimension:ALDimensionWidth toSize:20];
        [self.getVerifiedCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
        [self.getVerifiedCodeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.pwdLog];
        [self.line1 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.getVerifiedCodeBtn withOffset:-12];
        [self.line1 autoSetDimension:ALDimensionWidth toSize:1];
        [self.line1 autoSetDimension:ALDimensionHeight toSize:20];
        [self.line1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.pwdLog];
        [self.pwdTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.phoneNumTF];
        [self.pwdTF autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.phoneNumTF];
        [self.pwdTF autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line0 withOffset:12];
        [self.line2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pwdLog withOffset:12];
        [self.line2 autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.line0 withOffset:0];
        [self.line2 autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.line0 withOffset:0];
        [self.line2 autoSetDimension:ALDimensionHeight toSize:0.5];
        [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line2 withOffset:50];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.loginBtn autoSetDimension:ALDimensionHeight toSize:45];
        [self.descLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:26];
        [self.descLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        self.didSetupConstraints = true;
    }
    [super updateViewConstraints];
}

#pragma mark - lazy load

- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc]init];
        _phoneNumTF.placeholder = @"请输入手机号";
        _phoneNumTF.textColor = [UIColor colorFromHex:0x333333];
        _phoneNumTF.font = CUSFONT(13);
        _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneNumTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneNumTF.tintColor = [UIColor mainColor];
    }
    return _phoneNumTF;
}

- (UITextField *)pwdTF {
    if (_pwdTF == nil) {
        _pwdTF = [[UITextField alloc]init];
        _pwdTF.secureTextEntry = NO;
        _pwdTF.placeholder = @"短信验证码";
        _pwdTF.textColor = [UIColor colorFromHex:0x333333];
        _pwdTF.font = CUSFONT(13);
        _pwdTF.tintColor = [UIColor mainColor];
        _pwdTF.returnKeyType = UIReturnKeyDone;
        _pwdTF.delegate = self;
        [_pwdTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _pwdTF;
}

- (UIImageView *)userLog {
    if (_userLog == nil) {
        _userLog = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_phone_num"]];
        _userLog.contentMode = UIViewContentModeCenter;
    }
    return _userLog;
}

- (UIImageView *)pwdLog {
    if (_pwdLog == nil) {
        _pwdLog = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_center_captch"]];
        _pwdLog.contentMode = UIViewContentModeCenter;
    }
    return _pwdLog;
}

- (UIView *)line0 {
    if (_line0 == nil) {
        _line0 = [[UIView alloc]init];
        _line0.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    }
    return _line0;
}

- (UIView *)line1 {
    if (_line1 == nil) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    }
    return _line1;
}

- (UIView *)line2 {
    if (_line2 == nil) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    }
    return _line2;
}

- (UIButton *)getVerifiedCodeBtn {
    if (_getVerifiedCodeBtn == nil) {
        _getVerifiedCodeBtn = [[UIButton alloc]init];
        [_getVerifiedCodeBtn sizeToFit];
        _getVerifiedCodeBtn.titleLabel.font = CUSFONT(12);
        _getVerifiedCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_getVerifiedCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerifiedCodeBtn setTitleColor:[UIColor grayColor] forState: UIControlStateDisabled];
         [_getVerifiedCodeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_getVerifiedCodeBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
        _getVerifiedCodeBtn.enabled = false;
    }
    return _getVerifiedCodeBtn;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateDisabled];
        _loginBtn.titleLabel.font = CUSFONT(16);
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.enabled = false;
    }
    return _loginBtn;
}

- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:11];
        _descLabel.textColor = [UIColor colorFromHex:0x808080];
        _descLabel.text = @"若您输入的手机号未注册，将会进入注册流程";
    }
    return _descLabel;
}

- (TransitionAnimator *)animator {
    if (_animator == nil) {
        _animator = [[TransitionAnimator alloc]init];
        CGFloat x = 30;
        CGFloat height = 135;
        CGFloat y = self.view.bounds.size.height * 0.5 - height * 0.5;
        CGFloat width = self.view.bounds.size.width - 30 * 2;
        _animator.presentFrame = CGRectMake(x, y, width, height);
    }
    return _animator;
}

#pragma mark - action

- (void)showAlertWithMessage: (NSString*)msg {
    CallServiceViewController * destVC = [[ CallServiceViewController alloc]init];
    [destVC configMsg:msg WithEnterTitle:@"发送"];
    destVC.enterAction = ^{
        self.isNeedRegister = true;
        /// 未注册时发送验证码
        NSDictionary *params = @{
                                 @"type": @"1",
                                 @"phone": self.phoneNumTF.text
                                 };
        [self sendVerifyCodeWithParam:params];
    };
    destVC.transitioningDelegate = self.animator;
    destVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:destVC animated:true completion:nil];
    
}

- (void)sendCode {
    /// 先验证是否已经注册
    [self validdateNum:self.phoneNumTF.text];
}


-(void)sendVerifyCodeWithParam: (NSDictionary*) params{
    self.getVerifiedCodeBtn.userInteractionEnabled = false;
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sms/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
             self.getVerifiedCodeBtn.userInteractionEnabled = true;
//            [[UIApplication sharedApplication].keyWindow makeToast:@"短信发送成功，请查收"];
            [ self.getVerifiedCodeBtn startWithTime:120 title:@"    " countDownTitle:@"S后重发" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
            [ self.getVerifiedCodeBtn sizeToFit];
        }
    } fail:^(NSError *error) {
         self.getVerifiedCodeBtn.userInteractionEnabled = true;
        //
    }];
}

- (void)progressLeftSignInButton{
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

-(void)viewTapClosekeyBoard{
    [self.view endEditing:true];
}

- (void)loginBtnAction {
    [self.view endEditing:true];
    if (self.isNeedRegister) {
        /// 未注册时，获取了验证码，进行校验验证码
        [self validdateCodeWithType:@"1"];
    } else {
        [self login];
    }
}

- (void)validdateCodeWithType:(NSString*)type {
    [self.pwdTF endEditing:true];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.phoneNumTF.text forKey:@"phone"];
    [params setObject:self.pwdTF.text forKey:@"code"];
    [params setObject:type forKey:@"type"];
    NSString *urlStr = @"user/check/captcha";
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            FastRegisterViewController * registerVC = [[FastRegisterViewController alloc]init];
            [registerVC configIsFastLoginPhoneNum:_phoneNumTF.text AndCapchaCode:_pwdTF.text];
            registerVC.registerSuccecss = ^(NSString * phoneNum) {
                [Utils getUserInfo];
                __weak typeof(self) weakSelf = self;
                if (weakSelf.fastLoginSuccess) {
                    weakSelf.fastLoginSuccess();
                }
            };
            [self.navigationController pushViewController:registerVC animated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}
- (void)login {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_phoneNumTF.text forKey:@"username"];
    [params setObject:_pwdTF.text forKey:@"code"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/login/captcha" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [self.view makeToast:@"登录成功"];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *jsonDic = [responseDic objectForKey:@"object"];
                UserInfo *userInfo = [[UserInfo alloc]init];
                if ([jsonDic objectForKey:@"refreshToken"]) {
                    userInfo.refreshToken = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"refreshToken"]];
                }
                if ([jsonDic objectForKey:@"token"]) {
                    userInfo.token = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"token"]];
                }
                userInfo.phone = _phoneNumTF.text;
                if ([jsonDic objectForKey:@"info"] && [[jsonDic objectForKey:@"info"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *infoDic = [jsonDic objectForKey:@"info"];
                    UserInfo *info = [UserInfo dataForDic:infoDic];
                    userInfo.avatar = info.avatar;
                    userInfo.userId = info.userId;
                    userInfo.name = info.name;
                }
                if ([jsonDic objectForKey:@"expiresIn"]) {
                    userInfo.expiresIn = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"expiresIn"]];
                }
                [Utils setUserInfo:userInfo];
                [UMengStatisticsUtils profileSignInWithPUID:userInfo.userId];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
                [self dismissViewControllerAnimated:true completion:nil];
                if (self.fastLoginSuccess) {
                    self.fastLoginSuccess();
                }
            }
        }
    } fail:^(NSError *error) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"网络状况不佳" success:^{
            
        }];
        //
    }];
}
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

-(void)textFiledEditChange:(UITextField *)textField{
    if (textField == _phoneNumTF) {
        if (textField.text.length >= 11) {
            NSString *s = [textField.text substringToIndex:11];
            _phoneNumTF.text = s;
            if ([[_phoneNumTF.text substringToIndex:1] isEqualToString:@"1"]) {
                 self.isValidPhoneNum = true;
            }
        } else {
            self.isValidPhoneNum = false;
        }
    }
    if (textField == _pwdTF) {
        if (textField.text.length > 4) {
            NSString *s = [textField.text substringToIndex:4];
            _pwdTF.text = s;
        }
    }
   self.loginBtn.enabled = self.isValidPhoneNum && self.pwdTF.text.length == 4;
}

- (void)validdateNum: (NSString*)num {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:num forKey:@"username"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/reg/validatePhone" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"status"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[objectDic objectForKey:@"status"]];
                    if (str.integerValue == 0) {//
                        [self.phoneNumTF endEditing:true];
                        [self showAlertWithMessage:@"该手机号码还未注册,是否发送验证码进行注册？"];
                    } else { // 已注册, 发送 登录验证码
                        NSDictionary *params = @{
                                                 @"type": @"2",
                                                 @"phone": self.phoneNumTF.text
                                                 };
                        [self sendVerifyCodeWithParam:params];
                        self.isNeedRegister = false;
                        self.isValidPhoneNum = true;
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark -- setter

- (void)setIsValidPhoneNum:(BOOL)isValidPhoneNum {
    _isValidPhoneNum = isValidPhoneNum;
    self.getVerifiedCodeBtn.enabled = isValidPhoneNum;
    if (!isValidPhoneNum) {
        self.getVerifiedCodeBtn.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setIsNeedRegister:(BOOL)isNeedRegister {
    _isNeedRegister = isNeedRegister;
    self.loginBtn.enabled = true;
    if (self.isNeedRegister) {
        [self.loginBtn setTitle:@"下 一 步" forState:UIControlStateNormal];
    }
}
@end
