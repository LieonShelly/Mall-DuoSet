//
//  GlobalVenueListController.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalVenueListController.h"
#import "CommonRecommendForYouCell.h"
#import "SingleProductViewController.h"

@interface GlobalVenueListController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation GlobalVenueListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时尚狂欢节特惠，国外品牌大选购";
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
    
    UIImageView *coverImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(450.0))];
    coverImgV.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = coverImgV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
    cell.recommendHandle = ^(NSInteger index){
        [weakSelf RecommendForYouProductItem:index];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(310.0) * 4;
}

//为你推荐
-(void)RecommendForYouProductItem:(NSInteger)index{
    SingleProductViewController *singleItemVC = [[SingleProductViewController alloc] init];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

@end
