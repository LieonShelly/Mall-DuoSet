//
//  SettingTableViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/28.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "SettingTableViewController.h"
#import "AboutThisAppController.h"
#import "ServiceViewController.h"
#import "OrderDetailNextActionCell.h"
#import "FeedbackController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"

@interface SettingTableViewController ()
{
    NSArray *_firstDataSoruceArray;
    NSArray *_secondDataSourceArray;
}
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.scrollEnabled = false;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self configUI];
    [self initDataSource];
}

-(void)configUI{
    UserInfo *info = [Utils getUserInfo];
    if (info.token) {
        UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), mainScreenHeight - FitHeight(450.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
        [logoutBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
        [logoutBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
        logoutBtn.titleLabel.font = CUSFONT(15);
        [logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:logoutBtn];
        [logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [self.view bringSubviewToFront:logoutBtn];
    }
}

- (void)initDataSource
{
    _firstDataSoruceArray = [[NSArray alloc] initWithObjects:@"非WLAN环境下手动下载图片", @"WLAN环境下自动升级客户端",  nil];
    _secondDataSourceArray = [[NSArray alloc] initWithObjects:@"意见反馈", @"关于哆集", @"清除缓存", nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) { // 组1
//        return _firstDataSoruceArray.count;
//    } else if (section == 1) { // 组2
//        return _secondDataSourceArray.count;
//    }
//    return 5;
    return _secondDataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID2";
    OrderDetailNextActionCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
    if (cell == nil) {
        cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
    }
    cell.tipsLable.text = _secondDataSourceArray[indexPath.row];
    cell.tipsLable.textColor = [UIColor colorFromHex:0x222222];
    if (indexPath.row == 2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.rightSubLable.text = [Utils getCacheSize];
        });
    }
    return cell;
//    if (indexPath.section == 0) { // 组1
//        static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID";
//        OrderDetailNextActionCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
//        if (cell == nil) {
//            cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
//        }
//        cell.tipsLable.text = _firstDataSoruceArray[indexPath.row];
//        cell.tipsLable.textColor = [UIColor colorFromHex:0x222222];
//        UISwitch *switchBtn = [[UISwitch alloc]initWithFrame:CGRectMake(FitWith(600.0), FitHeight(15.0), 50, 50)];
//        switchBtn.onTintColor = [UIColor mainColor];
//        switchBtn.on = true;
//        [cell.contentView addSubview:switchBtn];
//        cell.arrowImgV.hidden = true;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return cell;
//    } else if (indexPath.section == 1) { // 组2
//        static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID2";
//        OrderDetailNextActionCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
//        if (cell == nil) {
//            cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
//        }
//        cell.tipsLable.text = _secondDataSourceArray[indexPath.row];
//        cell.tipsLable.textColor = [UIColor colorFromHex:0x222222];
//        if (indexPath.row == 2) {
//            cell.rightSubLable.text = [Utils getCacheSize];
//        }
//        return cell;
//    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(106.0);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1 ) {
        AboutThisAppController *aboutApp = [[AboutThisAppController alloc]init];
        aboutApp.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutApp animated:true];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        if (![self checkLogin]) {
            [self userlogin];
            return;
        }
        FeedbackController *feedBackApp = [[FeedbackController alloc]init];
        feedBackApp.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedBackApp animated:true];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [Utils clearFile];
        　　dispatch_sync(dispatch_get_main_queue(), ^{
            [MQToast showToast:@"清除缓存成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            　　});
        });
    }
}

#pragma mark - progress
-(void)logout{
    [RequestManager showAlertFrom:self title:@"" mesaage:@"您确定要退出登录吗？" doneActionTitle:@"确定" handle:^{
        [RequestManager requestWithMethod:GET WithUrlPath:@"user/logout" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [MQToast showToast:@"退出登录成功" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                [Utils setUserInfo:[[UserInfo alloc]init]];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"LogoutSuccess" object:nil];
                [self.navigationController popViewControllerAnimated:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    }];
}

- (void)progressIsChooseButton:(UIButton *)sender
{
    sender.selected =! sender.selected;
    if (sender.selected == YES) {
        sender.backgroundColor = [UIColor greenColor];
    } else {
        sender.backgroundColor = [UIColor redColor];
    }
}

-(BOOL)checkLogin{
    UserInfo *info = [Utils getUserInfo];
    return info.token.length > 0;
}

-(void)userlogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

@end
