//
//  CommentListController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentListController.h"
#import "CommentCell.h"
#import "LoginViewController.h"
#import "CustomNavController.h"
#import "CommentListHeaderView.h"
#import "CommentHomeData.h"

@interface CommentListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,copy) NSString *num;
@property (nonatomic,strong) CommentListHeaderView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *commentArr;
@property (nonatomic,assign) NSInteger filter;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,assign) NSInteger limit;

@end

@implementation CommentListController

-(instancetype)initWithProductNum:(NSString *)num{
    self = [super init];
    if (self) {
        _num = num;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    self.title = @"评论";
    _commentArr = [NSMutableArray array];
    _filter = 0;
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    [self creatUI];
    [self configDataClearArr:true showHud:true];
}

-(void)configDataClearArr:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"product/%@/comment?limit=10&page=%ld&filter=%ld",_num,(long)_page,_filter];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _commentArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                CommentHomeData *data = [CommentHomeData dataForDictionary:objDic];
                NSArray *countArr = @[data.totalCount,data.highGrade,data.positiveGrade,data.badGrade,data.hasPic];
                [_headerView setCountLableContentWithCountArr:countArr];
                if ([objDic objectForKey:@"comments"] && [[objDic objectForKey:@"comments"] isKindOfClass:[NSArray class]]) {
                    NSArray *commentsArr = [objDic objectForKey:@"comments"];
                    _lastRequsetCount = commentsArr.count;
                    for (NSDictionary *d in commentsArr) {
                        CommentData *item = [CommentData dataForDictionary:d];
                        [_commentArr addObject:item];
                    }
                    [_tableView.mj_footer endRefreshing];
                    [_tableView.mj_header endRefreshing];
                    [_tableView reloadData];
                }
            }else{
                [_tableView.mj_footer endRefreshing];
                [_tableView.mj_header endRefreshing];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void) creatUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.tableFooterView = [UIView new];
    _headerView = [[CommentListHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(80.0))];
    __weak typeof(self) weakSelf = self;
    _tableView.tableHeaderView = _headerView;
    
    _headerView.btnActionHandle = ^(NSInteger index){
        [weakSelf choiceCommentStatusWithIndex:index];
    };
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        [self configDataClearArr:true showHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configDataClearArr:false showHud:false];
    }];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _commentArr == nil ? 0 : _commentArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentData *item = _commentArr[indexPath.section];
    NSString *CommentCellID = [NSString stringWithFormat:@"CommentCellID-%ld",(unsigned long)item.pics.count];
    CommentCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommentCellID];
    if (cell == nil) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCellID];
    }
    __weak typeof(self) weakSelf = self;
    cell.imgVTapActionHandle = ^(NSInteger index){
        [weakSelf ScanPictures:item.pics andIndex:index];
    };
    cell.lickBtnActionHandle = ^(UIButton *btn){
        if (![weakSelf checkLogin]) {
            [weakSelf userlogin];
            return;
        }
        NSString *urlStr = [NSString stringWithFormat:@"user/order/%@/comment/like",item.comment_id];
        [RequestManager requestWithMethod:POST WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                    CommentData *data = [CommentData dataForDictionary:objectDic];
                    item.isLike = data.isLike;
                    item.goodCount = data.goodCount;
                    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    };
    [cell setupInfoWithCommentData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentData *item = _commentArr[indexPath.section];
    return item.cellHight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - 图片放大
-(void)ScanPictures:(NSArray *)imgArr andIndex:(NSInteger)index{
    ScanPictureViewController *picVC = [[ScanPictureViewController alloc]initWithPhotosUrl:imgArr WithCurrentIndex:index];
    [self.navigationController presentViewController:picVC animated:true completion:nil];
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

-(void)choiceCommentStatusWithIndex:(NSInteger)index{
    _filter = index;
    _page = 0;
    [self configDataClearArr:true showHud:true];
}

@end
