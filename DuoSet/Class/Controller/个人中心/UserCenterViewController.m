//
//  UserCenterViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "UserCenterViewController.h"
#import "OrderCollectionViewCell.h"
#import "OrderCollectionReusableView.h"
#import "HeadCollectionReusableView.h"
#import "ViewControllerRecommendToYouCollectionViewCell.h"
#import "UserMessageTableViewController.h"
#import "SettingTableViewController.h"
#import "UserCenterCell.h"
#import "AllOrderCell.h"
#import "OrderBtnCell.h"
#import "UserCenterThirdCell.h"
#import "UserCenterLastCell.h"
#import "UserCenterHeaderView.h"
#import "RegisterViewController.h"
#import "RecommendForYouProductsDataModel.h"
#import "UserCenterMainData.h"
#import "OrderCategoryController.h"
#import "AccountManageController.h"
#import "SingleProductViewController.h"

#import "CommonTipsCell.h"
#import "CommonRecommendForYouCell.h"

@interface UserCenterViewController () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate>
{
    NSArray *_orderCollectionViewDataSourceArray;
}
@property (nonatomic, copy) UICollectionView * orderCollectionView;/** 订单 */
@property (nonatomic, copy) UICollectionView * recommendToYouCollectionView; // 为你推荐
@property (nonatomic, copy) NSMutableArray * recommendForYouProductsDataArray;
@property (nonatomic, strong) UITableView * bgTableView;
@property (nonatomic, copy) NSMutableDictionary *dataDict;
@property (nonatomic, strong) UserCenterMainData *maindata;
@property (nonatomic, strong) UIImageView *navBackImgView;

@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *navLable;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIView *navline;
@property(nonatomic,strong) UIButton *rightBtn;

@end

@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessRefreshUserinfo) name:@"LoginSuccess" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LGBgColor;
    [self creatUI];
    [self configNav];
    [self getPersonalData];//city_list_json
    [self getRecommendForYouProductsData];
}

- (void) getPersonalData{
    NSUInteger customerId = 1;
    NSString *str = [NSString stringWithFormat:@"{\"customerId\":%ld}", customerId];
    NSDictionary * dict = @{@"data":str};
    [WebRequest webRequestWithURLGetMethod:UserCenter_Data_Url params:dict success:^(id result) {
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDic = result;
            _maindata = [UserCenterMainData dataForDictionary:jsonDic];
        }
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:2];
        [_bgTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    } fail:^(NSString *result) {
        NSLog(@"%@", result);
    }];
}

- (void) getRecommendForYouProductsData{
    NSString *str = @"{\"amount\":4}";
    NSLog(@"%@", str);
    NSDictionary *dict = @{@"data":str};
    [WebRequest webRequestWithURLGetMethod:RecommendToYou_Url params:dict success:^(id result) {
        NSLog(@"%@", result);
        if (!_recommendForYouProductsDataArray){
            _recommendForYouProductsDataArray = [[NSMutableArray alloc] init];
            
        }
        [_recommendForYouProductsDataArray removeAllObjects];
        [_recommendForYouProductsDataArray addObjectsFromArray:[RecommendForYouProductsDataModel objectArrayWithKeyValuesArray:result[@"products"]]];
        [_bgTableView reloadData];
    } fail:^(NSString *result) {
        NSLog(@"%@", result);
    }];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"设置png"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_leftBtn];
    
    _navLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _navLable.text = @"个人中心";
    _navLable.textColor = [UIColor whiteColor];
    _navLable.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:_navLable];
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [_rightBtn setImage:[UIImage imageNamed:@"消息png"] forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(progressRightMessageCenterButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightBtn];
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
    [_navView addSubview:_navline];
    
    [self.view bringSubviewToFront:_navView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:1];
    UIColor *textColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    UIColor *lineColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:1];
    CGFloat offset = scrollView.contentOffset.y;
    if (offset < 0) {
        _navView.backgroundColor = [color colorWithAlphaComponent:0];
        _navLable.textColor = [UIColor whiteColor];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
        _navLable.hidden = true;
        [_leftBtn setImage:[UIImage imageNamed:@"设置png"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"me_message_white"] forState:UIControlStateNormal];
    }else{
        CGFloat alpha = 1 - ((65 - offset)/64);
        _navView.backgroundColor = [color colorWithAlphaComponent:alpha];
        _navLable.textColor = [textColor colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [lineColor colorWithAlphaComponent:alpha];
        _navLable.hidden = false;
        [_leftBtn setImage:[UIImage imageNamed:@"me_setting"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"me_message"] forState:UIControlStateNormal];
    }
}

- (void) creatUI{
    _bgTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, mainScreenWidth, mainScreenHeight - 50 + 20) style: UITableViewStyleGrouped];
    [self.view addSubview:_bgTableView];
    _bgTableView.delegate = self;
    _bgTableView.dataSource = self;
    _bgTableView.rowHeight = 180;
    _bgTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_bgTableView registerNib:[UINib nibWithNibName:@"UserCenterCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_bgTableView registerClass:[AllOrderCell class] forCellReuseIdentifier:@"cell2"];
    [_bgTableView registerClass:[OrderBtnCell class] forCellReuseIdentifier:@"cell3"];
    [_bgTableView registerClass:[UserCenterThirdCell class] forCellReuseIdentifier:@"cell4"];
    [_bgTableView registerClass:[UserCenterLastCell class] forCellReuseIdentifier:@"cell5"];
    [_bgTableView registerNib:[UINib nibWithNibName:@"UserCenterHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"headerView"];
}

#pragma tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableVie{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 || section == 3){
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
    UserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.accountManager = ^{
            AccountManageController *accountManageVC = [[AccountManageController alloc]init];
            accountManageVC.hidesBottomBarWhenPushed = YES;
            accountManageVC.infoModfyHandle = ^(){
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            [self pushController:accountManageVC titleName:@"账户管理"];
        };
        [cell reSetUserinfo];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ((indexPath.section == 1) && (indexPath.row == 0)){
        AllOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.allOrderBtn = ^{
            OrderViewController *orderVC = [[OrderViewController alloc] init];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self pushController:orderVC titleName:@"全部订单"];
            
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if ((indexPath.section == 1) && (indexPath.row == 1)){    
    OrderBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.weifukuan = ^{
            OrderCategoryController *orderVC = [[OrderCategoryController alloc] initWithOrderStates:OrderStatesCreate];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self pushController:orderVC titleName:@"待付款"];
        };
       
        cell.weishouhuo = ^{
            OrderCategoryController *orderVC = [[OrderCategoryController alloc] initWithOrderStates:OrderStatesSend];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self pushController:orderVC titleName:@"待收货"];
        };
        cell.tuihuanhuo = ^{//退换货一起
            OrderCategoryController *orderVC = [[OrderCategoryController alloc] initWithOrderStates:OrderStatesReturn];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self pushController:orderVC titleName:@"退换货"];
        };
        cell.weifahuo = ^{
            OrderCategoryController *orderVC = [[OrderCategoryController alloc] initWithOrderStates:OrderStatesPaid];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self pushController:orderVC titleName:@"待发货"];
        };
        cell.weipingjia = ^{
            OrderCategoryController *orderVC = [[OrderCategoryController alloc] initWithOrderStates:OrderStatesRecive];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self pushController:orderVC titleName:@"待评价"];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 2){
        UserCenterThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
//        if (_maindata) {
//            NSArray *titleArray = @[_maindata.integral, _maindata.coupon,_maindata.collect, _maindata.account];
            NSArray *titleArray = @[@"100", @"20",@"50", @"11"];
            for (int i=0; i<4; i++) {
                UILabel *label = [cell viewWithTag:101+i];
                label.text = titleArray[i];
                label.textColor = [UIColor redColor];
                label.textAlignment = NSTextAlignmentCenter;
//            }
        }
        cell.duoDouBtn = ^{
            DuodouViewController *duodouVC = [[DuodouViewController alloc] initWithDuoDouCount:_maindata.integral];
            duodouVC.hidesBottomBarWhenPushed = YES;
            [self pushController:duodouVC titleName:@"哆豆"];
        };
        cell.youhuijuanBtn = ^{
            YouHuiJuanViewController *youhuijuVC = [[YouHuiJuanViewController alloc] init];
            youhuijuVC.hidesBottomBarWhenPushed = YES;
            [self pushController:youhuijuVC titleName:@"优惠券"];
        };
        cell.shangpinAttentionBtn = ^{
            AttentionViewController *attentionVC = [[AttentionViewController alloc] init];
            attentionVC.hidesBottomBarWhenPushed = YES;
            [self pushController:attentionVC titleName:@"商品收藏"];
        };
        cell.walletBtn = ^{
            WalletViewController *walletVC = [[WalletViewController alloc] init];
            walletVC.hidesBottomBarWhenPushed = YES;
            [self pushController:walletVC titleName:@"我的钱包"];
        };
        cell.VIPBtn = ^{
            VIPViewController *vipVC = [[VIPViewController alloc] init];
            vipVC.hidesBottomBarWhenPushed = YES;
            [self pushController:vipVC titleName:@"我的会员"];
        };
        cell.historyBtn = ^{
            BrownRecordsController *historyVC = [[BrownRecordsController alloc] init];
            historyVC.hidesBottomBarWhenPushed = YES;
            [self pushController:historyVC titleName:@"浏览记录"];
        };
        cell.activityBtn = ^{
            ActivityViewController *activityVC = [[ActivityViewController alloc] init];
            activityVC.hidesBottomBarWhenPushed = YES;
            [self pushController:activityVC titleName:@"我的活动"];
        };
        cell.kefuBtn = ^{
            ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
            serviceVC.hidesBottomBarWhenPushed = YES;
            [self pushController:serviceVC titleName:@"联系客服"];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            static NSString *CommonTipsCellID = @"CommonTipsCellID";
            CommonTipsCell * cell = [tableView dequeueReusableCellWithIdentifier:CommonTipsCellID];
            if (cell == nil) {
                cell = [[CommonTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonTipsCellID];
            }
            cell.titleName.text = @"为你推荐";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *CommonRecommendForYouCellID = @"CommonRecommendForYouCellID";
            CommonRecommendForYouCell * cell = [tableView dequeueReusableCellWithIdentifier:CommonRecommendForYouCellID];
            if (cell == nil) {
                cell = [[CommonRecommendForYouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonRecommendForYouCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf = self;
            cell.recommendHandle = ^(NSInteger index){
                [weakSelf RecommendForYouProductItem:index];
            };
            return cell;
        }
    }
    
    
    UserCenterLastCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
    if (_recommendForYouProductsDataArray != nil && _recommendForYouProductsDataArray.count > 0) {
        [cell setupInfoWithDataArray:_recommendForYouProductsDataArray];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return FitHeight(30.0);
    }
    if (section == 2) {
        return 17.5*AdapterWidth();
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 180*AdapterHeight();
    }
    if ((indexPath.section == 1) && (indexPath.row == 0)){
        return 40*AdapterHeight();
        
    }
    if ((indexPath.section == 1)&&(indexPath.row == 1)){
        return 80*AdapterHeight();
    }
    if (indexPath.section == 2){
        return 160*AdapterHeight();
    }
    if (indexPath.section == 3) { // 为你推荐
        if (indexPath.row == 0) {
            return FitHeight(100.0);
        }
        if (indexPath.row == 1) {
            return FitHeight(310.0) * 4;
        }
    }
    return 300;
}

#pragma mark - progress

/**导航栏左侧返回按钮事件监听*/
- (void)progressLeftReturnButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**导航栏左侧签到按钮事件监听*/
- (void)progressLeftSignInButton
{
    SettingTableViewController *settingTableVC = [[SettingTableViewController alloc] init];
    settingTableVC.hidesBottomBarWhenPushed = YES;
    [self pushController:settingTableVC titleName:@"设置"];
}
/**导航栏右侧消息中心按钮事件监听*/
- (void)progressRightMessageCenterButton
{
    MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc] init];
    [self pushController:messageCenterVC titleName:@"消息中心"];
}

-(void)RecommendForYouProductItem:(NSInteger)index{
    SingleProductViewController *itemDetailVC = [[SingleProductViewController alloc]init];
    self.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:itemDetailVC animated:true];
}

/** 推送方式*/
- (void)pushController:(UIViewController *)VC titleName:(NSString *)titleName
{
    VC.title = titleName;
    VC.view.backgroundColor = LGBgColor;
    UIBarButtonItem *leftReturnButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回png"] style:UIBarButtonItemStylePlain target:self action:@selector(progressLeftReturnButton)];
    leftReturnButton.tintColor = [UIColor darkGrayColor];
    VC.navigationItem.leftBarButtonItem = leftReturnButton;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)loginSuccessRefreshUserinfo{
    [_bgTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
