//
//  PiazzaCommentNewListController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaCommentNewListController.h"
#import "PiazzaCommentOriginalCell.h"
#import "PiazzaSubCommentCell.h"
#import "PiazzaInputView.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "PiazzaItemChildCommentData.h"
#import "UserPiazzaDetailsController.h"

typedef enum : NSUInteger {
    CommentReplyStatusWithOriginalComment,
    CommentReplyStatusWithChildComment
} CommentReplyStatus;

@interface PiazzaCommentNewListController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) PiazzaInputView *inputView;

@property(nonatomic,assign) CommentReplyStatus commentStatus;
@property(nonatomic,strong) PiazzaItemCommentData *mainCommentData;
@property(nonatomic,strong) NSMutableArray<PiazzaItemChildCommentData *> *dataArr;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,assign) NSInteger limit;
@property(nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) NSTimer *likeTimer;
@property(nonatomic,strong) NSIndexPath *curentIndexPath;

@end

@implementation PiazzaCommentNewListController

#pragma mark - viewWillAppear & viewWillDisappear & initWithPiazzaItemCommentData & viewDidLoad
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

-(instancetype)initWithPiazzaItemCommentData:(PiazzaItemCommentData *)mainCommentData{
    self = [super init];
    if (self) {
        _mainCommentData = mainCommentData;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self creatUI];
    _page = 0;
    _limit = 10;
    _dataArr = [NSMutableArray array];
    [self configData:true showHud:true];
}

#pragma mark - configData & creatUI
-(void)configData:(BOOL)clear showHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"community/%@/new-comment?commentId=%@&page=%ld&limit=10",_mainCommentData.communityId,_mainCommentData.communityCommentId,_page] params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _dataArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"commentResponses"] && [[objDic objectForKey:@"commentResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"commentResponses"];
                    if (arr.count > 0) {
                        if ([arr[0] isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *commentDic = arr[0];
                            if ([commentDic objectForKey:@"childResponses"] && [[commentDic objectForKey:@"childResponses"] isKindOfClass:[NSArray class]]) {
                                NSArray *childArr = [commentDic objectForKey:@"childResponses"];
                                _lastRequsetCount = childArr.count;
                                for (NSDictionary *d in childArr) {
                                    PiazzaItemChildCommentData *item = [PiazzaItemChildCommentData dataForDictionary:d];
                                    [_dataArr addObject:item];
                                }
                                [_tableView reloadData];
                            }
                        }
                    }
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

#pragma mark - UITableViewDataSource & UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *PiazzaCommentOriginalCellID = @"PiazzaCommentOriginalCellID";
        PiazzaCommentOriginalCell * cell = [_tableView dequeueReusableCellWithIdentifier:PiazzaCommentOriginalCellID];
        if (cell == nil) {
            cell = [[PiazzaCommentOriginalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaCommentOriginalCellID];
        }
        [cell setupInfoWithPiazzaItemCommentData:_mainCommentData];
        cell.replyHandle = ^{
            [self footViewTapAction];
        };
        cell.likeHandle = ^(UIButton *btn) {
            [self handleLikeCommentWithIndex:indexPath andButton:btn];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *PiazzaSubCommentCellCellID = @"PiazzaSubCommentCellCellID";
        PiazzaSubCommentCell * cell = [_tableView dequeueReusableCellWithIdentifier:PiazzaSubCommentCellCellID];
        if (cell == nil) {
            cell = [[PiazzaSubCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PiazzaSubCommentCellCellID];
        }
        PiazzaItemChildCommentData *item = _dataArr[indexPath.row];
        [cell setupInfoWithPiazzaItemChildCommentData:item];
        cell.replyHandle = ^{
            [self childCommentActionReplyWithIndexPath:indexPath];
        };
        cell.likeHandle = ^(UIButton *btn) {
            [self handleLikeCommentWithIndex:indexPath andButton:btn];
        };
        cell.userNameTapBlock = ^(NSString *userId) {
            [self gotoUserDetailsWithUserId:userId];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return _mainCommentData.noReplyCellHight;
    }else{
        PiazzaItemChildCommentData *item = _dataArr[indexPath.row];
        return item.cellHight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - footViewTapAction
-(void)footViewTapAction{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    _commentStatus = CommentReplyStatusWithOriginalComment;
    [self showCommentView];
}

#pragma mark - childCommentActionReply
-(void)childCommentActionReplyWithIndexPath:(NSIndexPath *)indexPath{
    _commentStatus = CommentReplyStatusWithChildComment;
    _curentIndexPath = indexPath;
    [self showCommentView];
}

-(void)showCommentView{
    if (_markView != nil) {
        _markView.hidden = false;
    }else{
        _markView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        _markView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenInputView)];
        [_markView addGestureRecognizer:tap];
        [self.view addSubview:_markView];
    }
    if (_inputView != nil) {
        [UIView animateWithDuration:0.25 animations:^{
            [_inputView.inputTexeView becomeFirstResponder];
            CGRect frame = _inputView.frame;
            frame.origin.y = mainScreenHeight - 258 - FitHeight(340.0);
            _inputView.frame = frame;
        } completion:nil];
    }else{
        __weak typeof(self) weakSelf = self;
        _inputView = [[PiazzaInputView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(340.0))];
        _inputView.title.text = @"回复";
//        _inputView.inputTexeView.placeholder = @"点赞的都是套路，评论才是真爱";
        _inputView.btnActionHandle = ^(NSInteger index){
            [weakSelf inptViewBtnActionWithIndex:index];
        };
        [self.view addSubview:_inputView];
        [UIView animateWithDuration:0.25 animations:^{
            [_inputView.inputTexeView becomeFirstResponder];
            CGRect frame = _inputView.frame;
            frame.origin.y = mainScreenHeight - 258 - FitHeight(340.0);
            _inputView.frame = frame;
        } completion:nil];
    }
}

-(void)inptViewBtnActionWithIndex:(NSInteger)index{
    if (index == 0) {
        [self hiddenInputView];
    }
    if (index == 1) {//提交评论
        if (_inputView.inputTexeView.text == 0) {
            [[UIApplication sharedApplication].keyWindow makeToast:@"请输入评论内容"];
        }
        NSString *urlStr = @"";
        urlStr = [NSString stringWithFormat:@"community/%@/comment",_mainCommentData.communityId];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:_inputView.inputTexeView.text forKey:@"content"];
        if (_curentIndexPath.section == 0) {//针对主评论回复
            [params setObject:_mainCommentData.communityCommentId forKey:@"communityCommentId"];
        }else{//针对子评论回复
            PiazzaItemChildCommentData *item = _dataArr[_curentIndexPath.row];
            [params setObject:item.objId forKey:@"communityCommentId"];
        }
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _inputView.inputTexeView.text = @"";
                [self hiddenInputView];
                _page = 0;
                [self configData:true showHud:false];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(void)hiddenInputView{
    _markView.hidden = true;
    [UIView animateWithDuration:0.25 animations:^{
        [_inputView.inputTexeView resignFirstResponder];
        CGRect frame = _inputView.frame;
        frame.origin.y = mainScreenHeight;
        _inputView.frame = frame;
    } completion:nil];
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

#pragma mark - 评论点赞
-(void)handleLikeCommentWithIndex:(NSIndexPath *)indexPath andButton:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = false;
        if (indexPath.section == 0) {
            NSString *newStr = [NSString stringWithFormat:@"%ld",_mainCommentData.likeCount.integerValue - 1];
            _mainCommentData.likeCount = newStr;
            _mainCommentData.liked = btn.selected;
        }else{
            PiazzaItemChildCommentData *item = _dataArr[indexPath.row];
            NSString *newStr = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue - 1];
            item.likeCount = newStr;
            item.liked = btn.selected;
        }
    }else{
        btn.selected = true;
        if (indexPath.section == 0) {
            NSString *newStr = [NSString stringWithFormat:@"%ld",_mainCommentData.likeCount.integerValue + 1];
            _mainCommentData.likeCount = newStr;
            _mainCommentData.liked = btn.selected;
        }else{
            PiazzaItemChildCommentData *item = _dataArr[indexPath.row];
            NSString *newStr = [NSString stringWithFormat:@"%ld",item.likeCount.integerValue + 1];
            item.likeCount = newStr;
            item.liked = btn.selected;
        }
    }
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
    NSString *commentId = @"";
    if (indexPath.section == 0) {
        commentId = _mainCommentData.communityCommentId;
    }else{
        PiazzaItemChildCommentData *item = _dataArr[indexPath.row];
        commentId = item.objId;
    }
    NSString *urlStr = [NSString stringWithFormat:@"community/comment/%@/like",commentId];
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
    if (indexPath.section == 0) {
        PiazzaCommentOriginalCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            [cell setupInfoWithPiazzaItemCommentData:_mainCommentData];
        }
    }else{
        PiazzaItemChildCommentData *item = _dataArr[indexPath.row];
        PiazzaSubCommentCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            [cell setupInfoWithPiazzaItemChildCommentData:item];
        }
    }
}

#pragma mark - 跳转到用户详情
-(void)gotoUserDetailsWithUserId:(NSString *)userId{
    UserPiazzaDetailsController *userDetailVC = [[UserPiazzaDetailsController alloc]initWithUserid:userId];
    userDetailVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:userDetailVC animated:true];
}

@end
