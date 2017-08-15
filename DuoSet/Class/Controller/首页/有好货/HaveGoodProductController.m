//
//  HaveGoodProductController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HaveGoodProductController.h"
#import "SingleProductNewController.h"
#import "HaveGoodProductCell.h"
#import "ProductForListData.h"

@interface HaveGoodProductController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *recommendArr;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;

@end

@implementation HaveGoodProductController

- (void)viewDidLoad {
    self.title = @"有好货";
    [super viewDidLoad];
    _recommendArr = [NSMutableArray array];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self configUI];
    [self configDataClearArr:true showHud:true];
}

-(void)configDataClearArr:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"homepage/10/recommend?page=%ld&limit=%ld",(long)_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"productResponses"] && [[objDic objectForKey:@"productResponses"] isKindOfClass:[NSArray class]]) {
                    if (clear) {
                        _recommendArr = [NSMutableArray array];
                    }
                    NSArray *productArr = [objDic objectForKey:@"productResponses"];
                    _lastRequsetCount = productArr.count;
                    for (NSDictionary *d in productArr) {
                        ProductForListData *item = [ProductForListData dataForDictionary:d];
                        [_recommendArr addObject:item];
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

- (void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_tableView];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _recommendArr == nil ? 0 : _recommendArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *HaveGoodProductCellID = @"HaveGoodProductCellID";
    HaveGoodProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:HaveGoodProductCellID];
    if (cell == nil) {
        cell = [[HaveGoodProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HaveGoodProductCellID];
    }
    ProductForListData *item = _recommendArr[indexPath.row];
    [cell setupInfoWithProductForListData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(320.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(20.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductForListData *item = _recommendArr[indexPath.row];
    SingleProductNewController *itemDetailsVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price];
    itemDetailsVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:itemDetailsVC animated:true];
}

@end
