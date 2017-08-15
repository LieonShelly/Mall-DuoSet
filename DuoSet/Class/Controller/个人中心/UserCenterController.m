//
//  UserCenterController.m
//  DuoSet
//
//  Created by fanfans on 2017/2/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserCenterController.h"
#import "SettingTableViewController.h"
#import "AccountManageController.h"
#import "SingleProductNewController.h"
#import "CouponListController.h"
#import "AttentionViewController.h"
#import "WalletViewController.h"
#import "BrownRecordsController.h"
#import "ActivityViewController.h"
#import "ServiceViewController.h"
#import "OrderCategoryController.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "VIPViewController.h"
#import "DuojiPointsController.h"
#import "AllOrderViewController.h"
#import "UserPiazzaDetailsController.h"
//views
#import "UserCenterHeaderView.h"
#import "OrderDetailNextActionCell.h"
#import "UserCenterOrderTypeCell.h"
#import "UserCenterItemCell.h"
#import "UserCenterImgItemCell.h"
#import "CommonTitleImageCell.h"
#import "CommonRecommendForYouCell.h"
#import "UserCenterInfoCell.h"
#import "UserCenterMainData.h"
#import "ProductForListData.h"
#import "UserCenterTitleCell.h"
#import "FeedbackController.h"

@interface UserCenterController ()<UITableViewDataSource, UITableViewDelegate>
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *navLable;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIView *navline;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UIView *unredView;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UserCenterHeaderView *headerView;

@property (nonatomic,strong) NSMutableArray *recommendArr;
@property (nonatomic,copy)   NSString *recommendIconStr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,strong) UserCenterMainData *userCenterData;
@property(nonatomic, strong) UIImageView *backgroundView;
@end

@implementation UserCenterController

#pragma mark - viewWillAppear & viewWillDisappear & viewDidLoad
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessRefreshUserinfo) name:@"LoginSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccessRefreshUserinfo) name:@"LogoutSuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modifyPwdReloginHandle) name:@"modifyPwdRelogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessRefreshUserinfo) name:@"bindingAndLoginSuccess" object:nil];
    if ([self checkLogin]) {
        if ([self checkRefreshToken]) {
            [self getUserCenterDataShowHud:false];
            [self getUserInfo];
            [self getvalidateNewMessage];
        }else{
            [RequestManager refershTokenSuccess:^{
                [self getUserCenterDataShowHud:false];
                [self getUserInfo];
                [self getvalidateNewMessage];
            }];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self configNav];
}

#pragma mark - setupUI
- (void)setupUI{
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, mainScreenWidth, mainScreenHeight + 20 - 50) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:_tableView];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        if ([self checkLogin]) {
            [self getUserCenterDataShowHud:false];
        }else{
            [self.tableView.mj_header endRefreshing];
        }
    }];
    self.tableView.mj_header.layer.contents = (id)[UIImage imageNamed:@"piazza_header_bgView"].CGImage;
    [self.tableView insertSubview:self.backgroundView belowSubview:self.tableView.mj_header];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"user_nav_setting_white"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_leftBtn];
    
    _navLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    UserInfo *info = [Utils getUserInfo];
    if (info.name.length > 0) {
        _navLable.text = info.name;
    }
    _navLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _navLable.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
    _navLable.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:_navLable];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [_rightBtn setImage:[UIImage imageNamed:@"home_nav_message_01_white"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(progressRightMessageCenterButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightBtn];
    //未读消息提醒标识
    _unredView = [[UIView alloc]initWithFrame:CGRectMake(25, 10, 8, 8)];
    _unredView.backgroundColor = [UIColor mainColor];
    _unredView.layer.masksToBounds = true;
    _unredView.layer.cornerRadius = 4;
    _unredView.hidden = true;
    [_rightBtn addSubview:_unredView];
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
    [_navView addSubview:_navline];
    UIImageView * bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"piazza_header_bgView"]];
    bgView.frame = self.navView.bounds;
    [self.navView insertSubview:bgView atIndex:0];
    [self.view bringSubviewToFront:_navView];
}

- (UIImageView *)backgroundView {
    if (_backgroundView == nil) {
        _backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"piazza_header_bgView"]];
    }
    return _backgroundView;
}

#pragma mark - configData
-(void)getvalidateNewMessage{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/message/validateNewMessage" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"count"]) {//_footView
                    NSString *count = [objDic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"count"]] : @"0";
                    _unredView.hidden = count.integerValue == 0;
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)getUserInfo{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/info" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                UserInfo *userInfo = [Utils getUserInfo];
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                UserInfo *info = [UserInfo dataForDic:objDic];
                userInfo.avatar = info.avatar;
                userInfo.userId = info.userId;
                userInfo.phone = info.phone;
                userInfo.name = info.name;
                [Utils setUserInfo:userInfo];
                if (info.name.length > 0) {
                    _navLable.text = info.name;
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)getUserCenterDataShowHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/center" params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _userCenterData = [UserCenterMainData dataForDictionary:objDic];
                [_tableView reloadData];
            }
        }
        [self.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        //
          [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource & UITableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 5;
            break;
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    if (indexPath.section == 0) {//用户 哆豆 优惠券 商品关注 我的钱包
        static NSString *UserCenterInfoCellID = @"UserCenterInfoCellID";
        UserCenterInfoCell * cell = [tableView dequeueReusableCellWithIdentifier: UserCenterInfoCellID];
        if (cell == nil) {
            cell = [[UserCenterInfoCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:UserCenterInfoCellID];
        }
        if (self.userCenterData) {
            [cell setupInfoWithUserCenterMainData: self.userCenterData];
        }
        cell.avatarHandle = ^ {
            NSLog(@"avatarHandle");
            if (![weakSelf checkLogin]) {
                [weakSelf userlogin];
                return ;
            }
            AccountManageController *accountManageVC = [[AccountManageController alloc]init];
            accountManageVC.hidesBottomBarWhenPushed = YES;
            accountManageVC.infoModfyHandle = ^(){
                [weakSelf.headerView resetHeaderViewInfo];
            };
            [weakSelf.navigationController pushViewController:accountManageVC animated:true];
        };
        cell.accountHandle = cell.avatarHandle;
        cell.vipHandle = ^ {
            VIPViewController *vipVC = [[VIPViewController alloc]init];
            vipVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vipVC animated:true];

        };
        cell.itemTapHandle = ^(NSInteger index) {
            [weakSelf classItemChoiceWithIndex:index];

        };
        return cell;
    }
     if (indexPath.section == 1) {//订单
         static NSString *UserCenterOrderTypeCellID = @"UserCenterOrderTypeCellID";
         UserCenterOrderTypeCell * cell = [_tableView dequeueReusableCellWithIdentifier:UserCenterOrderTypeCellID];
         if (cell == nil) {
         cell = [[UserCenterOrderTypeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserCenterOrderTypeCellID];
         }
         cell.choiceHanlde = ^(NSInteger index){
         [self orderChoiceWithIndex:index];
         };
         if (_userCenterData) {
         [cell setupInfoWithUserCenterMainData:_userCenterData];
         }
         return cell;
     }
    if (indexPath.section == 2) {// 社区 全部活动 帮助中心 浏览记录 意见反馈
        NSArray * title = @[@"社区", @"全部活动", @"帮助中心", @"浏览记录", @"意见反馈"];
        static NSString *UserCenterTitleCellID = @"UserCenterTitleCellID";
        UserCenterTitleCell * cell = [_tableView dequeueReusableCellWithIdentifier:UserCenterTitleCellID];
        if (cell == nil) {
            cell = [[UserCenterTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserCenterTitleCellID];
        }
        [cell configTitle:title[indexPath.item]];
        cell.itemTapHandle = ^(NSInteger index) {
            [weakSelf imgClassItemChoiceWithIndex:index];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 175;
    }
    if (indexPath.section == 1) {
        return 110;
    }
    if (indexPath.section == 2) {
        return 48;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    if (section == 1 || section == 2) {
        return CGFLOAT_MIN;
    }
    return FitHeight(0.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        UserCenterTitleCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.itemTapHandle(indexPath.row);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:1];
    UIColor *textColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
    UIColor *lineColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:1];
    UIColor *unredColor = [[UIColor mainColor] colorWithAlphaComponent:1];
    CGFloat offset = scrollView.contentOffset.y;
    if (offset < -40) {
        _navView.backgroundColor = [color colorWithAlphaComponent:0];
        _navLable.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
        [_leftBtn setImage:[UIImage imageNamed:@"user_nav_setting_white"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"home_nav_message_01_white"] forState:UIControlStateNormal];
        _unredView.backgroundColor = [UIColor whiteColor];
    }else{
        CGFloat alpha = 1 - ((10 - (offset + 40))/10);
        _navView.backgroundColor = [color colorWithAlphaComponent:alpha];
        _navLable.textColor = [textColor colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [lineColor colorWithAlphaComponent:alpha];
        _unredView.backgroundColor = [unredColor colorWithAlphaComponent:alpha];
    }
    CGFloat height = -(self.tableView.contentOffset.y + self.tableView.contentInset.top);
    if (height < 0) {
        return;
    }
    self.backgroundView.frame = CGRectMake(0, -height-80, mainScreenWidth, height + 80);
}

-(void)orderChoiceWithIndex:(NSInteger)index{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    if (index == 0) {//待付款
        OrderCategoryController *orderVC = [[OrderCategoryController alloc] initWithOrderStates:OrderStatesCreate];
        orderVC.hidesBottomBarWhenPushed = YES;
        orderVC.gohomeHandle = ^{
            UITabBarController *tabar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabar.tabBar.hidden = false;
            tabar.selectedIndex = 0;
        };
        [self.navigationController pushViewController:orderVC animated:true];
    }
    if (index == 1) {//待收货
        OrderCategoryController *orderVC = [[OrderCategoryController alloc] initWithOrderStates:OrderStatesSend];
        orderVC.hidesBottomBarWhenPushed = YES;
        orderVC.gohomeHandle = ^{
            UITabBarController *tabar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabar.tabBar.hidden = false;
            tabar.selectedIndex = 0;
        };
        [self.navigationController pushViewController:orderVC animated:true];
    }
    if (index == 2) {//待评价
        UserInfo *info = [Utils getUserInfo];
        NSString *urlStr = [NSString stringWithFormat:@"%@user/order/commentPage?userId=%@",BaseUrl,info.userId];
        WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:true];
    }
    if (index == 3) {//退换货
        UserInfo *info = [Utils getUserInfo];
        NSString *urlStr = [NSString stringWithFormat:@"%@user/order/changePage?userId=%@",BaseUrl,info.userId];
        WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:urlStr NavTitle:@""];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:true];
    }
    if (index == 4) {//全部订单
        AllOrderViewController *allOrderVC = [[AllOrderViewController alloc]init];
        allOrderVC.hidesBottomBarWhenPushed = YES;
        allOrderVC.gohomeHandle = ^{
            UITabBarController *tabar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabar.tabBar.hidden = false;
            tabar.selectedIndex = 0;
        };
        [self.navigationController pushViewController:allOrderVC animated:true];
    }
}

-(void)classItemChoiceWithIndex:(NSInteger)index{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    if (index == 0) {
        DuojiPointsController *duodouVC = [[DuojiPointsController alloc]init];
        duodouVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:duodouVC animated:true];
    }
    if (index == 1) {
        CouponListController *youhuijuVC = [[CouponListController alloc] init];
        youhuijuVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:youhuijuVC animated:true];
    }
    if (index == 2) {
        AttentionViewController *attentionVC = [[AttentionViewController alloc] init];
        attentionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:attentionVC animated:true];
    }
    if (index == 3) {
        WalletViewController *walletVC = [[WalletViewController alloc] initWithAmout:_userCenterData.balance];
        walletVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:walletVC animated:true];
    }
}

-(void)imgClassItemChoiceWithIndex:(NSInteger)index{
    if (index == 2) { // 客服帮助
        WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@services/q&a",BaseUrl] NavTitle:@""];
        webVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:webVC animated:true];
        return;
    }
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    if (index == 3) { /// 浏览记录
        BrownRecordsController *historyVC = [[BrownRecordsController alloc] init];
        historyVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:historyVC animated:true];
    }
    if (index == 1) { // 全部活动
        ActivityViewController *activityVC = [[ActivityViewController alloc] init];
        activityVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityVC animated:true];
    }
    if (index == 0) { //  社区
        UserInfo *info = [Utils getUserInfo];
        UserPiazzaDetailsController *userPiazzaVC = [[UserPiazzaDetailsController alloc]initWithUserid:info.userId];
        userPiazzaVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userPiazzaVC animated:true];
    }
    
    if (index == 4) { // 意见反馈
        FeedbackController * feedVC = [[FeedbackController alloc]init];
        [self.navigationController pushViewController:feedVC animated:true];
    }
}

#pragma mark - Nav Btn Action
- (void)progressLeftSignInButton{
    SettingTableViewController *settingTableVC = [[SettingTableViewController alloc] init];
    settingTableVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingTableVC animated:true];
}

- (void)progressRightMessageCenterButton{
    if ([self checkLogin]) {
        MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc] init];
        messageCenterVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:messageCenterVC animated:true];
    }else{
        [self userlogin];
    }
}

#pragma mark - loginHandle & logout Handle
-(void)loginSuccessRefreshUserinfo{
    [self getUserCenterDataShowHud:true];
    UserInfo *info = [Utils getUserInfo];
    if (info.name.length > 0) {
        _navLable.text = info.name;
    }
}

-(void)logoutSuccessRefreshUserinfo{
    _unredView.hidden = true;
    _userCenterData = nil;
    _navLable.text = @"";
    UserCenterInfoCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell clearUserCountData];
    [cell clearUserInfo];
    UserCenterOrderTypeCell * cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    [cell1 clearCount];
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

-(void)modifyPwdReloginHandle{
    [self logoutSuccessRefreshUserinfo];
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
