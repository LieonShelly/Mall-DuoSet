//
//  UserPiazzaDetailsController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserPiazzaDetailsController.h"
#import "UserPiazzaDetailsHeaderView.h"
#import "PiazzaPublishController.h"
#import "CustomCollectionViewLayout.h"
#import "PiazzaContentItemCell.h"
#import "PiazzaUserListController.h"
#import "PiazzaItemListController.h"
#import "UserPiazzaInfoData.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "PiazzaDetailsController.h"
//#import "PiazzaUserDetailsHeaderView.h"
#import "CommonDefeatedView.h"
#import "PiazzaDetailsCollectionViewCell.h"

typedef enum : NSUInteger {
    PiazzaDetailsTypeWithSelf,
    PiazzaDetailsTypeWithOther,
} PiazzaDetailsType;

@interface UserPiazzaDetailsController ()<UITableViewDataSource,UITableViewDelegate,FFCollectionLayoutDelegate>

@property(nonatomic,strong) NSString *userId;
@property(nonatomic,assign) PiazzaDetailsType userType;
//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) UILabel *navLable;
@property(nonatomic,strong) UIView *navline;
//View
@property(nonatomic,strong) UserPiazzaDetailsHeaderView *headerView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) CGFloat collectionViewHight;
//@property(nonatomic,strong) CommonDefeatedView *defeatedView;
//Data
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) UserPiazzaInfoData *userData;
@property(nonatomic,strong) NSTimer *likeTimer;

@end

@implementation UserPiazzaDetailsController

#pragma mark - initWithUserid & viewWillAppear & viewWillDisappear & viewDidLoad
-(instancetype)initWithUserid:(NSString *)userId{
    self = [super init];
    if (self) {
        _userId = userId;
        UserInfo *info = [Utils getUserInfo];
        if ([userId isEqualToString:info.userId]) {
            _userType = PiazzaDetailsTypeWithSelf;
        }else{
            _userType = PiazzaDetailsTypeWithOther;
        }
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 0;
    _limit = 10;
    _lastRequsetCount = 0;
    _collectionViewHight = 1000.0;
    [self configUI];
    [self configNav];
    [self configData:true showHud:true];
}

-(void)configData:(BOOL)clear showHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community/user?userId=%@&page=%ld&limit=10",_userId,_page] params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _userData.communityArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                if (_page == 0) {
                    _userData = [UserPiazzaInfoData dataForDictionary:objectDic];
                    if (_userType == PiazzaDetailsTypeWithOther) {
                        _rightBtn.selected = _userData.concerns;
                    }
                }else{
                    if ([objectDic objectForKey:@"community"] && [[objectDic objectForKey:@"community"] isKindOfClass:[NSArray class]]) {
                        NSMutableArray *arr = [objectDic objectForKey:@"community"];
                        NSMutableArray *items = _userData.communityArr;
                        for (NSDictionary *d in arr) {
                            PiazzaItemData *item = [PiazzaItemData dataForDictionary:d];
                            [items addObject:item];
                        }
                        _userData.communityArr = items;
                    }
                }
                _lastRequsetCount = _userData.communityArr.count;
                [_headerView setupInfoWithUserPiazzaInfoData:_userData];
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

#pragma mark - configNav
-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_white"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(progressLeftSignInButton) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_leftBtn];
    
    _navLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _navLable.text = @"社区";
    _navLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _navLable.textColor = [UIColor whiteColor];
    _navLable.textAlignment = NSTextAlignmentCenter;
    [_navView addSubview:_navLable];;
    
    _navline = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
    [_navView addSubview:_navline];
    
    if (_userType == PiazzaDetailsTypeWithSelf) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
        _rightBtn.titleLabel.font = CUSFONT(10);
        _rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, -15, 0);
        [_rightBtn setImage:[UIImage imageNamed:@"piazza_nav_uplaod_white"] forState:UIControlStateNormal];
        _rightBtn.contentMode = UIViewContentModeCenter;
        [_rightBtn addTarget:self action:@selector(uploadBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_rightBtn];
    }
    if (_userType == PiazzaDetailsTypeWithOther) {
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(176.0), 30, FitWith(132.0), 23)];
        _rightBtn.titleLabel.font = CUSNEwFONT(14);
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"piazza_nav_likebtn_bg"] forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"piazza_nav_likebtn_bg"] forState:UIControlStateSelected];
        [_rightBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"已关注" forState:UIControlStateSelected];
        [_rightBtn addTarget:self action:@selector(collectUserWithCollectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navView addSubview:_rightBtn];
    }
    
    [self.view bringSubviewToFront:_navView];
}

#pragma mark - configUI
-(void)configUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, mainScreenWidth, mainScreenHeight + 20) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self configData:false showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < 10) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configData:false showHud:false];
    }];
    [self.view addSubview:_tableView];
    
    _headerView = [[UserPiazzaDetailsHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(476.0))];
    __weak typeof(self) weakSelf = self;
    _headerView.headerBtnActionHandle = ^(NSInteger index) {
        [weakSelf handleHeaderViewBtnActionWithIndex:index];
    };
    _tableView.tableHeaderView = _headerView;
}

#pragma marrk - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_userData.communityArr.count > 0) {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *PiazzaDetailsCollectionViewCellID = @"PiazzaDetailsCollectionViewCellID";
    PiazzaDetailsCollectionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:PiazzaDetailsCollectionViewCellID];
    if (cell == nil) {
        cell = [[PiazzaDetailsCollectionViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaDetailsCollectionViewCellID];
    }
    cell.sizeBlock = ^(CGSize size) {
        _collectionViewHight = size.height;
        [_tableView reloadData];
    };
    cell.cellBlock = ^(NSInteger index) {
        [self handlePiazzaDataWithIndex:index];
    };
    cell.cellLikeBlock = ^(UIButton *btn, NSIndexPath *indexPath) {
        [self likeBtnActionHandleWithButton:btn andInexPath:indexPath];
    };
    [cell setupInfoWithPiazzaItemDataArr:_userData.communityArr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)handlePiazzaDataWithIndex:(NSInteger)index{
    PiazzaItemData *item = _userData.communityArr[index];
    if (_userType == PiazzaDetailsTypeWithSelf) {
        if (item.status == CommunityStautsNoCheck) {//自己的未审核
            [MQToast showToast:@"笔记审核中，暂不能操作" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
        if (item.status == CommunityStautsCheckFail) {//自己的未审核
            PiazzaPublishController *editVc = [[PiazzaPublishController alloc]initWithPiazzaItemId:item.communityId];
            editVc.hidesBottomBarWhenPushed = true;
            editVc.uploadSuccessHandle = ^{
                [self configData:true showHud:false];
            };
            [self.navigationController pushViewController:editVc animated:true];
            return;
        }
    }
    PiazzaDetailsController *detailsVC = [[PiazzaDetailsController alloc]initWithCommunityId:item.communityId];
    detailsVC.hidesBottomBarWhenPushed = true;
    detailsVC.likeHandle = ^(BOOL liked) {
        item.isLike = true;
        item.likeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:detailsVC animated:true];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _collectionViewHight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_userData.communityArr.count == 0) {
        return mainScreenHeight - FitHeight(476.0);
    }else{
        return 0.1;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_userData.communityArr.count > 0) {
        return [[UIView alloc]initWithFrame:CGRectZero];
    }
    CommonDefeatedView *defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth,mainScreenHeight - FitHeight(476.0)) andDefeatedImageName:@"defeated_no_details" messageName:@"暂时还没有笔记哦" backBlockBtnName:nil   backBlock:^{
    }];
    return defeatedView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIColor *color = [[UIColor whiteColor] colorWithAlphaComponent:1];
    UIColor *textColor = [[UIColor colorFromHex:0x222222] colorWithAlphaComponent:1];
    CGFloat offset = scrollView.contentOffset.y;
    UIColor *lineColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:1];
    if (offset <= 0) {
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        _navLable.textColor = [UIColor whiteColor];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:0];
        [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_white"] forState:UIControlStateNormal];
        if (_userType == PiazzaDetailsTypeWithSelf) {
            [_rightBtn setImage:[UIImage imageNamed:@"piazza_nav_uplaod_white"] forState:UIControlStateNormal];
        }
    }else{
        CGFloat alpha = 1 - ((100 - offset)/100);
        _navView.backgroundColor = [color colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [[UIColor colorFromHex:0xe4e4e4] colorWithAlphaComponent:alpha];
        _navLable.textColor = [textColor colorWithAlphaComponent:alpha];
        _navline.backgroundColor = [lineColor colorWithAlphaComponent:alpha];
        [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
        if (_userType == PiazzaDetailsTypeWithSelf) {
            [_rightBtn setImage:[UIImage imageNamed:@"piazza_nav_uplaod"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - buttonAction
-(void)progressLeftSignInButton{
    UserLikeBlock block = self.likeHandle;
    if (block) {
        block(_userData.concerns);
    }
    
    [self.navigationController popViewControllerAnimated:true];
}

-(void)uploadBtnAction{
    PiazzaPublishController *publishVC = [[PiazzaPublishController alloc]init];
    publishVC.hidesBottomBarWhenPushed = true;
    __weak typeof(self) weakSelf = self;
    publishVC.uploadSuccessHandle = ^{
        [weakSelf configData:true showHud:false];
    };
    [self.navigationController pushViewController:publishVC animated:true];
}

-(void)handleHeaderViewBtnActionWithIndex:(NSInteger)index{
    if (index == 0 || index == 1 ) {
        PiazzaUserListController *userListVC = [[PiazzaUserListController alloc]initWithUserId:_userId andRequestTypeStr:index == 0 ? @"1" : @"0"];
        userListVC.hidesBottomBarWhenPushed = true;
        __weak typeof(self) weakSelf = self;
        userListVC.likeHandle = ^(){
            weakSelf.page = 0;
            [weakSelf configData:true showHud:false];
        };
        [self.navigationController pushViewController:userListVC animated:true];
    }else{
        if (_userType == PiazzaDetailsTypeWithSelf) {
            PiazzaItemListController *userListVC = [[PiazzaItemListController alloc]initWithUserId:_userId andRequestTypeStr:index == 2 ? @"2" : @"3"];
            userListVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:userListVC animated:true];
        }else{
            [MQToast showToast:@"这是秘密哦！" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        }
    }
}

#pragma mark - 点赞
-(void)likeBtnActionHandleWithButton:(UIButton *)btn andInexPath:(NSIndexPath *)indexPath{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    PiazzaItemData *item = _userData.communityArr[indexPath.row];
    if (_userType == PiazzaDetailsTypeWithSelf) {
        if (item.status == CommunityStautsNoCheck) {
            if (btn.selected) {
                item.isLike = false;
                NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue - 1];
                item.likeCount = newLikeCount;
                [btn setTitle:newLikeCount forState:UIControlStateNormal];
                btn.selected = false;
            }else{
                item.isLike = true;
                NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
                item.likeCount = newLikeCount;
                [btn setTitle:newLikeCount forState:UIControlStateNormal];
                btn.selected = true;
            }
            [MQToast showToast:@"笔记审核中，暂不能操作" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
        if (item.status == CommunityStautsCheckFail) {
            if (btn.selected) {
                item.isLike = false;
                NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue - 1];
                item.likeCount = newLikeCount;
                [btn setTitle:newLikeCount forState:UIControlStateNormal];
                btn.selected = false;
            }else{
                item.isLike = true;
                NSString *newLikeCount = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
                item.likeCount = newLikeCount;
                [btn setTitle:newLikeCount forState:UIControlStateNormal];
                btn.selected = true;
            }
            [MQToast showToast:@"笔记审核失败，暂不能操作" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
            return;
        }
    }
    
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"community/%@/like",item.communityId];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithBool:btn.selected] forKey:@"likeCommunity"];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - 判断登录
-(BOOL)checkLogin{
    UserInfo *info = [Utils getUserInfo];
    return info.token.length > 0;
}

-(void)userlogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

#pragma mark - 关注该帖子作者 延迟操作
-(void)collectUserWithCollectBtn:(UIButton *)btn{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    UserInfo *info = [Utils getUserInfo];
    if ([_userId isEqualToString:info.userId]) {//是自己
        [MQToast showToast:@"自己不能关注自己哦~" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        return;
    }
    if (btn.selected) {
        btn.selected = false;
        NSString *newStr = [NSString stringWithFormat:@"%ld",_userData.beConcernsCount.integerValue - 1];
        _userData.beConcernsCount = newStr;
    }else{
        btn.selected = true;
        NSString *newStr = [NSString stringWithFormat:@"%ld",_userData.beConcernsCount.integerValue + 1];
        _userData.beConcernsCount = newStr;
    }
    _userData.concerns = btn.selected;
    [_headerView setupInfoWithUserPiazzaInfoData:_userData];
    if (_likeTimer == nil) {
        if (underiOS10) {
            [self delayTimeWithLikeBtn:btn];
            return;
        }
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithLikeBtn:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }else{
        if (underiOS10) {
            [self delayTimeWithLikeBtn:btn];
            return;
        }
        [_likeTimer invalidate];
        _likeTimer = nil;
        _likeTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:false block:^(NSTimer * _Nonnull timer) {
            [self delayTimeWithLikeBtn:btn];
            [_likeTimer invalidate];
            _likeTimer = nil;
        }];
    }
}

-(void)delayTimeWithLikeBtn:(UIButton *)btn{
    NSString *urlStr = @"";
    if (btn.selected) {
        urlStr = [NSString stringWithFormat:@"community/%@/concerns/add",_userId];
    }else{
        urlStr = [NSString stringWithFormat:@"community/%@/concerns/remove",_userId];
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            NSLog(@"操作成功");
        }
    } fail:^(NSError *error) {
        //
    }];
}

@end
