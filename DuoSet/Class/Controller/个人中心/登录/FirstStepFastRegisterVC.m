//
//  FirstStepFastRegisterVC.m
//  DuoSet
//
//  Created by lieon on 2017/6/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FirstStepFastRegisterVC.h"
#import "FindPasswordVC.h"
#import "TransitionAnimator.h"
#import "CallServiceViewController.h"

@interface FirstStepFastRegisterVC ()<UITextFieldDelegate>
@property(nonatomic,strong) UITextField *phoneNumTF;
@property(nonatomic, strong) UIImageView *userLog;
@property(nonatomic, strong) UIView *line0;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UILabel *descLabel;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property(nonatomic, strong) UIButton *contactBtn;
@property(nonatomic, assign) BOOL isValidPhoneNum;
@property(nonatomic, strong) UIButton *tapLabel;
@property(nonatomic, strong) TransitionAnimator *animator;
@end

@implementation FirstStepFastRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI

- (void)setupUI{
    [self.view addSubview:self.userLog];
    [self.view addSubview:self.phoneNumTF];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.tapLabel];
    [self.view addSubview:self.contactBtn];
    [self.phoneNumTF becomeFirstResponder];
    [self.view setNeedsUpdateConstraints];
}

#pragma mark - layout

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.userLog autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
        [self.userLog autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
        [self.userLog autoSetDimension:ALDimensionWidth toSize:20];
        [self.phoneNumTF autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.userLog withOffset:20];
        [self.phoneNumTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.userLog];
        [self.phoneNumTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.line0 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userLog withOffset:12];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [self.line0 autoSetDimension:ALDimensionHeight toSize:0.5];
        [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line0 withOffset:30];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.loginBtn autoSetDimension:ALDimensionHeight toSize:45];
        [self.descLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.loginBtn withOffset:26];
        [self.descLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.tapLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.descLabel];
        [self.tapLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.descLabel];
        [self.contactBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.descLabel withOffset:-5];
        [self.contactBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.loginBtn];
        self.didSetupConstraints = true;
    }
    [super updateViewConstraints];
}

#pragma mark - action

- (void)configPhonum:(NSString *)num {
    self.isValidPhoneNum = true;
    self.phoneNumTF.text = num;
}

- (void)toWebViewAction {
    [self.view endEditing:true];
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@default/protocol/reg-app.html",WebBaseUrl] NavTitle:@""];
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)textFiledEditChange:(UITextField *)textField{
    if (textField == _phoneNumTF) {
        self.isValidPhoneNum = textField.text.length > 0;
        if (textField.text.length >= 11) {
            NSString *s = [textField.text substringToIndex:11];
            _phoneNumTF.text = s;
        }
//        if (textField.text.length >= 11) {
//            NSString *s = [textField.text substringToIndex:11];
//            _phoneNumTF.text = s;
//            NSString *valiStr = [ValiMobile valiMobile:_phoneNumTF.text];
//            if ([valiStr isEqualToString:@"YES"]) {//检验是否已经注册过
//                self.isValidPhoneNum = true;
//            } else {
//                self.isValidPhoneNum = false;
//            }
//        } else {
//            self.isValidPhoneNum = false;
//        }
    }
}

- (void)isLogedinNumAction {
    CallServiceViewController * destVC = [[ CallServiceViewController alloc]init];
    [destVC configMsg:_isFromthirdLogin ? @"该手机号已被注册，是否立即关联?" : @"该手机号已被注册，是否立即登录?" WithEnterTitle:@"确定" CancelTitle:@"找回密码"];
    __weak typeof(self) weakSelf = self;
    destVC.enterAction = ^{
        if (weakSelf.isFromthirdLogin) {
            [self.navigationController popViewControllerAnimated:true];
            return ;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"fastRegisterVCHandle" object:self userInfo:@{@"phoneNum": self.phoneNumTF.text}];
           [self.navigationController popToRootViewControllerAnimated:true];
    };
    destVC.cancelAction = ^{
        FindPasswordVC * vcc = [[FindPasswordVC alloc]init];
        vcc.phoneNum = self.phoneNumTF.text;
        vcc.navTitle = @"找回密码";
        [self.navigationController pushViewController:vcc animated:true];
    };
    destVC.transitioningDelegate = self.animator;
    destVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:destVC animated:true completion:nil];
    
}

- (void)contactAction {
    CallServiceViewController * destVC = [[ CallServiceViewController alloc]init];
    [destVC configMsg:@"400-189-0090" WithEnterTitle:@"拨打"];
    destVC.enterAction = ^{
         NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-189-0090"];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:str]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    };
    destVC.transitioningDelegate = self.animator;
    destVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:destVC animated:true completion:nil];
}

- (void)nextStepAction {
    [self validatePhoneNum];
}

- (void) validatePhoneNum{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: self.phoneNumTF.text forKey:@"username"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/reg/validatePhone" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if ([objectDic objectForKey:@"status"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[objectDic objectForKey:@"status"]];
                    if (str.integerValue == 0) {//已注册
                        self.isValidPhoneNum = true;
                        [self sendCode];
                    } else {
                        [self.phoneNumTF endEditing:true];
                        [self isLogedinNumAction];
                        self.isValidPhoneNum = false;
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)sendCode {
    NSDictionary *params = @{
                             @"type": @"1",
                             @"phone": self.phoneNumTF.text
                             };
    __weak typeof(self) weakSelf = self;
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sms/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
//            [[UIApplication sharedApplication].keyWindow makeToast:@"验证码发送成功"];
        }
    } fail:^(NSError *error) {
        [RequestManager showAlertFrom:self title:@"" mesaage:error.localizedDescription success:nil];
    }];
    if (weakSelf.nexBtntapAction) {
        weakSelf.nexBtntapAction(self.phoneNumTF.text);
    }
}
#pragma mark - lazy load

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

- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc]init];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textColor = [UIColor colorFromHex:0x808080];
        _descLabel.text = @"注册即视为同意";
    }
    return _descLabel;
}

- (UIButton *)tapLabel {
    if (_tapLabel == nil) {
        _tapLabel = [[UIButton alloc]init];
        _tapLabel.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_tapLabel setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_tapLabel setTitleColor:[UIColor mainColor] forState:UIControlStateHighlighted];
        [_tapLabel setTitle:@"《哆集服务条款》" forState:UIControlStateNormal];
        [_tapLabel addTarget:self action:@selector(toWebViewAction) forControlEvents:UIControlEventTouchUpInside];
        [_tapLabel sizeToFit];
    }
    return _tapLabel;
}


- (UIImageView *)userLog {
    if (_userLog == nil) {
        _userLog = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_phone_num"]];
        _userLog.contentMode = UIViewContentModeCenter;
    }
    return _userLog;
}

- (UIView *)line0 {
    if (_line0 == nil) {
        _line0 = [[UIView alloc]init];
        _line0.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    }
    return _line0;
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
        [_loginBtn addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.enabled = false;
    }
    return _loginBtn;
}

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

#pragma mark - setter

- (void)setIsValidPhoneNum:(BOOL)isValidPhoneNum {
    _isValidPhoneNum = isValidPhoneNum;
    self.loginBtn.enabled = isValidPhoneNum;
}

@end
