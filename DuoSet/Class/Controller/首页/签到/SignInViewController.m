//
//  SignInViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "SignInViewController.h"
#import "SignView.h"
#import "SigninHeaderView.h"
#import "CommonTitleImageCell.h"
#import "CommonRecommendForYouCell.h"
#import "SingleProductNewController.h"
#import "CommonAdCell.h"
#import "SigninTextCell.h"
#import "SinginWindowView.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "ProductForListData.h"
#import "CommonTipsCell.h"
//签到
#import "UserSignData.h"
#import "SevenDaySignData.h"

@interface SignInViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UIView *navView;
@property (nonatomic,strong) UILabel *navLable;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIView *navline;
@property (nonatomic,strong) UIButton *rightBtn;
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIView *markView;
@property (nonatomic,strong) SinginWindowView *singinView;

@property (nonatomic,copy)   NSString *recommendIconStr;
@property (nonatomic,strong) NSMutableArray *recommendArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;

@property (nonatomic,strong) SigninHeaderView *headerView;
@property (nonatomic,strong) NSMutableArray *sevenDaySignDetails;
@property (nonatomic,strong) UserSignData *userSign;

@end

@implementation SignInViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签到";
    [self configUI];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    _recommendArr = [NSMutableArray array];
    [self getSignData];
    [self configRecommendDataClear:true showHud:true];
}

-(void)getSignData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/sign" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"sevenDaySignDetails"] && [[objDic objectForKey:@"sevenDaySignDetails"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"sevenDaySignDetails"];
                    _sevenDaySignDetails = [NSMutableArray array];
                    for (NSDictionary *d in arr) {
                        SevenDaySignData *item = [SevenDaySignData dataForDictionary:d];
                        [_sevenDaySignDetails addObject:item];
                    }
                }
                if ([objDic objectForKey:@"userSignResponse"] && [[objDic objectForKey:@"userSignResponse"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *userSign = [objDic objectForKey:@"userSignResponse"];
                    _userSign = [UserSignData dataForDictionary:userSign];
                    [_headerView setupinfoWithUserSignData:_userSign];
                }
                NSIndexSet *indexset = [NSIndexSet indexSetWithIndex:0];
                [_tableView reloadSections:indexset withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

//获取推荐商品
-(void)configRecommendDataClear:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"homepage/40/recommend?page=%ld&limit=%ld",_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if (clear) {
                _recommendArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"productResponses"] && [[objDic objectForKey:@"productResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *productArr = [objDic objectForKey:@"productResponses"];
                    _lastRequsetCount = productArr.count;
                    for (NSDictionary *d in productArr) {
                        ProductForListData *item = [ProductForListData dataForDictionary:d];
                        [_recommendArr addObject:item];
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

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    
     _headerView = [[SigninHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(216.0))];
    _tableView.tableHeaderView = _headerView;
    __weak typeof(self) weakSelf = self;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configRecommendDataClear:false showHud:false];
    }];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        _lastRequsetCount = 0;
        [self configRecommendDataClear:true showHud:false];
    }];
    _headerView.signinHandle = ^(UIButton *btn){
        [weakSelf signinBtnActionHandle:btn];
    };
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *SigninTextCellID = @"SigninTextCellID";
        SigninTextCell * cell = [_tableView dequeueReusableCellWithIdentifier:SigninTextCellID];
        if (cell == nil) {
            cell = [[SigninTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SigninTextCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_userSign) {
            [cell setupInfoWithSevenDaySignDatas:_sevenDaySignDetails andUserSignData:_userSign];
        }
        return cell;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *CommonTipsCellID = @"CommonTipsCellID";
            CommonTitleImageCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommonTipsCellID];
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
            [cell setupInfoWithRecommendListDataArr:_recommendArr];
            
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
        return FitHeight(450.0);
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return FitHeight(100.0);
        }
        if (indexPath.row == 1) {
            return (FitHeight(600.0) + 3) * ((_recommendArr.count + 1) / 2);
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? FitHeight(20.0) : 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)signinBtnActionHandle:(UIButton *)btn{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/sign/" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [self.view makeToast:@"签到成功"];
            btn.selected = true;
            [self getSignData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)showSinginView:(BOOL)show{
    if (show) {
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _markView.backgroundColor = [[UIColor colorFromHex:0x484848] colorWithAlphaComponent:0.45];
        [self.view addSubview:_markView];
        
        _markView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenMarkView)];
        [_markView addGestureRecognizer:tap];
        
        _singinView = [[SinginWindowView alloc]initWithFrame:CGRectMake(FitWith(60.0), FitHeight(190.0), mainScreenWidth - FitWith(120.0), FitHeight(670.0))];
        [_markView addSubview:_singinView];
        UITapGestureRecognizer *singinVieTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singinViewTap)];
        [_singinView addGestureRecognizer:singinVieTap];
    }else{
        _markView.hidden = true;
        [_markView removeFromSuperview];
        _markView = nil;
    }
}

-(void)hiddenMarkView{
    [self showSinginView:false];
}

-(void)singinViewTap{
    //什么都不用写，禁止事件往下传递
}

-(void)back{
    [self.navigationController popViewControllerAnimated:true];
}

//为你推荐
-(void)RecommendForYouProductItem:(NSInteger)index{
    ProductForListData *item = _recommendArr[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc] initWithProductId:item.productNumber];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
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
