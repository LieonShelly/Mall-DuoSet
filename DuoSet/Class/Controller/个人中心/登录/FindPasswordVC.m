//
//  FindPasswordVC.m
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FindPasswordVC.h"
#import "NSString+Extension.h"
#import "FindPasswordSecodStepVC.h"
#import "FastRegisterViewController.h"
#import "CustomAlert.h"

@interface FindPasswordVC ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *phoneNumTF;
@property(nonatomic,strong) UITextField *pwdTF;
@property(nonatomic, strong) UIImageView *userLog;
@property(nonatomic, strong) UIImageView *pwdLog;
@property(nonatomic, strong) UIView *line0;
@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIView *line2;
@property(nonatomic, strong) UIButton *forgetPwdBtn;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UILabel *descLabel;
@property(nonatomic, copy) NSString *verifiCode;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, assign) BOOL isValidPhoneNum;
@property(nonatomic, strong) UIButton *contactBtn;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) CustomAlert *alertView;

@end

@implementation FindPasswordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.phoneNumTF.text = self.phoneNum;
    self.verifiCode = [NSString randomStrWithLength:4];
    [self.forgetPwdBtn setTitle:self.verifiCode forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - UI
-(void)configUI{
    self.title = self.navTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.userLog];
    [self.view addSubview:self.phoneNumTF];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.pwdLog];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.forgetPwdBtn];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.loginBtn];
     [self.view addSubview:self.contactBtn];
    [self.view setNeedsUpdateConstraints];
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClosekeyBoard)];
    [self.view addGestureRecognizer:g];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.descLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.userLog];
        [self.descLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.userLog withOffset:-30];
        [self.descLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:104];
        [self.userLog autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
        [self.userLog autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:150];
        [self.userLog autoSetDimension:ALDimensionWidth toSize:20];
        [self.phoneNumTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userLog withOffset:20];
        [self.phoneNumTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.userLog];
        [self.phoneNumTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.line0 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userLog withOffset:12];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [self.line0 autoSetDimension:ALDimensionHeight toSize:0.5];
        [self.pwdLog autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.userLog withOffset:2];
        [self.pwdLog autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line0 withOffset:12];
        [self.pwdLog autoSetDimension:ALDimensionWidth toSize:20];
        [self.forgetPwdBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:35];
        [self.forgetPwdBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.pwdLog];
        [self.line1 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.forgetPwdBtn withOffset:-12];
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
        [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line2 withOffset:70];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.loginBtn autoSetDimension:ALDimensionHeight toSize:45];
        [self.contactBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:15];
        [self.contactBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.loginBtn];
        self.didSetupConstraints = true;
    }
    [super updateViewConstraints];
}

#pragma mark - lazy load
- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = [UIColor colorFromHex:0x808080];
        _descLabel.text = @"我们将发送验证码到您的手机";
    }
    return _descLabel;
}

- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc]init];
        _phoneNumTF.placeholder = @"请输入手机号";
        _phoneNumTF.textColor = [UIColor colorFromHex:0x333333];
        _phoneNumTF.font = CUSFONT(13);
        _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneNumTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneNumTF.tintColor = [UIColor mainColor];
        _phoneNumTF.userInteractionEnabled = !_phoneTFEnable;
    }
    return _phoneNumTF;
}
- (UITextField *)pwdTF {
    if (_pwdTF == nil) {
        _pwdTF = [[UITextField alloc]init];
        _pwdTF.secureTextEntry = NO;
        _pwdTF.placeholder = @"请输入右侧验证码";
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

- (UIButton *)forgetPwdBtn {
    if (_forgetPwdBtn == nil) {
        _forgetPwdBtn = [[UIButton alloc]init];
        [_forgetPwdBtn sizeToFit];
        _forgetPwdBtn.titleLabel.font = CUSFONT(12);
        _forgetPwdBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPwdBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_forgetPwdBtn addTarget:self action:@selector(changeVerifiCodeAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _forgetPwdBtn;
}

- (UIButton *)loginBtn {
    if (_loginBtn == nil) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateDisabled];
        _loginBtn.titleLabel.font = CUSFONT(16);
        [_loginBtn setTitle:@"下 一 步" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.enabled = false;
    }
    return _loginBtn;
}

- (UIButton *)contactBtn {
    if (_contactBtn == nil) {
        _contactBtn = [[UIButton alloc]init];
        _contactBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_contactBtn setTitle:@"联系客服" forState:UIControlStateNormal];
        [_contactBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_contactBtn addTarget:self action:@selector(contactAction) forControlEvents:UIControlEventTouchUpInside];
        [_contactBtn sizeToFit];
    }
    return _contactBtn;
}

#pragma mark - Action
- (void)nextAction {
    [self.view endEditing:true];
    NSString * verifiCode = [self.verifiCode lowercaseString];
    NSString * inputCode = [self.pwdTF.text lowercaseString];
    if (![inputCode isEqualToString:verifiCode]) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"验证码输入错误"];
        return;
    }
    [self validdatePhoneNumAndSendCapchaCode];
}

- (void)textFiledEditChange:(UITextField *)textField{
    if (textField == _phoneNumTF) {
        if (textField.text.length >= 11) {
            NSString *s = [textField.text substringToIndex:11];
            _phoneNumTF.text = s;
        }
    }
    if (textField == _pwdTF) {
        if (_pwdTF.text.length > 4) {
            NSString *s = [textField.text substringToIndex:4];
            _pwdTF.text = s;
        }
    }
//     self.isValidPhoneNum = _pwdTF.text.length > 0 && [[ValiMobile valiMobile:_phoneNumTF.text] isEqualToString:@"YES"];
    self.isValidPhoneNum = _pwdTF.text.length > 0 && _phoneNumTF.text.length == 11;
}

- (void)sendCapchaCode {
    NSDictionary *params = @{
                             @"type": @"4",
                             @"phone": self.phoneNumTF.text.length > 0 ? self.phoneNumTF.text: self.phoneNum
                             };
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sms/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
//            [[UIApplication sharedApplication].keyWindow makeToast:@"短信发送成功，请查收"];
            FindPasswordSecodStepVC * secondVC = [[FindPasswordSecodStepVC alloc]init];
            secondVC.phoneNum = self.phoneNum.length > 0 ? self.phoneNum: self.phoneNumTF.text;
            [self.navigationController pushViewController:secondVC animated:true];
        }
        
    } fail:^(NSError *error) {
        [[UIApplication sharedApplication].keyWindow makeToast:error.localizedDescription];
    }];
}

- (void)validdatePhoneNumAndSendCapchaCode{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *s = self.phoneNumTF.text.length > 0 ? self.phoneNumTF.text: self.phoneNum;
    [params setObject:s forKey:@"username"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/reg/validatePhone" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"status"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[objectDic objectForKey:@"status"]];
                    if (str.integerValue == 0) {//已注册
                        self.isValidPhoneNum = true;
                        [self showAlertWithMessage:@"该手机号码还未注册，请先注册"];
                    } else {
                        [self.phoneNumTF endEditing:true];
                        [self sendCapchaCode];
                        self.isValidPhoneNum = false;
                    }
                }
            }
        }
    } fail:^(NSError *error) {
    }];
}

- (void)showAlertWithMessage: (NSString*)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *enter = [UIAlertAction actionWithTitle:@"去注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FastRegisterViewController * registerVC = [[FastRegisterViewController alloc]init];
        [registerVC configIsFindPasswordPhoneNum:self.phoneNumTF.text];
        [self.navigationController pushViewController:registerVC animated:true];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    [alertController addAction:enter];
    [self presentViewController:alertController animated:true completion:nil];
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

- (void)changeVerifiCodeAction {
    self.verifiCode = [NSString randomStrWithLength:4];
    [self.forgetPwdBtn setTitle:self.verifiCode forState:UIControlStateNormal];
}

-(void)viewTapClosekeyBoard{
    [_phoneNumTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
}

#pragma mark - setter

- (void)setIsValidPhoneNum:(BOOL)isValidPhoneNum {
    _isValidPhoneNum = isValidPhoneNum;
    self.loginBtn.enabled = isValidPhoneNum;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

@end
