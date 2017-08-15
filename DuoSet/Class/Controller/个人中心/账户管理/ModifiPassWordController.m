//
//  modifiPassWordController.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ModifiPassWordController.h"
#import "AccountInputCell.h"
#import "AccountverifyCodeInputCell.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "RegisterViewController.h"

@interface ModifiPassWordController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleArr;
@property(nonatomic,strong) NSArray *subTitleArr;
@property(nonatomic,copy) NSString *titleName;

@end

@implementation ModifiPassWordController

-(instancetype)initWithTitleName:(NSString *)titleName{
    self = [super init];
    if (self) {
        _titleName = titleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleName;
    _titleArr = @[@"手机号",@"验证码",@"新密码",@"确认密码"];
    _subTitleArr = @[@"请输入手机号",@"请输入验证码",@"不少于六位字符",@"不少于六位字符"];
    [self creatUI];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.scrollEnabled = false;
    [self.view addSubview:_tableView];
    
    UIButton *sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), mainScreenHeight - FitHeight(250.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    sureBtn.titleLabel.font = CUSFONT(15);
    [sureBtn setTitle:[_titleName isEqualToString:@"找回密码"] ? @"确认找回" : @"确认修改" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:sureBtn];
    
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClosekeyBoard)];
    [_tableView addGestureRecognizer:g];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row != 1) {
        static NSString *AccountInputCellID = @"AccountInputCellID";
        AccountInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountInputCellID];
        if (cell == nil) {
            cell = [[AccountInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountInputCellID];
        }
        cell.tipsLable.text = _titleArr[indexPath.row];
        if (indexPath.row == 0) {
            cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
            UserInfo *info = [Utils getUserInfo];
            if (info.phone && info.phone.length == 11) {
                _phoneStr = [NSString stringWithFormat:@"%@****%@",[info.phone substringToIndex:3],[info.phone substringFromIndex:7]];
                cell.inputTF.userInteractionEnabled = false;
                cell.inputTF.text = _phoneStr;
            }else{
                cell.inputTF.text = _phoneStr;
                cell.tag = indexPath.row;
                [cell.inputTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
            }
        }else{
            cell.inputTF.returnKeyType = UIReturnKeyNext;
            if (indexPath.row == 3) {
                cell.inputTF.returnKeyType = UIReturnKeyDone;
            }
            cell.tag = indexPath.row;
            cell.inputTF.delegate = self;
            cell.inputTF.tag = indexPath.row;
            [cell.inputTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        }
        cell.inputTF.placeholder = _subTitleArr[indexPath.row];
        if (indexPath.row == 2 || indexPath.row == 3) {
            cell.inputTF.secureTextEntry = true;
            cell.tag = indexPath.row;
            [cell.inputTF addTarget:self action:@selector(textFiledEditChange:) forControlEvents:UIControlEventEditingChanged];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *AccountverifyCodeInputCellID = @"AccountverifyCodeInputCellID";
        AccountverifyCodeInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountverifyCodeInputCellID];
        if (cell == nil) {
            cell = [[AccountverifyCodeInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountverifyCodeInputCellID];
        }
        cell.tipsLable.text = _titleArr[indexPath.row];
        cell.inputTF.placeholder = _subTitleArr[indexPath.row];
        cell.inputTF.returnKeyType = UIReturnKeyNext;
        cell.inputTF.delegate = self;
        cell.inputTF.tag = indexPath.row;
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
            if ([Utils getUserInfo].token == nil) {
                NSString *valiStr = [ValiMobile valiMobile:s];
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
                                        [RequestManager showAlertFrom:self title:@"温馨提示" mesaage:@"该手机号码还未注册，请先注册" doneActionTitle:@"去注册" handle:^{
                                            RegisterViewController *registrVC = [[RegisterViewController alloc]init];
                                            registrVC.phoneNum = s;
                                            [self pushController:registrVC titleName:@"手机快速注册"];
                                        }];
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
    }
    if (textField.tag == 2) {
        if (textField.text.length > 15) {
            NSString *s = [textField.text substringToIndex:15];
            AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.inputTF.text = s;
        }
    }
    if (textField.tag == 3) {
        if (textField.text.length > 15) {
            NSString *s = [textField.text substringToIndex:15];
            AccountInputCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.inputTF.text = s;
        }
    }
}
#pragma mark - ButtonAction
-(void)getVerifyCodeActionHandle:(UIButton *)btn{
    UserInfo *info = [Utils getUserInfo];
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (info.phone == nil) {
        NSString *valiStr = [ValiMobile valiMobile:cell0.inputTF.text];
        if (![valiStr isEqualToString:@"YES"]) {
            [RequestManager showAlertFrom:self title:@"" mesaage:valiStr success:^(){
            }];
            return;
        }
    }
    [self sendVerifyCodeWithBtn:btn];
}

-(void)sendVerifyCodeWithBtn:(UIButton *)btn{
    btn.userInteractionEnabled = false;
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UserInfo *info = [Utils getUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:info.phone == nil ? [NSNumber numberWithInt:4] : [NSNumber numberWithInt:5] forKey:@"type"];
    [params setObject:info.phone == nil ? cell0.inputTF.text : info.phone forKey:@"phone"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sms/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            btn.userInteractionEnabled = true;
            [[UIApplication sharedApplication].keyWindow makeToast:@"短信发送成功，请查收"];
            [btn startWithTime:120 title:@"获取验证码" countDownTitle:@"S后重发" mainColor:[UIColor mainColor] countColor:[UIColor grayColor]];
        }
    } fail:^(NSError *error) {
        btn.userInteractionEnabled = true;
        //
    }];
}

-(void)sureBtnAction{
    UserInfo *info = [Utils getUserInfo];
    if (info.phone == nil) {
        AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *valiStr = [ValiMobile valiMobile:cell0.inputTF.text];
        if (![valiStr isEqualToString:@"YES"]) {
            [self.view makeToast:valiStr];
            return;
        }
    }
    
    AccountverifyCodeInputCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell1.inputTF.text.length == 0) {
        [self.view makeToast:@"请输入手机短信验证码"];
        return;
    }
    AccountInputCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    AccountInputCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell2.inputTF.text.length < 6
        || cell2.inputTF.text.length > 15
        ) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    
    if (cell3.inputTF.text.length < 6
        || cell3.inputTF.text.length > 15
        ) {
        [self.view makeToast:@"两次输入密码不一致"];
        return;
    }
    if ([Utils isIncludeSpecialCharact:cell2.inputTF.text]) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    if ([Utils isIncludeSpecialCharact:cell3.inputTF.text]) {
        [self.view makeToast:@"请输入6-15位数字、字母或者组合的密码"];
        return;
    }
    if (![cell2.inputTF.text isEqualToString:cell3.inputTF.text]) {
        [self.view makeToast:@"两次输入密码不一致"];
        return;
    }
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:info.phone == nil ? cell0.inputTF.text : [Utils getUserInfo].phone forKey:@"username"];
    [params setObject:cell1.inputTF.text forKey:@"code"];
    [params setObject:[Utils md5:cell2.inputTF.text] forKey:@"password"];
    [params setObject: info.phone != nil ? [NSNumber numberWithInteger:1] : [NSNumber numberWithInteger:0] forKey:@"type"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/setPass" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (_isFromBindingAccount) {
                [[UIApplication sharedApplication].keyWindow makeToast:@"密码变更成功"];
                [self.navigationController popViewControllerAnimated:true];
                return ;
            }
            [[UIApplication sharedApplication].keyWindow makeToast:@"修改密码成功"];
            [Utils setUserInfo:[[UserInfo alloc]init]];
            [self.navigationController popViewControllerAnimated:true];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"modifyPwdRelogin" object:nil];
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)viewTapClosekeyBoard{
    [self.view endEditing:false];
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
