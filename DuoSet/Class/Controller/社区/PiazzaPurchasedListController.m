//
//  PiazzaPurchasedListController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaPurchasedListController.h"
#import "PiazzaPurchasedCell.h"
#import "PiazzaPurchasedProduct.h"

@interface PiazzaPurchasedListController ()<UITableViewDataSource,UITableViewDelegate>
//View
@property(nonatomic,strong) UITableView *tableView;
//Data
@property(nonatomic,strong) NSMutableArray<PiazzaPurchasedProduct *> *dataArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;

@end

@implementation PiazzaPurchasedListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买过的商品";
    [self creatUI];
    _page = 0;
    _limit = 10;
    _dataArr = [NSMutableArray array];
    [self configData:true showHud:true];
}

-(void)configData:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"community/product?page=%ld&limit=10",_page];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _dataArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"product"] && [[objDic objectForKey:@"product"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"product"];
                    for (NSDictionary *d in arr) {
                        PiazzaPurchasedProduct *item = [PiazzaPurchasedProduct dataForDictionary:d];
                        [_dataArr addObject:item];
                    }
                    [_tableView reloadData];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight - 50) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf3f4f7];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configData:false showHud:false];
    }];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        _lastRequsetCount = 0;
        [self configData:true showHud:false];
    }];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *PiazzaPurchasedCellID = @"PiazzaPurchasedCellID";
    PiazzaPurchasedCell * cell = [_tableView dequeueReusableCellWithIdentifier:PiazzaPurchasedCellID];
    if (cell == nil) {
        cell = [[PiazzaPurchasedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaPurchasedCellID];
    }
    PiazzaPurchasedProduct *item = _dataArr[indexPath.row];
    [cell setupInfoWithPiazzaPurchasedProduct:item];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(150.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    PiazzaPurchasedProduct *item = _dataArr[indexPath.row];
    [self.navigationController popViewControllerAnimated:true];
    PurchasedProductsActionBlock block = _seletcedHandle;
    if (block) {
        block(item);
    }
}

@end
