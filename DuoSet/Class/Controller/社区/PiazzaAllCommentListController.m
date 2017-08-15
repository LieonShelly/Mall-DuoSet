//
//  PiazzaAllCommentListController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaAllCommentListController.h"
#import "PiazzaDetailsCommentCell.h"
#import "PiazzaItemCommentData.h"
#import "PiazzaCommentNewListController.h"

@interface PiazzaAllCommentListController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)   NSString *communityId;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSMutableArray<PiazzaItemCommentData *> *dataArr;
@property (nonatomic,strong) NSTimer *likeTimer;

@end

@implementation PiazzaAllCommentListController

#pragma mark - viewWillAppear & viewWillDisappear & init & viewDidLoad

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = false;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = true;
}

-(instancetype)initWithCommunityId:(NSString *)communityId{
    self = [super init];
    if (self) {
        _communityId = communityId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评论";
    _page = 0;
    _limit = 10;
    _dataArr = [NSMutableArray array];
    [self creatUI];
    [self configData:true showHud:true];
}

#pragma mark - configData & creatUI
-(void)configData:(BOOL)clear showHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community/%@/new-comment?page=%ld&limit=10",_communityId,(long)_page] params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _dataArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"commentResponses"] && [[objDic objectForKey:@"commentResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"commentResponses"];
                    _lastRequsetCount = arr.count;
                    for (NSDictionary *d in arr) {
                        PiazzaItemCommentData *item = [PiazzaItemCommentData dataForDictionary:d];
                        [_dataArr addObject:item];
                    }
                }
                [_tableView reloadData];
            }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    }];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
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

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *PiazzaDetailsCommentCellID = @"PiazzaDetailsCommentCellID";
    PiazzaDetailsCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaDetailsCommentCellID];
    if (cell == nil) {
        cell = [[PiazzaDetailsCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaDetailsCommentCellID];
    }
    PiazzaItemCommentData *item = _dataArr[indexPath.row];
    [cell setUpInfoWithPiazzaItemCommentData:item];
    cell.replyBtnHandle = ^{
        [self replyCommentWithIndex:indexPath.row];
    };
    cell.likeBtnHandle = ^(UIButton *btn) {
        [self handleLikeCommentWithIndex:indexPath andButton:btn];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemCommentData *item = _dataArr[indexPath.row];
    return item.cellHight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 回复单条评论
-(void)replyCommentWithIndex:(NSInteger)index{
    PiazzaItemCommentData *item = _dataArr[index];
    PiazzaCommentNewListController *listVc = [[PiazzaCommentNewListController alloc]initWithPiazzaItemCommentData:item];
    listVc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:listVc animated:true];
}

#pragma mark - 帖子评论点赞
-(void)handleLikeCommentWithIndex:(NSIndexPath *)indexPath andButton:(UIButton *)btn{
    PiazzaItemCommentData *item = _dataArr[indexPath.row];
    if (btn.selected) {
        btn.selected = false;
        NSString *newStr = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue - 1];
        item.likeCount = newStr;
    }else{
        btn.selected = true;
        NSString *newStr = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
        item.likeCount = newStr;
    }
    item.liked = btn.selected;
    [self reloadCellWithIndexPath:indexPath];
    if (_likeTimer == nil) {
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithHandleLikeThisCommentWithIndexPath:indexPath andButton:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }else{
        [_likeTimer invalidate];
        _likeTimer = nil;
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithHandleLikeThisCommentWithIndexPath:indexPath andButton:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }
}

-(void)delayTimeWithHandleLikeThisCommentWithIndexPath:(NSIndexPath *)indexPath andButton:(UIButton *)btn{
    PiazzaItemCommentData *item = _dataArr[indexPath.row];
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/comment/%@/like",item.communityCommentId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:btn.selected] forKey:@"likeComment"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

//刷新cell
-(void)reloadCellWithIndexPath:(NSIndexPath *)indexPath{
    PiazzaItemCommentData *item = _dataArr[indexPath.row];
    PiazzaDetailsCommentCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        [cell setUpInfoWithPiazzaItemCommentData:item];
    }
}

@end
