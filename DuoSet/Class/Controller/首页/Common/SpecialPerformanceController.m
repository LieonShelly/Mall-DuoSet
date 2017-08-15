//
//  SpecialPerformanceController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SpecialPerformanceController.h"
#import "SpecialPerformanceWebView.h"
#import "ProductForListData.h"
#import "CommonRecommendForYouCell.h"
#import "SingleProductNewController.h"

@interface SpecialPerformanceController ()<UITableViewDelegate, UITableViewDataSource, webHeightDelegate>

@property(nonatomic,strong) AppSpecialIconData *item;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) SpecialPerformanceWebView *webView;
@property(nonatomic,strong) NSMutableArray *recommendArr;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@end


@implementation SpecialPerformanceController

#pragma mark - init & viewDidLoad & configRecommendDataClear & configUI
-(instancetype)initWithAppSpecialIconData:(AppSpecialIconData *)item{
    self = [super init];
    if (self) {
        _item = item;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _page = 0;
    _limit = 10;
    _lastRequsetCount = 0;
    [self configUI];
    [self configRecommendDataClear:true showHud:true];
}


//获取推荐商品
-(void)configRecommendDataClear:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"homepage/60/recommend?page=%ld&limit=%ld&sourceId=%@",_page,_limit,_item.item_id];
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
                    [_tableView reloadData];
                }
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

-(void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
//    __weak typeof(self) weakSelf = self;
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.mj_header = [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        _lastRequsetCount = 0;
        [self configRecommendDataClear:true showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configRecommendDataClear:false showHud:false];
    }];
    
    _webView = [[SpecialPerformanceWebView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 1000) andwebUrl:_item.url];
    _webView.backgroundColor = [UIColor mainColor];
    _tableView.tableHeaderView = _webView;
    _webView.delegate = self;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _recommendArr.count > 0 ? 1 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (FitHeight(600.0) + 3) * ((_recommendArr.count + 1) / 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

#pragma mark - 重置webView的高度
- (void)countWebViewHeight:(CGFloat)height{
    SpecialPerformanceWebView *headerView  = (SpecialPerformanceWebView *)_tableView.tableHeaderView;
    CGRect frame = headerView.frame;
    frame.size.height = height;
    headerView.frame = frame;
    
    [_tableView beginUpdates];
    [_tableView setTableHeaderView:headerView];
    [_tableView endUpdates];
}

-(void)countWebViewNavTitle:(NSString *)titleStr{
    self.title = titleStr;
}

-(void)tapWebViewImageProductNum:(NSString *)productNum{
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:productNum];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}


#pragma mark - 为你推荐
-(void)RecommendForYouProductItem:(NSInteger)index{
    ProductForListData *item = _recommendArr[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

@end
