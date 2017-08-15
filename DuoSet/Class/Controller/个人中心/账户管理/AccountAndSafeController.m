//
//  AccountAndSafeController.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AccountAndSafeController.h"
#import "OrderDetailNextActionCell.h"
#import "ModifiPassWordController.h"
#import "ModifiPhoneNumController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "FindPasswordVC.h"

@interface AccountAndSafeController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleArr;
@property(nonatomic,strong) NSArray *subTitleArr;


@end

@implementation AccountAndSafeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyPwdReloginHandle) name:@"modifyPwdRelogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyPwdRelogCancelHandle) name:@"cancelLogin" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户与安全";
    _titleArr = @[@"我的账号",@"修改手机号",@"修改登录密码"];
    [self configData];
    [self creatUI];
    
}

-(void)configData{
    UserInfo *info = [Utils getUserInfo];
    NSString *phoneStr = @"";
    if (info.phone && info.phone.length == 11) {
        phoneStr = [NSString stringWithFormat:@"%@****%@",[info.phone substringToIndex:3],[info.phone substringFromIndex:7]];
    }
    _subTitleArr = @[info.name,phoneStr,@""];
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
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID";
    OrderDetailNextActionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
    if (cell == nil) {
        cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
    }
    cell.tipsLable.text = _titleArr[indexPath.row];
    cell.rightSubLable.text = _subTitleArr[indexPath.row];
    cell.arrowImgV.hidden = indexPath.row == 0;
    cell.selectionStyle = indexPath.row == 0 ? UITableViewCellSelectionStyleNone : UITableViewCellSelectionStyleDefault;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(106.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
        FindPasswordVC * modifiPwdVC = [[FindPasswordVC alloc]init];
        modifiPwdVC.phoneNum = [Utils getUserInfo].phone;
        modifiPwdVC.phoneTFEnable = true;
        modifiPwdVC.navTitle = @"修改密码";
        [self.navigationController pushViewController:modifiPwdVC animated:true];
    }
    if (indexPath.row == 1) {
        [self verifyPassWord];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - 验证密码
-(void)verifyPassWord{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"密码验证" message:@"请输入您的原密码" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入您的原密码";
        textField.secureTextEntry = YES;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[Utils md5:alertController.textFields[0].text] forKey:@"password"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/exchangePhone?validatePass" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                ModifiPhoneNumController *modifiPhoneVC = [[ModifiPhoneNumController alloc]init];
                modifiPhoneVC.modifySucessHanlde = ^(){
                    UserInfo *info = [Utils getUserInfo];
                    NSString *phoneStr = @"";
                    if (info.phone && info.phone.length == 11) {
                        phoneStr = [NSString stringWithFormat:@"%@****%@",[info.phone substringToIndex:3],[info.phone substringFromIndex:7]];
                    }
                    _subTitleArr = @[info.name,phoneStr,@""];
                    [_tableView reloadData];
                };
                [self.navigationController pushViewController:modifiPhoneVC animated:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    }];
    [alertController addAction:cancel];
    [alertController addAction:done];
    [self presentViewController:alertController animated:true completion:nil];
}

-(void)modifyPwdReloginHandle{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

-(void)modifyPwdRelogCancelHandle{
    [self.navigationController popToRootViewControllerAnimated:true];
}

@end
