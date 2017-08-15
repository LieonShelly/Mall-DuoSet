//
//  RegisterViewController.m
//  DuoSet
//
//  Created by fanfans on 2017/2/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "RegisterViewController.h"
#import "AccountInputCell.h"
#import "AccountverifyCodeInputCell.h"

@interface RegisterViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleArr;
@property(nonatomic,strong) NSArray *subTitleArr;
@property(nonatomic,strong) UIButton *agreeBtn;
@property(nonatomic,assign) BOOL isAgree;
//Data
@property(nonatomic,assign)ThirdpartyLoginType loginType;
@property(nonatomic,copy) NSString *accessToken;
@property(nonatomic,copy) NSString *openId;
@property(nonatomic,copy) NSString *unionId;
@property(nonatomic,strong) NSDictionary *info;
@property(nonatomic,assign) BOOL isthirdParty;

@end

@implementation RegisterViewController

-(instancetype)initWithThirdpartyLoginType:(ThirdpartyLoginType)loginType accessToken:(NSString *)accessToken openId:(NSString *)openId unionId:(NSString *)unionId userInfo:(NSDictionary *)info{
    self = [super init];
    if (self) {
        _isthirdParty = true;
        _loginType = loginType;
        _accessToken = accessToken;
        _openId = openId;
        _unionId = unionId;
        _info = info;
    }
    return self;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机快速注册";
    _titleArr = @[@"手机号",@"密码",@"确认密码",@"验证码"];
    _subTitleArr = @[@"请输入手机号",@"请输入密码",@"再次输入密码",@"请输入验证码"];
    [self creatUI];
}

#pragma mark - creatUI
- (void)creatUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.scrollEnabled = false;
    [self.view addSubview:_tableView];
    
    _agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(40.0), FitHeight(640.0), FitWith(30.0), FitWith(30.0))];
    [_agreeBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
    [_agreeBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
    _agreeBtn.userInteractionEnabled = false;
    _agreeBtn.selected = false;
    _isAgree = false;
    [self.view addSubview:_agreeBtn];
    [self.view bringSubviewToFront:_agreeBtn];
    
    UIButton *markBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(10.0), FitHeight(610.0), FitWith(80.0), FitWith(80.0))];
    markBtn.selected = false;
    [markBtn addTarget:self action:@selector(markBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:markBtn];
    
    UIButton *protocolBtn = [[UIButton alloc]initWithFrame:CGRectMake(_agreeBtn.frame.origin.x + _agreeBtn.frame.size.width + FitWith(10.0), _agreeBtn.frame.origin.y, FitWith(250.0), _agreeBtn.frame.size.height)];
    protocolBtn.titleLabel.font = CUSFONT(10);
    [protocolBtn setTitle:@"同意哆集用户注册协议" forState:UIControlStateNormal];
    [protocolBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
    [protocolBtn addTarget:self action:@selector(protocolBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocolBtn];
    [self.view bringSubviewToFront:protocolBtn];
    
    UIButton *registerBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), FitHeight(730.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [registerBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    registerBtn.titleLabel.font = CUSFONT(15);
    [registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(registerBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:registerBtn];
    
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClosekeyBoard)];
    [_tableView addGestureRecognizer:g];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 3) {
        static NSString *AccountInputCellID = @"AccountInputCellID";
        AccountInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountInputCellID];
        if (cell == nil) {
            cell = [[AccountInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountInputCellID];
        }
        cell.tipsLable.text = _titleArr[indexPath.row];
        cell.inputTF.tag = indexPath.row;
        if (indexPath.row == 0) {
            cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
            cell.inputTF.text = _phoneNum.length > 0 ? _phoneNum : @"";
        }else{
            cell.inputTF.returnKeyType = UIReturnKeyNext;
            cell.inputTF.delegate = self;
        }
        cell.inputTF.placeholder = _subTitleArr[indexPath.row];
        if (indexPath.row == 1 || indexPath.row == 2) {
            cell.inputTF.secureTextEntry = true;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.inputTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        return cell;
    }else{
        static NSString *AccountverifyCodeInputCellID = @"AccountverifyCodeInputCellID";
        AccountverifyCodeInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountverifyCodeInputCellID];
        if (cell == nil) {
            cell = [[AccountverifyCodeInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountverifyCodeInputCellID];
        }
        cell.tipsLable.text = _titleArr[indexPath.row];
        cell.inputTF.placeholder = _subTitleArr[indexPath.row];
        cell.inputTF.returnKeyType = UIReturnKeyDone;
        cell.inputTF.delegate = self;
        cell.inputTF.tag = indexPath.row;
        cell.inputTF.autocapitalizationType = UITextAutocapitalizationTypeNone ;
        cell.inputTF.autocorrectionType = UITextAutocorrectionTypeNo;
        [cell.getVerifyCodeBtn addTarget:self action:@selector(getVerifyCodeActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(106.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TextFiledDelegata



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {
        AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        [cell.inputTF becomeFirstResponder];
    }
    if (textField.tag == 2) {
        AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [cell.inputTF becomeFirstResponder];
    }
    if (textField.tag == 3) {
        AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        [cell.inputTF resignFirstResponder];
    }
    return true;
}

-(void)textFiledEditChange:(UITextField *)textField{
    if (textField.tag == 0) {
        if (textField.text.length >= 11) {
            NSString *s = [textField.text substringToIndex:11];
            AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            cell.inputTF.text = s;
            NSString *valiStr = [ValiMobile valiMobile:cell.inputTF.text];
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
                                if (str.integerValue == 1) {//已注册
                                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"该手机号码已注册，是否前往登录?" preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                        cell.inputTF.text = @"";
                                        [cell.inputTF becomeFirstResponder];
                                    }];
                                    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        RegisteBlock block = _isRegisteBlock;
                                        if (block) {
                                            block(s);
                                        }
                                        [self.navigationController popViewControllerAnimated:true];
                                    }];
                                    [alert addAction:cancel];
                                    [alert addAction:doneAction];
                                    [self.navigationController presentViewController:alert animated:true completion:nil];
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
    if (textField.tag == 1) {
        if (textField.text.length > 15) {
            NSString *s = [textField.text substringToIndex:15];
            AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.inputTF.text = s;
        }
    }
    if (textField.tag == 2) {
        if (textField.text.length > 15) {
            NSString *s = [textField.text substringToIndex:15];
            AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.inputTF.text = s;
        }
    }
}

#pragma mark - BtnAction
-(void)viewTapClosekeyBoard{
    [self.view endEditing:true];
}

-(void)markBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    _agreeBtn.selected = !_agreeBtn.selected;
    _isAgree = btn.selected;
}

-(void)protocolBtnAction{
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@default/protocol/reg-app.html",WebBaseUrl] NavTitle:@""];
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)getVerifyCodeActionHandle:(UIButton *)btn{
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *valiStr = [ValiMobile valiMobile:cell0.inputTF.text];
    if (![valiStr isEqualToString:@"YES"]) {
        [RequestManager showAlertFrom:self title:@"" mesaage:valiStr success:^(){
        }];
        return;
    }
    [self sendVerifyCodeWithBtn:btn];
}

-(void)sendVerifyCodeWithBtn:(UIButton *)btn{
    btn.userInteractionEnabled = false;
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"type"];
    [params setObject:cell0.inputTF.text forKey:@"phone"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sms/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            btn.userInteractionEnabled = true;
//            [[UIApplication sharedApplication].keyWindow makeToast:@"短信发送成功，请查收"];
            [btn startWithTime:120 title:@"获取验证码" countDownTitle:@"S后重发" mainColor:[UIColor mainColor] countColor:[UIColor colorFromHex:0x666666]];
        }
    } fail:^(NSError *error) {
        btn.userInteractionEnabled = true;
        //
    }];
}

-(void)registerBtnAction{
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *valiStr = [ValiMobile valiMobile:cell0.inputTF.text];
    if (![valiStr isEqualToString:@"YES"]) {
        [self.view makeToast:valiStr];
        return;
    }
    
    AccountInputCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AccountInputCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (cell1.inputTF.text.length < 6
        || cell1.inputTF.text.length > 15
        ) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    if ([Utils isIncludeSpecialCharact:cell1.inputTF.text]) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    
    if (![cell1.inputTF.text isEqualToString:cell2.inputTF.text]) {
        [self.view makeToast:@"两次密码输入不一致请重新输入"];
        return;
    }
    
    if ( cell2.inputTF.text.length < 6
        || cell2.inputTF.text.length > 15) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    if ([Utils isIncludeSpecialCharact:cell2.inputTF.text]) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    
    if (![cell1.inputTF.text isEqualToString:cell2.inputTF.text]) {
        [self.view makeToast:@"两次密码输入不一致请重新输入"];
        return;
    }
    
    AccountInputCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell3.inputTF.text.length == 0) {
        [self.view makeToast:@"请输入手机短信验证码"];
        return;
    }
    
    if (!_isAgree) {
        [self.view makeToast:@"请先同意哆集用户注册协议"];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cell0.inputTF.text forKey:@"username"];
    [params setObject:cell3.inputTF.text forKey:@"code"];
    [params setObject:[Utils md5:cell1.inputTF.text] forKey:@"password"];
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
                if (_isthirdParty) {
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
                }else{
                    [UMengStatisticsUtils profileSignInWithPUID:info.userId];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginSuccess" object:nil];
                RegisterSucceed block = _succeedBlock;
                if (block) {
                    block();
                }
                [self.navigationController popToRootViewControllerAnimated:true];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}
@end
