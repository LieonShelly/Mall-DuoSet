//
//  TadayBargainPriceController.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TadayBargainPriceController.h"
#import "TodayBargainPriceCell.h"
#import "TodayRecommendSectionView.h"
#import "SingleProductNewController.h"
#import "ProductForListData.h"
#import "CommonRecommendForYouCell.h"
#import "TadayNewItemTypeData.h"
#import "CommonBannerView.h"
#import "SubjectDetailController.h"
#import "ScreenProductController.h"

@interface TadayBargainPriceController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) CommonBannerView *headerView;
@property(nonatomic,strong) TodayRecommendSectionView *sectionView;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;
@property(nonatomic,strong) NSMutableArray *recommendArr;

@property (nonatomic,copy) NSString *type;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,strong) TadayNewItemTypeData *typeData;

@end

@implementation TadayBargainPriceController

- (void)viewDidLoad {
    self.title = @"今日新品";
    [super viewDidLoad];
    [self configUI];
    _recommendArr = [NSMutableArray array];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self configType];
    [self configDataClearArr:true showHud:true];
}

-(void)configType{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/today_new/type" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {//
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                _typeData = [TadayNewItemTypeData dataForDictionary:objectDic];
                if (_typeData.todayNewTopBanner) {
                    if (_typeData.todayNewTopBanner.picture != nil) {
                        NSArray *imgArr = @[_typeData.todayNewTopBanner.picture];
                        [_headerView setupInfoWithImgVArr:imgArr];
                    }
                }
                if (_typeData.todayNewTypes.count > 0) {
                    TodayNewType *typeItem = _typeData.todayNewTypes[0];
                    _type = typeItem.typeId;
                    [self configDataClearArr:true showHud:true];
                }
            }
        }
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}

-(void)configDataClearArr:(BOOL)clear showHud:(BOOL)showHud{
    if (_type == nil) {
        return;
    }
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"product/today_new/%@?page=%ld&limit=%ld",_type,_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                _lastRequsetCount = objectArr.count;
                if (clear) {
                    _recommendArr = [NSMutableArray array];
                }
                for (NSDictionary *d in objectArr) {
                    ProductForListData *item = [ProductForListData dataForDictionary:d];
                    [_recommendArr addObject:item];
                }
                [_tableView reloadData];
                [self showDefeatedView:_recommendArr.count == 0];
            }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_tableView];
    
    _headerView = [[CommonBannerView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(300.0))];
    __weak typeof(self) weakSelf = self;
    _headerView.imgTapHandle = ^(NSInteger index){
        if (weakSelf.typeData.todayNewTopBanner) {
            CurrentFashionData *banner = weakSelf.typeData.todayNewTopBanner;
            if (banner.type == BannerProduct) {//跳转到商品
                SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:banner.typeValue];
                singleItemVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:singleItemVC animated:true];
                return ;
            }
            if (banner.type == BannerWeb) {//跳转到网站
                WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:banner.typeValue NavTitle:@""];
                webVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:webVC animated:true];
                return ;
            }
            if (banner.type == BannerSubObject) {//跳转到专题
                SubjectDetailController *subJectVC = [[SubjectDetailController alloc]initWithSubjectId:banner.typeValue];
                subJectVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:subJectVC animated:true];
                return ;
            }
            if (banner.type == BannerClsaaify) {
                ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andclassifyLevel:banner.classifyLevel andItemId:banner.typeValue];
                listVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:listVC animated:true];
                return ;
            }
        }
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
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _typeData == nil ? 0 : 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CommonRecommendForYouCellID = @"CommonRecommendForYouCellID";
    CommonRecommendForYouCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommonRecommendForYouCellID];
    if (cell == nil) {
        cell = [[CommonRecommendForYouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonRecommendForYouCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    [cell setupInfoWithProductForListDataArr:_recommendArr];
    
    cell.recommendHandle = ^(NSInteger index){
        [weakSelf RecommendForYouProductItem:index];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (FitHeight(600.0) + 3) * ((_recommendArr.count + 1) / 2);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(100.0);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_sectionView != nil) {
        return _sectionView;
    }
    NSMutableArray *btnNameArr = [NSMutableArray array];
    for (TodayNewType *type in _typeData.todayNewTypes) {
        [btnNameArr addObject:type.name];
        if (btnNameArr.count >= 5) {
            break;
        }
    }
    _sectionView = [[TodayRecommendSectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(100.0)) andBtnNameArr:btnNameArr];
    __weak typeof(self) weakSelf = self;
    _sectionView.btnActionHandle = ^(NSInteger index){
        _page = 0;
        _lastRequsetCount = 0;
        TodayNewType *typeItem = weakSelf.typeData.todayNewTypes[index];
        _type = typeItem.typeId;
        [weakSelf configDataClearArr:true showHud:false];
    };
    return _sectionView;
}

//为你推荐
-(void)RecommendForYouProductItem:(NSInteger)index{
    ProductForListData *item = _recommendArr[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.picture productTitle:item.productName productPrice:item.price];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            __weak typeof(self) weakSelf = self;
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, FitHeight(100) + 64 + FitHeight(300.0), mainScreenWidth, mainScreenHeight - 64 - FitHeight(100.0) - FitHeight(300.0)) andDefeatedImageName:@"defeated_no_find_product" messageName:@"找不到相关商品哦~" backBlockBtnName:nil backBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:true];
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
