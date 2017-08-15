//
//  VIPViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "VIPViewController.h"
#import "SingleProductNewController.h"
#import "CommonRecommendForYouCell.h"
#import "MyVipHeaderView.h"
#import "ProductForListData.h"
#import "CommonTitleImageCell.h"
#import "OrderDetailNextActionCell.h"
#import "VipScheduleCell.h"
#import "VipData.h"

@interface VIPViewController () <UITableViewDelegate, UITableViewDataSource>
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UILabel *navLable;
@property(nonatomic,strong) UIView *navline;
//View
@property(nonatomic,strong) MyVipHeaderView *headerView;
@property(nonatomic,strong) UITableView *tableView;
//Data
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSMutableArray *productArr;
@property(nonatomic,copy)   NSString *recommendIconStr;
@property(nonatomic,strong) VipData *vipData;

@end

@implementation VIPViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configNav];
    _productArr = [NSMutableArray array];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self configVipData];
    [self configDataClearArr:true showHud:true];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_white"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_leftBtn];
    
    _navLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _navLable.text = @"我的会员";
    _navLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _navLable.textColor = [UIColor whiteColor];
    _navLable.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:_navLable];
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
    [_navView addSubview:_navline];
    
    [self.view bringSubviewToFront:_navView];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, mainScreenWidth, mainScreenHeight + 20) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
     _headerView = [[MyVipHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(364.0))];
    _tableView.tableHeaderView = _headerView;
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page += 0;
        [self configDataClearArr:true showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configDataClearArr:false showHud:false];
    }];
    [self.view addSubview:_tableView];
}

-(void)configVipData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/vip" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//vipData
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _vipData = [VipData dataForDictionary:objDic];
                [_headerView setupInfoWithVipData:_vipData];
                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}


-(void)configDataClearArr:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"homepage/50/recommend?page=%ld&limit=%ld",_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if (clear) {
                _productArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"productResponses"] && [[objDic objectForKey:@"productResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *productArr = [objDic objectForKey:@"productResponses"];
                    _lastRequsetCount = productArr.count;
                    for (NSDictionary *d in productArr) {
                        ProductForListData *item = [ProductForListData dataForDictionary:d];
                        [_productArr addObject:item];
                    }
                }
                if ([objDic objectForKey:@"adResponse"] && [[objDic objectForKey:@"adResponse"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *adDic = [objDic objectForKey:@"adResponse"];
                    _recommendIconStr = [adDic objectForKey:@"titleIcon"] != nil ? [NSString stringWithFormat:@"%@%@",BaseImgUrl,[adDic objectForKey:@"titleIcon"]] : @"";
                }
            }
            [_tableView reloadData];
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//
        if (indexPath.row == 0) {//会员攻略
            static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID";
            OrderDetailNextActionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
            if (cell == nil) {
                cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
            }
            cell.tipsLable.textColor = [UIColor colorFromHex:0x222222];
            cell.tipsLable.text = @"我的会员";
            cell.rightSubLable.text = @"会员攻略";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *VipScheduleCellID = @"VipScheduleCellID";
            VipScheduleCell * cell = [_tableView dequeueReusableCellWithIdentifier:VipScheduleCellID];
            if (cell == nil) {
                cell = [[VipScheduleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:VipScheduleCellID];
            }
            if (_vipData) {
                [cell setupInfoWithVipData:_vipData];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section == 1) { // 为你推荐
        if (indexPath.row == 0) {
            static NSString *CommonTipsCellID = @"CommonTipsCellID";
            CommonTitleImageCell * cell = [tableView dequeueReusableCellWithIdentifier:CommonTipsCellID];
            if (cell == nil) {
                cell = [[CommonTitleImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonTipsCellID];
            }
            if (_recommendIconStr.length > 0) {
                [cell setupInfoWithTitleImageUrlStr:_recommendIconStr];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString *CommonRecommendForYouCellID = @"CommonRecommendForYouCellID";
            CommonRecommendForYouCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommonRecommendForYouCellID];
            if (cell == nil) {
                cell = [[CommonRecommendForYouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonRecommendForYouCellID];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            __weak typeof(self) weakSelf = self;
            [cell setupInfoWithRecommendListDataArr:_productArr];
            
            cell.recommendHandle = ^(NSInteger index){
                [weakSelf RecommendForYouProductItem:index];
            };
            return cell;
        }
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return indexPath.row == 0 ? FitHeight(90.0) : FitHeight(174.0);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return FitHeight(100.0);
        }
        if (indexPath.row == 1) {
            return (FitHeight(600.0) + 3) * ((_productArr.count + 1) / 2);
        }
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? FitHeight(20.0) : 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:true];
        WebPageController *webVc = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@static/vip-strategy/strategy.html",WebBaseUrl] NavTitle:@""];
        webVc.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:webVc animated:true];
    }
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
        _navLable.hidden = false;
        [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_white"] forState:UIControlStateNormal];
    }else{
        CGFloat alpha = 1 - ((65 - offset)/64);
        _navView.backgroundColor = [color colorWithAlphaComponent:alpha];
        _navLable.textColor = [textColor colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [lineColor colorWithAlphaComponent:alpha];
        _navLable.hidden = false;
        [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    }
}

-(void)progressLeftSignInButton{
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - 为你推荐 点击跳转
-(void)RecommendForYouProductItem:(NSInteger)index{
    ProductForListData *item = _productArr[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc] initWithProductId:item.productNumber];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

@end
