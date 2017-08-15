//
//  AccountManageController.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AccountManageController.h"
#import "AccountavtarCell.h"
#import "OrderDetailNextActionCell.h"
#import "AddressViewController.h"
#import "UserInfoController.h"
#import "AccountAndSafeController.h"
#import "QualificationRegistController.h"
#import "QualificationData.h"

@interface AccountManageController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleNameArr;
@property(nonatomic,strong) NSArray *subTitleArr;
@property(nonatomic,strong) QualificationData *qualification;

@end

@implementation AccountManageController

- (void)viewDidLoad {
    self.title = @"账户管理";
    [super viewDidLoad];
    _titleNameArr = @[@"地址管理",@"账户安全",@"增票资质"];
    _subTitleArr = @[@"",@"密码/支付管理",@""];
    [self creatUI];
    [self configData];
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

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/invoice/qualification" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"qualification"]) {
                    if ([objDic objectForKey:@"qualification"] != [NSNull null]) {
                        if ([[objDic objectForKey:@"qualification"] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *qualificationDic = [objDic objectForKey:@"qualification"];
                            _qualification = [QualificationData dataForDictionary:qualificationDic];
                            if (_qualification.status == CheckInfoNotBegin) {
                                _subTitleArr = @[@"",@"密码/支付管理",@"审核中"];
                            }
                            if (_qualification.status == CheckInfoSuccess) {
                                _subTitleArr = @[@"",@"密码/支付管理",@"审核成功"];
                            }
                            if (_qualification.status == CheckInfoFailure) {
                                _subTitleArr = @[@"",@"密码/支付管理",@"审核失败"];
                            }
                            [_tableView reloadData];
                        }
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *AccountavtarCellID = @"AccountavtarCellID";
        AccountavtarCell * cell = [_tableView dequeueReusableCellWithIdentifier:AccountavtarCellID];
        if (cell == nil) {
            cell = [[AccountavtarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AccountavtarCellID];
        }
        UserInfo *info = [Utils getUserInfo];
        cell.userNameLable.text = info.name;
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
        return cell;
    }else{
        static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID";
        OrderDetailNextActionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
        if (cell == nil) {
            cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
        }
        cell.tipsLable.text = _titleNameArr[indexPath.row - 1];
        cell.rightSubLable.text = _subTitleArr[indexPath.row - 1];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ? FitHeight(150.0) : FitHeight(106.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        UserInfoController *accountVC = [[UserInfoController alloc]init];
        accountVC.hidesBottomBarWhenPushed = YES;
        accountVC.modifyHandle = ^(){
            UserInfoModfyBlock block = _infoModfyHandle;
            if (block) {
                block();
            }
            [tableView reloadData];
        };
        [self.navigationController pushViewController:accountVC animated:true];
    }
    if (indexPath.row == 1) {
        AddressViewController *addressVc = [[AddressViewController alloc]init];
        addressVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:addressVc animated:true];
    }
    if (indexPath.row == 2) {
//        AccountAndSafeController *accountVC = [[AccountAndSafeController alloc]init];
//        accountVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:accountVC animated:true];
        UserInfo *info = [Utils getUserInfo];
        NSString *urlStr = isDebug ? @"https://test.hlhdj.cn/live-web" : @"https://app.hlhdj.cn";
        WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@/live/safe/index?token=%@",urlStr,info.token] NavTitle:@""];
        webVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:webVC animated:true];
    }
    if (indexPath.row == 3) {
        QualificationRegistController *registVC = [[QualificationRegistController alloc]init];
        registVC.hidesBottomBarWhenPushed = YES;
        registVC.uploadHandle = ^(){
            _subTitleArr = @[@"",@"密码/支付管理",@"审核中"];
            [_tableView reloadData];
        };
        [self.navigationController pushViewController:registVC animated:true];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

@end
