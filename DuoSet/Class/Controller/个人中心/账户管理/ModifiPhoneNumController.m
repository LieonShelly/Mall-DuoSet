//
//  ModifiPhoneNumController.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ModifiPhoneNumController.h"
#import "AccountInputCell.h"
#import "AccountverifyCodeInputCell.h"

@interface ModifiPhoneNumController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation ModifiPhoneNumController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号";
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
    [sureBtn setTitle:@"确认更换" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:sureBtn];
        
    self.view.userInteractionEnabled = true;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapClosekeyBoard)];
    [_tableView addGestureRecognizer:g];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *AccountInputCellID = @"AccountInputCellID";
        AccountInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountInputCellID];
        if (cell == nil) {
            cell = [[AccountInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountInputCellID];
        }
        cell.tipsLable.text = @"新手机号";
        cell.inputTF.keyboardType = UIKeyboardTypeNumberPad;
        cell.inputTF.placeholder = @"请输入新手机号码";
        [cell.inputTF addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *AccountverifyCodeInputCellID = @"AccountverifyCodeInputCellID";
        AccountverifyCodeInputCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountverifyCodeInputCellID];
        if (cell == nil) {
            cell = [[AccountverifyCodeInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountverifyCodeInputCellID];
        }
        cell.tipsLable.text = @"验证码";
        cell.inputTF.placeholder = @"请输入验证码";
        cell.inputTF.returnKeyType = UIReturnKeyDone;
        cell.inputTF.delegate = self;
        [cell.inputTF addTarget:self action:@selector(codeTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
        [cell.getVerifyCodeBtn addTarget:self action:@selector(getVerifyCodeActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(106.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(60.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(50.0))];
    headerView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    UILabel *tips = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(30.0), 0, mainScreenWidth - FitWith(30.0), FitHeight(50.0))];
    tips.text = @"请输入您要绑定的手机号";
    tips.font = CUSFONT(10.0);
    tips.textAlignment = NSTextAlignmentLeft;
    tips.textColor = [UIColor colorFromHex:0x666666];
    [headerView addSubview:tips];
    return headerView;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    AccountverifyCodeInputCell * cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell.inputTF resignFirstResponder];
    return true;
}

-(void)textFieldChange:(UITextField *)textField{
    if (textField.text.length >= 11) {
        NSString *s = [textField.text substringToIndex:11];
        textField.text = s;
    }
}

-(void)codeTextFieldChange:(UITextField *)textField{
    if (textField.text.length > 4) {
        NSString *s = [textField.text substringToIndex:4];
        textField.text = s;
    }
}

#pragma mark - ButtonActions
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
    [params setObject:[NSNumber numberWithInt:3] forKey:@"type"];
    [params setObject:cell0.inputTF.text forKey:@"phone"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sms/captcha" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            btn.userInteractionEnabled = true;
            [[UIApplication sharedApplication].keyWindow makeToast:@"短信发送成功，请查收"];
            [btn startWithTime:120 title:@"获取验证码" countDownTitle:@"S后重发" mainColor:[UIColor mainColor] countColor:[UIColor colorFromHex:0x666666]];
        }
    } fail:^(NSError *error) {
        btn.userInteractionEnabled = true;
        //
    }];
}


-(void)sureBtnAction{
    AccountInputCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *valiStr = [ValiMobile valiMobile:cell0.inputTF.text];
    if (![valiStr isEqualToString:@"YES"]) {
        [RequestManager showAlertFrom:self title:@"" mesaage:valiStr success:^(){
        }];
        return;
    }
    AccountverifyCodeInputCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell1.inputTF.text.length == 0) {
        [RequestManager showAlertFrom:self title:@"" mesaage:@"请输入手机短信验证码" success:^(){
        }];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:cell0.inputTF.text forKey:@"phone"];
    [params setValue:cell1.inputTF.text forKey:@"code"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/exchangePhone" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [[UIApplication sharedApplication].keyWindow makeToast:@"手机号码变更成功"];
            UserInfo *info = [Utils getUserInfo];
            info.phone = cell0.inputTF.text;
            [Utils setUserInfo:info];
            ModifyPhoneNumSucessBlock block = _modifySucessHanlde;
            if (block) {
                block();
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)viewTapClosekeyBoard{
    [self.view endEditing:false];
}

@end
