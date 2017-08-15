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
#import "SingleProductViewController.h"

@interface TadayBargainPriceController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation TadayBargainPriceController

- (void)viewDidLoad {
    self.title = @"今日特价";
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_tableView];
    
    UIImageView *coverImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(300.0))];
    coverImgV.image = [UIImage imageNamed:@"替代2"];
    _tableView.tableHeaderView = coverImgV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *TodayBargainPriceCellID = @"TodayBargainPriceCellID";
    TodayBargainPriceCell * cell = [_tableView dequeueReusableCellWithIdentifier:TodayBargainPriceCellID];
    if (cell == nil) {
        cell = [[TodayBargainPriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TodayBargainPriceCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    cell.cellHandle = ^(NSInteger index){
        [weakSelf RecommendForYouProductItem:index];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(640.0) * 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(100.0);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSMutableArray *btnNameArr = [NSMutableArray arrayWithObjects:@"女装",@"男装",@"鞋包",@"美妆",@"其他", nil];
    TodayRecommendSectionView *view = [[TodayRecommendSectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(100.0)) andBtnNameArr:btnNameArr];
    view.btnActionHandle = ^(NSInteger index){
        NSLog(@"chieck section index - : %ld",index);
    };
    return view;
}

//单品详情
-(void)RecommendForYouProductItem:(NSInteger)index{
    SingleProductViewController *singleItemVC = [[SingleProductViewController alloc] init];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

@end
