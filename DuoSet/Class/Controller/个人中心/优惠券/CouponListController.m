//
//  CouponListController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/30.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CouponListController.h"
#import "TodayRecommendSectionView.h"
#import "CouponsCell.h"


typedef enum : NSUInteger {
    CouponDataWithUnUse,
    CouponDataWithUsed,
    CouponDataWithTimeout
}CouponDataType;

@interface CouponListController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,assign) CouponDataType couponType;
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong) TodayRecommendSectionView *headerView;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic, copy) NSMutableArray *couponDataArray;

@end

@implementation CouponListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _couponType = CouponDataWithUnUse;
    self.title = @"优惠券";
    _couponDataArray = [NSMutableArray array];
    _limit = 10;
    [self configUI];
    [self configData:true];
    [self getCouponCount];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configData:false];
    }];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"未使用(0)",@"已使用(0)",@"已过期(0)", nil];
    _headerView = [[TodayRecommendSectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(100.0)) andBtnNameArr:arr];
    __weak typeof(self) weakSelf = self;
    _headerView.btnActionHandle = ^(NSInteger index){
        _page = 0;
        _lastRequsetCount = 0;
        _couponType = index;
        [weakSelf configData:true];
    };
    _tableView.tableHeaderView = _headerView;
}

-(void)getCouponCount{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/coupon/count" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"statusCount"] && [[objDic objectForKey:@"statusCount"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *countDic = [objDic objectForKey:@"statusCount"];
                    NSString *unUseCount = [countDic objectForKey:@"20"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[countDic objectForKey:@"20"]] : @"0";
                    if (unUseCount.integerValue > 99) {
                        unUseCount = @"99+";
                    }
                    NSString *useCount = [countDic objectForKey:@"20"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[countDic objectForKey:@"30"]] : @"0";
                    if (useCount.integerValue > 99) {
                        useCount = @"99+";
                    }
                    NSString *timeoutCount = [countDic objectForKey:@"20"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[countDic objectForKey:@"40"]] : @"0";
                    if (timeoutCount.integerValue > 99) {
                        timeoutCount = @"99+";
                    }
                    NSMutableArray *arr = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"未使用(%@)",unUseCount],[NSString stringWithFormat:@"已使用(%@)",useCount],[NSString stringWithFormat:@"已过期(%@)",timeoutCount], nil];
                    [_headerView resetSectionViewTitleNameWithNameArr:arr];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}


-(void)configData:(BOOL)clear{
    NSString *urlStr = @"";
    if (_couponType == CouponDataWithUnUse) {
        urlStr = [NSString stringWithFormat:@"user/coupon?page=%ld&limit=%ld&codeStatus=20",_page,_limit];
    }
    if (_couponType == CouponDataWithUsed) {
        urlStr = [NSString stringWithFormat:@"user/coupon?page=%ld&limit=%ld&codeStatus=30",_page,_limit];
    }
    if (_couponType == CouponDataWithTimeout) {
        urlStr = [NSString stringWithFormat:@"user/coupon?page=%ld&limit=%ld&codeStatus=40",_page,_limit];
    }
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _couponDataArray = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"couponCodeResponses"] && [[objDic objectForKey:@"couponCodeResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *couponArr = [objDic objectForKey:@"couponCodeResponses"];
                    _lastRequsetCount = couponArr.count;
                    for (NSDictionary *d in couponArr) {
                        CouponInfoData *item = [CouponInfoData dataForDictionary:d];
                        [_couponDataArray addObject:item];
                    }
                }
            }
            [self showDefeatedView:_couponDataArray.count == 0];
            [_tableView.mj_footer endRefreshing];
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        //
    }];
}

#pragma 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _couponDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//HaveGoodProductCell
    static NSString *CouponsCellID = @"CouponsCellID";
    CouponsCell * cell = [_tableView dequeueReusableCellWithIdentifier:CouponsCellID];
    if (cell == nil) {
        cell = [[CouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponsCellID];
    }
    CouponInfoData *item = _couponDataArray[indexPath.section];
    [cell setupListInfoWithCouponInfoData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(140.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return false;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteItem:indexPath];
    }
}

-(void)deleteItem:(NSIndexPath *)indexPath{
    
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64 + FitHeight(100.0), mainScreenWidth, mainScreenHeight - 64 - FitHeight(100.0)) andDefeatedImageName:@"defeated_no_order" messageName:@"你暂时还没有可用优惠券哦~" backBlockBtnName:nil backBlock:^{
                
            }];
            [self.view addSubview:_defeatedView];
            [self.view bringSubviewToFront:_defeatedView];
        }else{
            _defeatedView.hidden = false;
        }
    }else{
        _defeatedView.hidden = true;
    }
}

@end
