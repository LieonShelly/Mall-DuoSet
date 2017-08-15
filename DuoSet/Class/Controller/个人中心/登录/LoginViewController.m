//
//  LoginViewController.m
//  DuoSet
//
//  Created by fanfans on 2017/2/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "LoginViewController.h"
#import "ModifiPassWordController.h"
#import "RegisterViewController.h"
#import "ThirdpartyLoginController.h"
#import "ThirdpartyBindingController.h"

//QQ
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
//wechat
#import "WXApi.h"
//sina
#import "WeiboSDK.h"
#import "FastLoginViewController.h"
#import "FastRegisterViewController.h"
#import "FindPasswordVC.h"

@interface LoginViewController ()<UITextFieldDelegate, TencentSessionDelegate>{
    TencentOAuth *_tencentOAuth;
    NSMutableArray *_permissionArray;
}

@property(nonatomic,strong) UITextField *phoneNumTF;
@property(nonatomic,strong) UITextField *pwdTF;
@property(nonatomic, strong) UIImageView *userLog;
@property(nonatomic, strong) UIImageView *pwdLog;
@property(nonatomic, strong) UIView *line0;
@property(nonatomic, strong) UIView *line1;
@property(nonatomic, strong) UIView *line2;
@property(nonatomic, strong) UIButton *forgetPwdBtn;
@property(nonatomic, strong) UIButton *fastloginBtn;
@property(nonatomic, strong) UIButton *fastlRegisterBtn;
@property(nonatomic, strong) UIButton *loginBtn;
@property(nonatomic, strong) UIButton *qqLoginBtn;
@property(nonatomic, strong) UIButton *sinaLoginBtn;
@property(nonatomic, strong) UIButton *wechatLoginBtn;
//三方登录相关信息
@property(nonatomic,assign) ThirdpartyLoginType loginType;
@property(nonatomic,copy) NSString *accessToken;
@property(nonatomic,copy) NSString *openId;
@property(nonatomic,copy) NSString *unionId;
@property(nonatomic,copy) NSDictionary *info;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, assign) BOOL isValidPhoneNum;
@property(nonatomic, strong) NSString *phoneNum;
@end

@implementation LoginViewController

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"哆集登录";
    [self configUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fastRegisterVCHandle:) name:@"fastRegisterVCHandle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wechatLoginNotifyHandle:) name:@"WechatLoginHandle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindingAndLoginSuccessHandle) name:@"bindingAndLoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bindingAndLoginSuccessHandle) name:@"LoginSuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weiboDidLoginNotification:) name:@"weiboDidLoginNotification" object:nil];
    _loginType = ThirdpartyLoginWithOther;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.phoneNum.length > 0) {
        self.phoneNumTF.text = _phoneNum;
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - setter
- (void)setIsValidPhoneNum:(BOOL)isValidPhoneNum {
    _isValidPhoneNum = isValidPhoneNum;
    self.loginBtn.enabled = isValidPhoneNum;
}

#pragma mark - lazy load
- (UITextField *)phoneNumTF {
    if (_phoneNumTF == nil) {
        _phoneNumTF = [[UITextField alloc]init];
        _phoneNumTF.placeholder = @"请输入用户名";
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
        _pwdTF.secureTextEntry = YES;
        _pwdTF.placeholder = @"请输入您的登录密码";
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
          _userLog = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_center_account"]];
        _userLog.contentMode = UIViewContentModeCenter;
    }
    return _userLog;
}

- (UIImageView *)pwdLog {
    if (_pwdLog == nil) {
        _pwdLog = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_center_pwd"]];
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
        [_forgetPwdBtn addTarget:self action:@selector(forgatePwdHandle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPwdBtn;
}

-(UIButton *)fastloginBtn {
    if (_fastloginBtn == nil) {
        _fastloginBtn= [[UIButton alloc]init];
        _fastloginBtn.titleLabel.font = CUSFONT(12);
        [_fastloginBtn setTitle:@"手机快速登录" forState:UIControlStateNormal];
        [_fastloginBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_fastloginBtn addTarget:self action:@selector(fastloginAction) forControlEvents:UIControlEventTouchUpInside];
        [_fastloginBtn sizeToFit];
    }
    return _fastloginBtn;
}

- (UIButton *)fastlRegisterBtn {
    if (_fastlRegisterBtn == nil ) {
        _fastlRegisterBtn= [[UIButton alloc]init];
        _fastlRegisterBtn.titleLabel.font = CUSFONT(12);
        [_fastlRegisterBtn setTitle:@"手机快速注册" forState:UIControlStateNormal];
        [_fastlRegisterBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_fastlRegisterBtn addTarget:self action:@selector(registerBtnActionHandle) forControlEvents:UIControlEventTouchUpInside];
        [_fastloginBtn sizeToFit];
    }
    return  _fastlRegisterBtn;
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

- (UIButton *)sinaLoginBtn {
    if (_sinaLoginBtn == nil) {
        _sinaLoginBtn = [UIButton newAutoLayoutView];
        [_sinaLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_sina"] forState:UIControlStateNormal];
        [_sinaLoginBtn addTarget:self action:@selector(sinaLoginHandle) forControlEvents:UIControlEventTouchUpInside];
         [_sinaLoginBtn sizeToFit];
    }
    return _sinaLoginBtn;
}
- (UIButton *)qqLoginBtn {
    if (_qqLoginBtn == nil) {
        _qqLoginBtn = [[UIButton alloc]init];
        [_qqLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_qq"] forState:UIControlStateNormal];
        [_qqLoginBtn addTarget:self action:@selector(qqLoginHandle) forControlEvents:UIControlEventTouchUpInside];
        [_qqLoginBtn sizeToFit];
    }
    return  _qqLoginBtn;
}

- (UIButton *)wechatLoginBtn {
    if (_wechatLoginBtn == nil) {
        _wechatLoginBtn = [[UIButton alloc]init];
        [_wechatLoginBtn setBackgroundImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
        [_wechatLoginBtn addTarget:self action:@selector(wechatLoginHandle) forControlEvents:UIControlEventTouchUpInside];
         [_wechatLoginBtn sizeToFit];
    }
    return _wechatLoginBtn;
}

#pragma mark - configUI
-(void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.userLog];
    [self.view addSubview:self.phoneNumTF];
    [self.view addSubview:self.line0];
    [self.view addSubview:self.pwdLog];
    [self.view addSubview:self.pwdTF];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.forgetPwdBtn];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.fastloginBtn];
    [self.view addSubview:self.fastlRegisterBtn];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.sinaLoginBtn];
    [self.view addSubview:self.wechatLoginBtn];
    [self.view addSubview:self.qqLoginBtn];
    [self.view setNeedsUpdateConstraints];
    UIButton *leftSignInButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [leftSignInButton setImage:[UIImage imageNamed:@"common_close"] forState:UIControlStateNormal];
    leftSignInButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [leftSignInButton addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftSignInButton];
    self.navigationItem.leftBarButtonItem = left;
    self.view.userInteractionEnabled = true;
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
        [self.phoneNumTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
        [self.line0 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.userLog withOffset:12];
        [self.line0 autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [self.line0 autoSetDimension:ALDimensionHeight toSize:0.5];
        [self.pwdLog autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.userLog];
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
        [self.fastlRegisterBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.userLog withOffset:0];;
        [self.fastlRegisterBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.line2 withOffset:15];
        [self.fastloginBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.line2 withOffset:0];
        [self.fastloginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.fastlRegisterBtn withOffset:0];
        [self.loginBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.fastlRegisterBtn withOffset:50];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.loginBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.loginBtn autoSetDimension:ALDimensionHeight toSize:45];
        CGFloat inset = (mainScreenWidth - 3 * self.qqLoginBtn.bounds.size.width) * 0.25;
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
            [self.qqLoginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset: inset];
            [self.qqLoginBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:35];
            [self.wechatLoginBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.qqLoginBtn];
            [self.wechatLoginBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.qqLoginBtn withOffset:inset];
            [self.sinaLoginBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.qqLoginBtn];
            [self.sinaLoginBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.wechatLoginBtn withOffset:inset];
        }else{
            [self.qqLoginBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset: inset];
            [self.qqLoginBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:35];
            [self.sinaLoginBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.qqLoginBtn];
            [self.sinaLoginBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.qqLoginBtn withOffset:inset];
        }
        
        self.didSetupConstraints = true;
    }
     [super updateViewConstraints];
}
#pragma mark - QQ-login
-(void)qqLoginHandle{
    _tencentOAuth = [[TencentOAuth alloc]initWithAppId:QQ_AppID andDelegate:self];
    _permissionArray = [NSMutableArray arrayWithObjects: kOPEN_PERMISSION_GET_USER_INFO,nil];
    [_tencentOAuth authorize:_permissionArray inSafari:NO];
    
//    [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//        if (state == SSDKResponseStateSuccess){
//                NSLog(@"uid=%@",user.uid);
//                NSLog(@"%@",user.credential);
//                NSLog(@"token=%@",user.credential.token);
//                NSLog(@"nickname=%@",user.nickname);　　//在这里面实现app界面的跳转：
//            [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
//            }else{ NSLog(@"%@",error);
//        }
//    }];
}

- (void)tencentDidLogin{
    if (_tencentOAuth.accessToken) {
        NSLog(@"accessToken 授权成功");
        _accessToken = _tencentOAuth.accessToken;
        _openId = _tencentOAuth.openId;
//        [_tencentOAuth getUserInfo];
        [self checkLogInWithThirdpartyLoginType:ThirdpartyLoginWithQQ accessToken:_tencentOAuth.accessToken openId:_tencentOAuth.openId unionId:nil];
    }else{
        NSLog(@"accessToken 没有获取成功");
    }
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
    }else{
        NSLog(@"其他原因， 导致登录失败");
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog(@"没有网络了， 怎么登录成功呢");
}


/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    
    // incrAuthWithPermissions是增量授权时需要调用的登录接口
    // permissions是需要增量授权的权限列表
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO; // 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}

/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    return YES;
}

/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
    NSLog(@"增量授权完成");
    if (tencentOAuth.accessToken
        && 0 != [tencentOAuth.accessToken length])
    { // 在这里第三方应用需要更新自己维护的token及有效期限等信息
        // **务必在这里检查用户的openid是否有变更，变更需重新拉取用户的资料等信息** _labelAccessToken.text = tencentOAuth.accessToken;
        NSLog(@"tencentOAuth:%@",tencentOAuth);
    }
    else
    {
        NSLog(@"增量授权不成功，没有获取accesstoken");
    }
    
}

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
- (void)tencentFailedUpdate:(UpdateFailType)reason{
    
    switch (reason)
    {
        case kUpdateFailNetwork:
        {
            NSLog(@"增量授权失败，无网络连接，请设置网络");
            break;
        }
        case kUpdateFailUserCancel:
        {
            NSLog(@"增量授权失败，用户取消授权");
            break;
        }
        case kUpdateFailUnknown:
        default:
        {
            NSLog(@"增量授权失败，未知错误");
            break;
        }
    }
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response{
    _loginType = ThirdpartyLoginWithQQ;
    NSDictionary *dic = response.jsonResponse;
    ThirdpartyLoginController *thirdLoginVC = [[ThirdpartyLoginController alloc]initWithThirdpartyLoginType:_loginType accessToken:_accessToken openId:_openId unionId:nil userInfo:dic];
    thirdLoginVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:thirdLoginVC animated:true];
}

#pragma mark - Wechat
-(void)wechatLoginHandle{
//    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//        if (state == SSDKResponseStateSuccess){
//            NSLog(@"uid=%@",user.uid);
//            NSLog(@"%@",user.credential);
//            NSLog(@"token=%@",user.credential.token);
//            NSLog(@"nickname=%@",user.nickname);　　//在这里面实现app界面的跳转：
//            [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
//        }else{ NSLog(@"%@",error);
//        }
//    }];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
        SendAuthReq *req = [[SendAuthReq alloc]init];
        req.scope = @"snsapi_userinfo";
        req.openID = WeChat_AppID;
        req.state = @"125432";
        [WXApi sendReq:req];
    }else{
        [RequestManager showAlertFrom:self title:@"温馨提示" mesaage:@"您还未下载安装微信,不能使用微信登录" success:^{
            //
        }];
    }
}

- (void) fastRegisterVCHandle:(NSNotification *)sender {
    NSDictionary *dic = sender.userInfo;
    NSString *num  = @"";
    if ([dic objectForKey:@"phoneNum"]) {
        num = [NSString stringWithFormat:@"%@",[dic objectForKey:@"phoneNum"]];
    }
    self.phoneNum = num;
}

-(void)wechatLoginNotifyHandle:(NSNotification *)sender{
    NSDictionary *dic = sender.userInfo;
    NSString *code  = @"";
    if ([dic objectForKey:@"code"]) {
        code = [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
    }
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WeChat_AppID,WeChat_AppSecret,code];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *access_token = dic[@"access_token"];
                NSString *openID = dic[@"openid"];
                NSString *unionid = dic[@"unionid"];
                _accessToken = access_token;
                _openId = openID;
                _unionId = unionid;
                [self checkLogInWithThirdpartyLoginType:ThirdpartyLoginWithWechat accessToken:access_token openId:openID unionId:unionid];
            }
        });
    });
}

-(void)getwechaUserInfoWithAccessToken:(NSString *)accessToken openID:(NSString *)openID unionid:(NSString *)unionid{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openID];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                _loginType = ThirdpartyLoginWithWechat;
                ThirdpartyLoginController *thirdLoginVC = [[ThirdpartyLoginController alloc]initWithThirdpartyLoginType:_loginType accessToken:_accessToken openId:_openId unionId:_unionId userInfo:dic];
                thirdLoginVC.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:thirdLoginVC animated:true];
            }
        });
    });
}

#pragma mark - sina
-(void)sinaLoginHandle{
//    WBAuthorizeRequest *request = [[WBAuthorizeRequest alloc]init];
//    request.redirectURI = kAppRedirectURI;
//    request.scope = @"all";
//    [WeiboSDK sendRequest:request];
        [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess){
//                    NSLog(@"uid=%@",user.uid);
//                    NSLog(@"%@",user.credential);
//                    NSLog(@"token=%@",user.credential.token);
//                    NSLog(@"nickname=%@",user.nickname);
                    _accessToken = user.credential.token;
                    _openId = user.uid;
                    [self getWeiboUserInfoWithAccessToken:user.credential.token uid:user.uid];
                }else{ NSLog(@"%@",error);
            }
        }];
}

#pragma mark - Weibo Methods
-(void)weiboDidLoginNotification:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSString *accessToken = [userInfo objectForKey:@"accessToken"];
    NSString *uid = [userInfo objectForKey:@"userId"];
    _accessToken = accessToken;
    _openId = uid;
    [self checkLogInWithThirdpartyLoginType:ThirdpartyLoginWithSina accessToken:accessToken openId:uid unionId:nil];
}

- (void)getWeiboUserInfoWithAccessToken:(NSString *)accessToken uid:(NSString *)uid
{
    NSString *url =[NSString stringWithFormat:
                    @"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",accessToken,uid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl
                                                     encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingMutableContainers error:nil];
                _loginType = ThirdpartyLoginWithSina;
                ThirdpartyLoginController *thirdLoginVC = [[ThirdpartyLoginController alloc]initWithThirdpartyLoginType:_loginType accessToken:accessToken openId:_openId unionId:uid userInfo:dic];
                thirdLoginVC.hidesBottomBarWhenPushed = true;
                [self.navigationController pushViewController:thirdLoginVC animated:true];
            }
        });
        
    });
}


-(void)checkLogInWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId
                                unionId :(NSString *)unionId{
    NSString *urlStr = @"";
    if (loginType == ThirdpartyLoginWithQQ) {
        urlStr = @"user/login-qq";
    }
    if (loginType == ThirdpartyLoginWithWechat) {
        urlStr = @"user/login-wechat";
    }
    if (loginType == ThirdpartyLoginWithSina) {
        urlStr = @"user/login-weibo";
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:accessToken forKey:@"accessToken"];
    [params setObject:openId forKey:@"openId"];
    if (loginType == ThirdpartyLoginWithWechat) {
        [params setObject:unionId forKey:@"unionId"];
    }
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic =[responseDic objectForKey:@"object"];
                UserInfo *info = [[UserInfo alloc]init];
                if ([objDic objectForKey:@"code"]) {
                    NSString *code = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"code"]];
                    if (code.integerValue == 0) {//登录成功
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
                        NSString *provider = @"";
                        if (loginType == ThirdpartyLoginWithWechat) {
                            provider = @"wechat";
                        }
                        if (loginType == ThirdpartyLoginWithQQ) {
                            provider = @"QQ";
                        }
                        if (loginType == ThirdpartyLoginWithSina) {
                            provider = @"Sina";
                        }
                        [UMengStatisticsUtils profileSignInWithPUID:info.userId provider:provider];
                        [self dismissViewControllerAnimated:true completion:^{
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
                        }];
                    }else{//未登陆
                        if (loginType == ThirdpartyLoginWithWechat) {
                            [self getwechaUserInfoWithAccessToken:accessToken openID:openId unionid:unionId];
                        }
                        if (loginType == ThirdpartyLoginWithQQ) {
                            [_tencentOAuth getUserInfo];
                        }
                        if (loginType == ThirdpartyLoginWithSina) {
                            [self getWeiboUserInfoWithAccessToken:accessToken uid:openId];
                        }
                    }
                }
            }
        }
    } fail:^(NSError *error) {
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
            NSString *valiStr = [ValiMobile valiMobile:_phoneNumTF.text];
            if ([valiStr isEqualToString:@"YES"]) {//检验是否已经注册过
//                NSMutableDictionary *params = [NSMutableDictionary dictionary];
//                [params setObject:s forKey:@"username"];
//                [RequestManager requestWithMethod:POST WithUrlPath:@"user/reg/validatePhone" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
//                    NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
//                    if ([resultCode isEqualToString:@"ok"]) {
//                        if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
//                            NSDictionary *objectDic = [responseDic objectForKey:@"object"];
//                            if ([objectDic objectForKey:@"status"]) {
//                                NSString *str = [NSString stringWithFormat:@"%@",[objectDic objectForKey:@"status"]];
//                                if (str.integerValue == 0) {//已注册
//                                    [[UIApplication sharedApplication].keyWindow makeToast:@"该手机号码还未注册，请先注册"];
//                                }
//                            }
//                        }
//                    }
//                } fail:^(NSError *error) {
//                    //
//                }];
            }
        }
    }
    if (textField == _pwdTF) {
        if (textField.text.length > 15) {
            NSString *s = [textField.text substringToIndex:15];
            _pwdTF.text = s;
        }
    }
    self.isValidPhoneNum = _pwdTF.text.length > 0 && _phoneNumTF.text.length == 11;
}

#pragma mark - BtnActionHandle

-(void)bindingAndLoginSuccessHandle{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)viewTapClosekeyBoard{
    [_phoneNumTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
}

-(void)registerBtnActionHandle{
    FastRegisterViewController * registrVC = [[FastRegisterViewController alloc]init];
    registrVC.registerSuccecss = ^(NSString *phoneNum) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
        [self dismissViewControllerAnimated:true completion:nil];
    };
   [self.navigationController pushViewController:registrVC animated:true];
}

- (void)fastloginAction {
    FastLoginViewController * fastLoginVC = [[FastLoginViewController alloc]init];
    fastLoginVC.phoneNum = self.phoneNumTF.text;
    __weak typeof(self) weakSelf = self;
    fastLoginVC.fastLoginSuccess = ^{
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    };
    [self.navigationController pushViewController:fastLoginVC animated:true];
}

-(void)forgatePwdHandle{
    FindPasswordVC * modifiPwdVC = [[FindPasswordVC alloc]init];
    NSString *valiStr = [ValiMobile valiMobile:_phoneNumTF.text];
    modifiPwdVC.phoneNum = [valiStr isEqualToString:@"YES"] ? _phoneNumTF.text : @"";
    modifiPwdVC.navTitle = @"找回密码";
     [self.navigationController pushViewController:modifiPwdVC animated:true];
}

-(void)progressLeftSignInButton{
    [_phoneNumTF resignFirstResponder];
    [_pwdTF resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelLogin" object:nil];
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)loginBtnAction{
    [self.view endEditing:true];
  
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        char  substr = [_phoneNumTF.text characterAtIndex:0];
        if (_phoneNumTF.text.length != 11 || ![[NSString stringWithFormat:@"%c", substr] isEqualToString:@"1"]) {
            [MQToast showToast:@"请输入正确的手机号" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        } else {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:_phoneNumTF.text forKey:@"username"];
            [params setObject:[Utils md5:_pwdTF.text] forKey:@"password"];
            [RequestManager requestWithMethod:POST WithUrlPath:@"user/login" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
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
                        if ([jsonDic objectForKey:@"expiresIn"]) {
                            userInfo.expiresIn = [NSString stringWithFormat:@"%@",[jsonDic objectForKey:@"expiresIn"]];
                        }
                        userInfo.refreshTokenDate = [NSDate date];
                        userInfo.phone = _phoneNumTF.text;
                        if ([jsonDic objectForKey:@"info"] && [[jsonDic objectForKey:@"info"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *infoDic = [jsonDic objectForKey:@"info"];
                            UserInfo *info = [UserInfo dataForDic:infoDic];
                            userInfo.avatar = info.avatar;
                            userInfo.userId = info.userId;
                            userInfo.name = info.name;
                        }
                        [Utils setUserInfo:userInfo];
                        [UMengStatisticsUtils profileSignInWithPUID:userInfo.userId];
                        [self dismissViewControllerAnimated:true completion:^{
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
                        }];
                    }
                }
            } fail:^(NSError *error) {
                [RequestManager showAlertFrom:self title:@"" mesaage:@"网络状况不佳" success:^{
                    
                }];
                //
            }];
        }
    });
}

- (void)pushController:(UIViewController *)VC titleName:(NSString *)titleName
{
    VC.title = titleName;
    VC.view.backgroundColor = LGBgColor;
    UIBarButtonItem *leftReturnButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_nav_arrow_black"] style:UIBarButtonItemStylePlain target:self action:@selector(progressLeftReturnButton)];
    leftReturnButton.tintColor = [UIColor darkGrayColor];
    VC.navigationItem.leftBarButtonItem = leftReturnButton;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)progressLeftReturnButton{
    [self.navigationController popViewControllerAnimated:true];
}

@end
