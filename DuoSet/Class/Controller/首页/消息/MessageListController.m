//
//  MessageListController.m
//  DuoSet
//
//  Created by fanfans on 2017/2/27.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MessageListController.h"
#import "MessageListCell.h"
#import "SystemMessageModel.h"

@interface MessageListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messageArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,assign) MessageType type;
@property (nonatomic,copy) NSString *typeName;
@property (nonatomic,copy) NSString *typeId;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation MessageListController

-(instancetype)initWithMessageType:(MessageType)type andTypeName:(NSString *)typeName andTypeId:(NSString *)typeId{
    self = [super init];
    if (self) {
        _type = type;
        _typeName = typeName;
        _typeId = typeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _typeName;
    [self creatUI];
    _messageArr = [NSMutableArray array];
    _page = 0;
    _lastRequsetCount = 0;
    [self getMessageList:true showHud:true];
}

-(void)getMessageList:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"user/message/%@?limit=10&page=%ld",_typeId,(long)_page];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                if (clear) {
                    _messageArr = [NSMutableArray array];
                }
                _lastRequsetCount = objectArr.count;
                for (NSDictionary *d in objectArr) {
                    SystemMessageModel *item = [SystemMessageModel dataForDictionary:d];
                    [_messageArr addObject:item];
                }
                [_tableView reloadData];
            }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        if (_messageArr.count == 0) {
            [self showDefeatedView:true];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
}

- (void) creatUI{
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    
    UIButton *clearMessageButton = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    clearMessageButton.titleLabel.font = CUSFONT(13);
    [clearMessageButton setTitleColor:[UIColor colorFromHex:0x3333333] forState:UIControlStateNormal];
    [clearMessageButton setTitle:@"清空" forState:UIControlStateNormal];
    [clearMessageButton addTarget:self action:@selector(progressclearMessageButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:clearMessageButton];
    self.navigationItem.rightBarButtonItem = right;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 80;
    _tableView.tableFooterView = [UIView new];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self getMessageList:true showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < 10) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self getMessageList:false showHud:false];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _messageArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *MessageListCellID = @"MessageListCellID";
    MessageListCell * cell = [_tableView dequeueReusableCellWithIdentifier:MessageListCellID];
    if (cell == nil) {
        cell = [[MessageListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageListCellID];
    }
    SystemMessageModel *item = _messageArr[indexPath.section];
    [cell setupInfoWithSystemMessageModel:item];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemMessageModel *item = _messageArr[indexPath.section];
    return item.cellHight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteItem:indexPath];
    }
}

-(void)deleteItem:(NSIndexPath *)indexPath{
    SystemMessageModel *item = _messageArr[indexPath.row];
    NSString *urlStr = [NSString stringWithFormat:@"user/message/%@/%@?delete",_typeId,item.message_id];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [_messageArr removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)progressclearMessageButton{
    NSString *urlStr = [NSString stringWithFormat:@"user/message/%@?delete",_typeId];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [_messageArr removeAllObjects];
            [_tableView reloadData];
            [self showDefeatedView:true];
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_message" messageName:@"你当前还没有消息记录哦~" backBlockBtnName:nil backBlock:^{
                [self.navigationController popViewControllerAnimated:true];
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
