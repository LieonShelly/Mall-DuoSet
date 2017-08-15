//
//  MustBuyListController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuyListController.h"
#import "MustBuyHeaderView.h"
#import "MustBuyCell.h"
#import "MustBuyRecommendData.h"
#import "MustBuyHomeData.h"


@interface MustBuyListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MustBuyHeaderView *headerView;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) MustBuyHomeData *homeData;
@property (nonatomic,strong) NSMutableArray *contentArr;

@end

@implementation MustBuyListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"必买清单";
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    _type = 0;
    _contentArr = [NSMutableArray array];
    [self configUI];
    [self configDataClearArr:true showHud:true];
}


-(void)configUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = false;
    _headerView = [[MustBuyHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(560))];
    __weak typeof(self) weakSelf = self;
    _headerView.bigViewHandle = ^(NSInteger index){
        [weakSelf headerViewBigViewTapWithIndex:index];
    };
    _headerView.smallViewHandle = ^(NSInteger index){
        [weakSelf headerViewSmallViewTapWithIndex:index];
    };
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

-(void)configDataClearArr:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    if (_type == 0) {
        urlStr = [NSString stringWithFormat:@"product/buy-list?page=%ld&limit=%ld",(long)_page,_limit];
    }else{
        urlStr = [NSString stringWithFormat:@"product/buy-list?page=%ld&limit=%ld&type=%ld",(long)_page,_limit,_type];
    }
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if (_type == 0) {
                    _homeData = [MustBuyHomeData dataForDictionary:objDic];
                    [_headerView setupInfoWithMustBuyHomeData:_homeData];
                }
                if ([objDic objectForKey:@"content"] && [[objDic objectForKey:@"content"] isKindOfClass:[NSArray class]]) {
                    NSArray *contentArr = [objDic objectForKey:@"content"];
                    _lastRequsetCount = contentArr.count;
                    if (clear) {
                        _contentArr = [NSMutableArray array];
                    }
                    for (NSDictionary *d in contentArr) {
                        MustBuyRecommendData *item = [MustBuyRecommendData dataForDictionary:d];
                        [_contentArr addObject:item];
                    }
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
    return _contentArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MustBuyCellID = @"MustBuyCellID";
    MustBuyCell * cell = [tableView dequeueReusableCellWithIdentifier:MustBuyCellID];
    if (cell == nil) {
        cell = [[MustBuyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MustBuyCellID];
    }
    MustBuyRecommendData *item = _contentArr[indexPath.section];
    [cell setupInfoWithMustBuyRecommendData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(560.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
       return FitHeight(20.0);
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MustBuyRecommendData *item = _contentArr[indexPath.section];
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@product/buy-list/%@",BaseUrl,item.list_id] NavTitle:@"" ShowRightBtn:true];
    webVC.hidesBottomBarWhenPushed = true;
    webVC.isFromMustBuy = true;
    webVC.mustBuyData = item;
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)ScanPictures:(NSArray *)imgArr andIndex:(NSInteger)index{
    ScanPictureViewController *picVC = [[ScanPictureViewController alloc]initWithPhotosUrl:imgArr WithCurrentIndex:index];
    [self presentViewController:picVC animated:true completion:nil];
}

-(void)headerViewBigViewTapWithIndex:(NSInteger)index{
    if (_homeData != nil && index < _homeData.recommend.count) {
        MustBuyRecommendData *data = _homeData.recommend[index];
        WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@product/buy-list/%@",BaseUrl,data.list_id] NavTitle:@""];
        webVC.shareSuccessHandle = ^{
            NSInteger count = data.shareCount.integerValue;
            count += 1;
            data.shareCount = [NSString stringWithFormat:@"%ld",(long)count];
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:index]] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        webVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:webVC animated:true];
    }
}

-(void)headerViewSmallViewTapWithIndex:(NSInteger)index{
    if (_homeData != nil && index < _homeData.buyListType.count) {
        MustBuyListTypeData *data = _homeData.buyListType[index];
        _type = data.type_id.integerValue;
        _page = 0;
        [self configDataClearArr:true showHud:false];
    }
}

@end
