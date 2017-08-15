//
//  ThirdpartyBindingController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ThirdpartyBindingController.h"
#import "PooCodeView.h"
#import "RegisterViewController.h"
#import "ModifiPassWordController.h"
#import "FindPasswordVC.h"

@interface ThirdpartyBindingController ()<UITextFieldDelegate>
//Data
@property(nonatomic,assign)ThirdpartyLoginType loginType;
@property(nonatomic,copy) NSString *accessToken;
@property(nonatomic,copy) NSString *openId;
@property(nonatomic,copy) NSString *unionId;
@property(nonatomic,strong) NSDictionary *info;

@property(nonatomic,copy) NSMutableString *codeStr;
//View
@property(nonatomic,strong) UITextField *phoneNumTF;
@property(nonatomic,strong) UITextField *pwdTF;
@property(nonatomic,strong) UITextField *codeTF;
@property(nonatomic,strong) PooCodeView *pooCodeView;

@end

@implementation ThirdpartyBindingController

#pragma mark - init & viewDidLoad
-(instancetype)initWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info{
    self = [super init];
    if (self) {
        _loginType = loginType;
        _accessToken = accessToken;
        _openId = openId;
        _unionId = unionId;
        _info = info;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户绑定";
    [self configUI];
    [self getcode];
}

#pragma mark - configUI
-(void)configUI{
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, FitHeight(20.0) + 64, mainScreenWidth, FitHeight(320.0))];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *phoneNumLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), 0, FitWith(200.0), FitHeight(110.0))];
    phoneNumLable.textColor = [UIColor colorFromHex:0x222222];
    phoneNumLable.font = CUSFONT(14);
    phoneNumLable.text = @"哆集账号";
    [bgView addSubview:phoneNumLable];
    
    _phoneNumTF = [[UITextField alloc]initWithFrame:CGRectMake(phoneNumLable.frame.origin.x + phoneNumLable.frame.size.width , 0, FitWith(470.0), phoneNumLable.frame.size.height)];
    _phoneNumTF.placeholder = @"请输入您的手机号码";
    _phoneNumTF.textColor = [UIColor colorFromHex:0x333333];
    _phoneNumTF.font = CUSFONT(15);
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumTF.tintColor = [UIColor mainColor];
    [_phoneNumTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:_phoneNumTF];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, phoneNumLable.frame.origin.y + phoneNumLable.frame.size.height, mainScreenWidth, 0.5)];
    line1.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    [bgView addSubview:line1];
    
    UILabel *pwdLable = [[UILabel alloc]initWithFrame:CGRectMake(phoneNumLable.frame.origin.x, line1.frame.origin.y , phoneNumLable.frame.size.width, FitHeight(100.0))];
    pwdLable.textColor = [UIColor colorFromHex:0x222222];
    pwdLable.font = CUSFONT(14);
    pwdLable.text = @"密码";
    [bgView addSubview:pwdLable];
    
    _pwdTF = [[UITextField alloc]initWithFrame:CGRectMake(_phoneNumTF.frame.origin.x, pwdLable.frame.origin.y, _phoneNumTF.frame.size.width, _phoneNumTF.frame.size.height)];
        _pwdTF.secureTextEntry = YES;
    _pwdTF.placeholder = @"请输入密码";
    _pwdTF.textColor = [UIColor colorFromHex:0x333333];
    _pwdTF.font = CUSFONT(15);
    _pwdTF.tintColor = [UIColor mainColor];
    _pwdTF.returnKeyType = UIReturnKeyNext;
    _pwdTF.delegate = self;
    [_pwdTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
    [bgView addSubview:_pwdTF];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, pwdLable.frame.origin.y + pwdLable.frame.size.height, mainScreenWidth , 0.5)];
    line2.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    [bgView addSubview:line2];
    
    UILabel *codeLable = [[UILabel alloc]initWithFrame:CGRectMake(phoneNumLable.frame.origin.x, line2.frame.origin.y , phoneNumLable.frame.size.width, FitHeight(110.0))];
    codeLable.textColor = [UIColor colorFromHex:0x222222];
    codeLable.font = CUSFONT(14);
    codeLable.text = @"验证码";
    [bgView addSubview:codeLable];
    
    _codeTF = [[UITextField alloc]initWithFrame:CGRectMake(_phoneNumTF.frame.origin.x, codeLable.frame.origin.y, FitWith(320.0), _phoneNumTF.frame.size.height)];
    _codeTF.placeholder = @"请输入验证码";
    _codeTF.textColor = [UIColor colorFromHex:0x333333];
    _codeTF.font = CUSFONT(15);
    _codeTF.tintColor = [UIColor mainColor];
    _codeTF.returnKeyType = UIReturnKeyDone;
    _codeTF.delegate = self;
    [bgView addSubview:_codeTF];
    
    _pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(FitWith(585.0), FitHeight(235.0), FitWith(140.0), FitHeight(60.0))];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [_pooCodeView addGestureRecognizer:tap];
    _pooCodeView.hidden = true;
    [bgView addSubview:_pooCodeView];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, codeLable.frame.origin.y + codeLable.frame.size.height, mainScreenWidth , 0.5)];
    line3.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
    [bgView addSubview:line3];
    
    UILabel *tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), 64 + FitHeight(380.0), mainScreenWidth - FitWith(30.0), FitHeight(60.0))];
    NSString *str = @"";
    if (_loginType == ThirdpartyLoginWithQQ) {
        str = @"QQ";
    }
    if (_loginType == ThirdpartyLoginWithWechat) {
        str = @"微信账号";
    }
    if (_loginType == ThirdpartyLoginWithSina) {
        str = @"微博";
    }
    tipsLable.text = [NSString stringWithFormat:@"关联后,您的%@账号和哆集账号都可以登录",str];
    tipsLable.textColor = [UIColor colorFromHex:0x222222];
    tipsLable.font = CUSFONT(13);
    [self.view addSubview:tipsLable];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0), tipsLable.frame.origin.y + tipsLable.frame.size.height + FitHeight(42.0), mainScreenWidth - FitWith(48.0), FitHeight(90.0))];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    loginBtn.titleLabel.font = CUSFONT(16);
    [loginBtn setTitle:@"确 定" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *forgateBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(180.0) - FitWith(24.0), loginBtn.frame.origin.y + loginBtn.frame.size.height + FitHeight(20.0), FitWith(180.0), FitHeight(80.0))];
    [forgateBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    forgateBtn.titleLabel.font = CUSFONT(13);
    [forgateBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgateBtn addTarget:self action:@selector(forgateAccountPwd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgateBtn];
    
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyBord)];
    [self.view addGestureRecognizer:g];
}

#pragma mark - getcode & refrashCode
-(void)getcode{
    NSString *urlStr = @"";
    if (_loginType == ThirdpartyLoginWithQQ) {
        urlStr = [NSString stringWithFormat:@"commons/validate/bindThird?type=qq&openId=%@",_openId];
    }
    if (_loginType == ThirdpartyLoginWithWechat) {
        urlStr = [NSString stringWithFormat:@"commons/validate/bindThird?type=wechat&openId=%@",_openId];
    }
    if (_loginType == ThirdpartyLoginWithSina) {
        urlStr = [NSString stringWithFormat:@"commons/validate/bindThird?type=weibo&openId=%@",_openId];
    }
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"code"]) {
                    _codeStr = [NSMutableString stringWithFormat:@"%@",[objDic objectForKey:@"code"]];
                    _pooCodeView.hidden = false;
                    _pooCodeView.changeString = _codeStr;
                    [_pooCodeView setNeedsDisplay];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

//刷新验证码
-(void)tapClick:(UITapGestureRecognizer *)tap{
    [self getcode];
}

#pragma mark - textFiledDelegate & hiddenKeyBord
-(void)hiddenKeyBord{
    [_phoneNumTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
    [_codeTF resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _pwdTF) {
        [_codeTF becomeFirstResponder];
    }if (textField == _codeTF) {
        [_codeTF resignFirstResponder];
    }
    return true;
}

-(void)textFiledEditChange:(UITextField *)textField{
    if (textField == _phoneNumTF) {
        if (textField.text.length >= 11) {
            NSString *s = [textField.text substringToIndex:11];
            _phoneNumTF.text = s;
            NSString *valiStr = [ValiMobile valiMobile:_phoneNumTF.text];
            if ([valiStr isEqualToString:@"YES"]) {//检验是否已经注册过
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:s forKey:@"username"];
                [RequestManager requestWithMethod:POST WithUrlPath:@"user/reg/validatePhone" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
                    NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                    if ([resultCode isEqualToString:@"ok"]) {
                        if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                            if ([objectDic objectForKey:@"status"]) {
                                NSString *str = [NSString stringWithFormat:@"%@",[objectDic objectForKey:@"status"]];
                                if (str.integerValue == 0) {//未注册
                                    [[UIApplication sharedApplication].keyWindow makeToast:@"该手机号码还未注册，请先注册"];
                                }
                            }
                        }
                    }
                } fail:^(NSError *error) {
                    //
                }];
            }
        }
    }
    if (textField == _pwdTF) {
        if (textField.text.length > 15) {
            NSString *s = [textField.text substringToIndex:15];
            _pwdTF.text = s;
        }
    }
}

#pragma mark - bindAndLogin
-(void)loginBtnAction{
    NSString *valiStr = [ValiMobile valiMobile:_phoneNumTF.text];
    if (![valiStr isEqualToString:@"YES"]) {
        [self.view makeToast:valiStr];
        return;
    }
    if (_pwdTF.text.length < 6
        || _pwdTF.text.length > 15
        ) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    if ([Utils isIncludeSpecialCharact: _pwdTF.text]) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    NSString *string = _pooCodeView.changeString;
    NSString *string2 = _codeTF.text;
    BOOL result = [string caseInsensitiveCompare:string2] == NSOrderedSame;
    if (!result) {
        [self.view makeToast:@"验证码有误，请重新输入验证码"];
        return;
    }
    NSString *urlStr = @"";
    if (_loginType == ThirdpartyLoginWithQQ) {
        urlStr = @"user/binding/qq";
    }
    if (_loginType == ThirdpartyLoginWithWechat) {
        urlStr = @"user/binding/wechat";
    }
    if (_loginType == ThirdpartyLoginWithSina) {
        urlStr = @"user/binding/weibo";
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_accessToken forKey:@"accessToken"];
    [params setObject:_openId forKey:@"openId"];
    if (_loginType == ThirdpartyLoginWithWechat) {
        [params setObject:_unionId forKey:@"unionId"];
    }
    [params setObject:_info forKey:@"info"];
    [params setObject:_phoneNumTF.text forKey:@"username"];
    [params setObject:_codeTF.text forKey:@"code"];
    [params setObject:[Utils md5:_pwdTF.text] forKey:@"password"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
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
                    [Utils setUserInfo:info];
                    NSString *provider = @"";
                    if (_loginType == ThirdpartyLoginWithWechat) {
                        provider = @"wechat";
                    }
                    if (_loginType == ThirdpartyLoginWithQQ) {
                        provider = @"QQ";
                    }
                    if (_loginType == ThirdpartyLoginWithSina) {
                        provider = @"Sina";
                    }
                    [UMengStatisticsUtils profileSignInWithPUID:info.userId provider:provider];
                }
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bindingAndLoginSuccess" object:nil];
            [self.navigationController popToRootViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)forgateAccountPwd{
//    ModifiPassWordController *modifiPwdVC = [[ModifiPassWordController alloc]initWithTitleName:@"找回密码"];
//    modifiPwdVC.hidesBottomBarWhenPushed = true;
//    NSString *valiStr = [ValiMobile valiMobile:_phoneNumTF.text];
//    modifiPwdVC.phoneStr = [valiStr isEqualToString:@"YES"] ? _phoneNumTF.text : @"";
//    modifiPwdVC.isFromBindingAccount = true;
//    [self.navigationController pushViewController:modifiPwdVC animated:true];

    FindPasswordVC *modifiPwdVC = [[FindPasswordVC alloc]init];
    modifiPwdVC.hidesBottomBarWhenPushed = true;
    NSString *valiStr = [ValiMobile valiMobile:_phoneNumTF.text];
    modifiPwdVC.phoneNum = [valiStr isEqualToString:@"YES"] ? _phoneNumTF.text : @"";
    modifiPwdVC.navTitle = @"找回密码";
    [self.navigationController pushViewController:modifiPwdVC animated:true];
}

@end
