//
//  AddressViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/8.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAndEditAddressController.h"
#import "AddressEditCell.h"
#import "AddressCell.h"

@interface AddressViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSMutableArray *addressDataArray;

@end

@implementation AddressViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self checkRefreshToken]) {
        [self getAddressListData];
    }else{
        [RequestManager refershTokenSuccess:^{
            [self getAddressListData];
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
    self.view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    [self creatUI];
}

#pragma mark - 获取地址列表
-(void)getAddressListData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/address" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _addressDataArray = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]){
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    AddressModel *item = [AddressModel dataForDictionary:d];
                    [_addressDataArray addObject:item];
                }
            }
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - creatUI
-(void) creatUI{
    
    UIButton *leftSignInButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [leftSignInButton setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    leftSignInButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [leftSignInButton addTarget:self action:@selector(progressLeftButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftSignInButton];
    self.navigationItem.leftBarButtonItem = left;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, mainScreenWidth, mainScreenHeight + 20 - FitHeight(150.0) - FitHeight(40.0)) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.rowHeight = 120;
    
    UIButton *addAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), mainScreenHeight - FitHeight(150.0), mainScreenWidth - FitWith(40.0), FitHeight(90.0))];
    [addAddressBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_normal"] forState:UIControlStateNormal];
    [addAddressBtn setBackgroundImage:[UIImage imageNamed:@"loginBtn_highlighted"] forState:UIControlStateHighlighted];
    addAddressBtn.titleLabel.font = CUSFONT(15);
    [addAddressBtn setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddressBtn addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addAddressBtn];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _addressDataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *AddressCellID = @"AddressCellID";
        AddressCell * cell = [_tableView dequeueReusableCellWithIdentifier:AddressCellID];
        if (cell == nil) {
            cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressCellID];
        }
        AddressModel *item = _addressDataArray[indexPath.section];
        [cell setupInfoWithAddressModel:item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 1) {
        static NSString *AddressEditCellID = @"AddressEditCellID";
        AddressEditCell * cell = [_tableView dequeueReusableCellWithIdentifier:AddressEditCellID];
        if (cell == nil) {
            cell = [[AddressEditCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressEditCellID];
        }
        AddressModel *item = _addressDataArray[indexPath.section];
        cell.defaultbtn.selected = item.isDEFAULT;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.editBtnHandle = ^(UIButton *btn){
            [self cellBtnsActionWithBtn:btn andIndex:indexPath.section];
        };
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isChoice) {
        AddressModel *item = _addressDataArray[indexPath.section];
        AddressSeletcedBlock block = _seletcedHandle;
        if (block) {
            block(item);
        }
        [self.navigationController popViewControllerAnimated:true];
    }else{
        AddressModel *item = _addressDataArray[indexPath.section];
        AddAndEditAddressController *inPutAddressVC = [[AddAndEditAddressController alloc] initWithAddressEditStatus:AddressEdit];
        inPutAddressVC.addressItem = item;
        inPutAddressVC.changeHandle = ^(){
            [self getAddressListData];
        };
        [self.navigationController pushViewController:inPutAddressVC animated:YES];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row == 0 ? FitHeight(170.0) : FitHeight(90.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  section == 0 ? 0.1 : FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - buttonActions
- (void) addAddressAction {
    AddAndEditAddressController *inPutAddressVC = [[AddAndEditAddressController alloc] initWithAddressEditStatus:AddressAdd];
    inPutAddressVC.changeHandle = ^(){
        [self getAddressListData];
    };
    [self.navigationController pushViewController:inPutAddressVC animated:YES];
}

-(void)cellBtnsActionWithBtn:(UIButton *)btn andIndex:(NSInteger)index{
    AddressModel *item = _addressDataArray[index];
    if (btn.tag == 0) {//设置默认
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.address_id forKey:@"id"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/address?default" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [self getAddressListData];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
    if (btn.tag == 1) {//编辑
        AddAndEditAddressController *inPutAddressVC = [[AddAndEditAddressController alloc] initWithAddressEditStatus:AddressEdit];
        inPutAddressVC.addressItem = item;
        inPutAddressVC.changeHandle = ^(){
            [self getAddressListData];
        };
        [self.navigationController pushViewController:inPutAddressVC animated:YES];
    }
    if (btn.tag == 2) {//删除
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"确定要删除吗？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSString *urlStr = [NSString stringWithFormat:@"user/address/%@?delete",item.address_id];
            [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
                NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
                if ([resultCode isEqualToString:@"ok"]) {
                    [self getAddressListData];
                }
            } fail:^(NSError *error) {
                //
            }];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //
        }];
        [alertVC addAction:done];
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:true completion:nil];
    }
}

-(void)progressLeftButton{
    [self.navigationController popViewControllerAnimated:true];
}

-(BOOL)checkRefreshToken{
    if ([Utils getUserInfo].token.length > 0) {
        UserInfo *info = [Utils getUserInfo];
        NSDate *now = [NSDate date];
        NSInteger tmp = [now timeIntervalSinceDate:info.refreshTokenDate];
        if (tmp < (info.expiresIn.integerValue)/1000) {//还没过期了
            return true;
        }
    }
    return false;
}

@end
