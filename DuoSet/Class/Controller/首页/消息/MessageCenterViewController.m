//
//  MessageCenterViewController.m
//  DuoSet
//
//  Created by Seven-Augus on 2016/11/23.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterCell.h"
#import "MessageListController.h"
#import "MessageCenterData.h"

@interface MessageCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messageArr;

@end

@implementation MessageCenterViewController

-(void)viewWillAppear:(BOOL)animated{
    [self getMessageData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)getMessageData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/message" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                _messageArr = [NSMutableArray array];
                NSArray *objArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objArr) {
                    MessageCenterData *item = [MessageCenterData dataForDictionary:d];
                    [_messageArr addObject:item];
                }
                [_tableView reloadData];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void) creatUI{
    self.title = @"消息中心";
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
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
    return _messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MessageCenterCellID = @"MessageCenterCellID";
    MessageCenterCell * cell = [_tableView dequeueReusableCellWithIdentifier:MessageCenterCellID];
    if (cell == nil) {
        cell = [[MessageCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageCenterCellID];
    }
    MessageCenterData *item = _messageArr[indexPath.row];
    [cell setupInfoWithMessageCenterData:item];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(140.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(20.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    MessageCenterData *item = _messageArr[indexPath.row];
    MessageListController *messageListVC = [[MessageListController alloc]initWithMessageType:item.messageType andTypeName:item.typeName andTypeId:item.type_id];
    messageListVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:messageListVC animated:true];
}

@end
