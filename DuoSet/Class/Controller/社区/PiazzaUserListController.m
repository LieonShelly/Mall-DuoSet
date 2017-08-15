//
//  PiazzaUserListController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaUserListController.h"
#import "PiazzaUserCell.h"
#import "PiazzaFansUserInfo.h"
#import "UserPiazzaDetailsController.h"
#import "CommonDefeatedView.h"

@interface PiazzaUserListController ()<UITableViewDataSource,UITableViewDelegate>
//View
@property(nonatomic,strong) UITableView *tableView;
//Data
@property(nonatomic,copy) NSString *requestTypeStr;//0,获取用户的粉丝 1,获取用户关注的人
@property(nonatomic,copy) NSString *userId;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSTimer *likeTimer;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation PiazzaUserListController

-(instancetype)initWithUserId:(NSString *)userId andRequestTypeStr:(NSString *)requestTypeStr{
    self = [super init];
    if (self) {
        _requestTypeStr = requestTypeStr;
        _userId = userId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UserInfo *info = [Utils getUserInfo];
    if (_requestTypeStr.integerValue == 1) {
        if ([info.userId isEqualToString:_userId]) {
            self.title = @"我的关注";
        }else{
            self.title = @"Ta的关注";
        }
    }else{
        if ([info.userId isEqualToString:_userId]) {
            self.title = @"我的粉丝";
        }else{
            self.title = @"Ta的粉丝";
        }
    }
    [self creatUI];
    _page = 0;
    _limit = 10;
    _dataArr = [NSMutableArray array];
    [self configData:true showHud:true];
}

-(void)configData:(BOOL)clear showHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community/concerns?userId=%@&page=%ld&limit=10&type=%@",_userId,_page,_requestTypeStr] params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _dataArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"concerns"] && [[objDic objectForKey:@"concerns"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"concerns"];
                    _lastRequsetCount = arr.count;
                    for (NSDictionary *d in arr) {
                        PiazzaFansUserInfo *item = [PiazzaFansUserInfo dataForDictionary:d];
                        [_dataArr addObject:item];
                    }
                    if (_dataArr.count == 0) {
                        UserInfo *info = [Utils getUserInfo];
                        BOOL isSelf = [info.userId isEqualToString:_userId];
                        [self showDefeatedView:true andRequestTypeStr:_requestTypeStr isSelf:isSelf];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *PiazzaUserCellID = @"PiazzaUserCellID";
    PiazzaUserCell * cell = [_tableView dequeueReusableCellWithIdentifier:PiazzaUserCellID];
    if (cell == nil) {
        cell = [[PiazzaUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaUserCellID];
    }
    PiazzaFansUserInfo *item = _dataArr[indexPath.row];
    cell.rightBtn.tag = indexPath.row;
    [cell setupInfoWithPiazzaFansUserInfo:item];
    cell.btnActionHandle = ^(UIButton *btn) {
        [self concernsUserWithBtn:btn];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(112.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PiazzaFansUserInfo *item = _dataArr[indexPath.row];
    UserPiazzaDetailsController *userDetailsVC = [[UserPiazzaDetailsController alloc]initWithUserid:item.userId];
    userDetailsVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:userDetailsVC animated:true];
}

#pragma mark - 关注该帖子作者 延迟操作
-(void)concernsUserWithBtn:(UIButton *)btn{
    PiazzaFansUserInfo *item = _dataArr[btn.tag];
    UserInfo *info = [Utils getUserInfo];
    if ([item.userId isEqualToString:info.userId]) {//是自己
        [MQToast showToast:@"自己不能关注自己哦~" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    [self delayTimeWithLikeBtn:btn];
}

-(void)delayTimeWithLikeBtn:(UIButton *)btn{
    PiazzaFansUserInfo *item = _dataArr[btn.tag];
    NSString *urlStr = @"";
    if (!btn.selected) {
        urlStr = [NSString stringWithFormat:@"community/%@/concerns/add",item.userId];
    }else{
        urlStr = [NSString stringWithFormat:@"community/%@/concerns/remove",item.userId];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
            btn.selected = !btn.selected;
            btn.layer.borderColor = btn.selected ? [UIColor colorFromHex:0x808080].CGColor : [UIColor mainColor].CGColor ;
            LikeCollcationBLock block = _likeHandle;
            if (block) {
                block();
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 展示缺省页
-(void)showDefeatedView:(BOOL)show andRequestTypeStr:(NSString *)requestTypeStr isSelf:(BOOL)iseSelf{
    if (show) {
        if (_defeatedView == nil) {
            NSString *message = @"";
            if (requestTypeStr.integerValue == 0) {
                if (iseSelf) {
                    message = @"去发布文章赢得粉丝吧";
                }else{
                    message = @"ta还没有关注的人呢";
                }
            }else{
                if (iseSelf) {
                    message = @"您还没有关注的人呢";
                }else{
                    message = @"ta还没有粉丝呢";
                }
            }
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_frend" messageName:message backBlockBtnName:nil   backBlock:^{
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
