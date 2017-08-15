//
//  SecondStepFastRegisterVC.m
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SecondStepFastRegisterVC.h"
#import "CustomAlert.h"

@interface SecondStepFastRegisterVC ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *pwdTF;
@property(nonatomic, strong) UIImageView *pwdLog;
@property(nonatomic, strong) UIView *line0;
@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIButton *getVerifiedCodeBtn;
@property(nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, assign) BOOL isValidNum;
@property(nonatomic, strong) UILabel *descLabel;
@property(nonatomic, strong) UIButton *contactBtn;
@property(nonatomic, copy) NSString * phoneNum;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) CustomAlert *alertView;

@end

@implementation SecondStepFastRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.pwdLog];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.getVerifiedCodeBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.contactBtn];
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
        [self.getVerifiedCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [self.getVerifiedCodeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.pwdLog];
        [self.getVerifiedCodeBtn autoSetDimension:ALDimensionWidth toSize:80];
        [self.line0 autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.getVerifiedCodeBtn withOffset:0];
        [self.line0 autoSetDimension:ALDimensionWidth toSize:1];
        [self.line0 autoSetDimension:ALDimensionHeight toSize:20];
        [self.line0 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.pwdLog withOffset:5];
        [self.pwdTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.pwdLog withOffset:20];
        [self.pwdTF autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.line0];
        [self.pwdTF autoSetDimension:ALDimensionHeight toSize:35];
        [self.pwdTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.pwdLog];
        [self.line1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.line1 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [self.line1 autoSetDimension:ALDimensionHeight toSize:0.1];
        [self.line1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.pwdLog withOffset:12];
        [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line1 withOffset:35];
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
        _pwdTF.placeholder = @"请输入短信验证码";
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

- (UIButton *)getVerifiedCodeBtn {
    if (_getVerifiedCodeBtn == nil) {
        _getVerifiedCodeBtn = [[UIButton alloc]init];
        [_getVerifiedCodeBtn sizeToFit];
        _getVerifiedCodeBtn.titleLabel.font = CUSFONT(12);
        _getVerifiedCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_getVerifiedCodeBtn startWithTime:120 title:@"获取验证码" countDownTitle:@"S后重发" mainColor:[UIColor whiteColor] countColor:[UIColor whiteColor]];
        [_getVerifiedCodeBtn setTitleColor:[UIColor grayColor] forState: UIControlStateDisabled];
        [_getVerifiedCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_getVerifiedCodeBtn addTarget:self action:@selector(sendVerifyCodeWithBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        [_loginBtn setTitle:@"下 一 步" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.enabled = false;
    }
    return _loginBtn;
}

- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:13];
        _descLabel.textColor = [UIColor colorFromHex:0x808080];
        _descLabel.text = @"手机验证码已发送至*********";
    }
    return _descLabel;
}

#pragma mark - action
-(void)textFiledEditChange:(UITextField *)textField{
    if (textField == _pwdTF) {
        if (textField.text.length > 4) {
            NSString *s = [textField.text substringToIndex:4];
            _pwdTF.text = s;
        }
    }
    self.loginBtn.enabled = textField.text.length == 4;
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

- (void)nextBtnAction {
    NSDictionary *params = @{
                             @"type": @"1",
                             @"phone": self.phoneNum,
                             @"code": self.pwdTF.text
                             };
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/check/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (self.nextAction) {
                self.nextAction(self.phoneNum, self.pwdTF.text);
            }
        }
        if ([responseDic objectForKey:@"errorMsg"]) {
             NSString *errorMsg = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"errorMsg"]];
//            [[UIApplication sharedApplication].keyWindow makeToast:errorMsg];
        }
    } fail:^(NSError *error) {
        [RequestManager showAlertFrom:self title:@"" mesaage:error.localizedDescription success:nil];
    }];
   
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
    self.descLabel.text = [NSString stringWithFormat:@"手机验证码已发送至%@", [num implicitPhoneNumFormat]];
    [self.pwdTF becomeFirstResponder];
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

@end
