//
//  FeedbackController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FeedbackController.h"
#import "OrderDetailNextActionCell.h"
#import "FeedbackUploadController.h"

@interface FeedbackController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titleNameArr;

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    _titleNameArr = @[@"功能建议",@"APP报错",@"订单问题",];
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
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *OrderDetailNextActionCellID = @"OrderDetailNextActionCellID2";
    OrderDetailNextActionCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderDetailNextActionCellID];
    if (cell == nil) {
        cell = [[OrderDetailNextActionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderDetailNextActionCellID];
    }
    cell.tipsLable.text = _titleNameArr[indexPath.row];
    cell.tipsLable.textColor = [UIColor colorFromHex:0x222222];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(100.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    FeedbackUploadController *uploadVc = [[FeedbackUploadController alloc]initWithFeedbackType:indexPath.row andTitleName:_titleNameArr[indexPath.row]];
    uploadVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:uploadVc animated:true];
}


@end
