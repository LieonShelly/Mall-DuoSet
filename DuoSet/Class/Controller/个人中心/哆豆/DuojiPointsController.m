//
//  DuojiPointsController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DuojiPointsController.h"
#import "DuoPointHeaderView.h"
#import "DuoPointListCell.h"
#import "DuoDouData.h"

@interface DuojiPointsController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) DuoPointHeaderView *headerView;
@property (nonatomic, copy) NSMutableArray *pointArray;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;

@end

@implementation DuojiPointsController

#pragma mark - viewWillAppear & viewWillDisappear & viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的哆豆";
    [self creatUI];
    _page = 0;
    _limit = 10;
    _lastRequsetCount = 0;
    [self configData:true];
}

- (void)configData:(BOOL)clear{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"user/point?page=%ld&limit=%ld",_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _pointArray = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"pointCount"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"pointCount"]];
                    [_headerView setupPointCountWithString:str];
                }
                if ([objDic objectForKey:@"pointLogs"] && [[objDic objectForKey:@"pointLogs"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"pointLogs"];
                    _lastRequsetCount = arr.count;
                    for (NSDictionary *d in arr) {
                        DuoDouData *item = [DuoDouData dataForDictionary:d];
                        [_pointArray addObject:item];
                    }
                    [_tableView reloadData];
                }
            }
            [_tableView.mj_footer endRefreshing];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        //
    }];
}

- (void)creatUI{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(140.0), 20, FitWith(140.0), 44)];
    rightBtn.titleLabel.font = CUSFONT(13);
    [rightBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [rightBtn setTitle:@"哆豆说明" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(duoPointHelp) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
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
    _headerView = [[DuoPointHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(534))];
    _tableView.tableHeaderView = _headerView;
}

#pragma 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _pointArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *DuoPointListCellID = @"DuoPointListCellID";
    DuoPointListCell * cell = [tableView dequeueReusableCellWithIdentifier:DuoPointListCellID];
    if (cell == nil) {
        cell = [[DuoPointListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DuoPointListCellID];
    }
    DuoDouData *item = _pointArray[indexPath.row];
    [cell setupInfoWithDuoDouData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DuoDouData *item = _pointArray[indexPath.row];
    return item.cellHight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)duoPointHelp{
    WebPageController *webView = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@static/point-explain/index.html",WebBaseUrl] NavTitle:@""];
    webView.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:webView animated:true];
}

@end
