//
//  DesigningController.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesigningController.h"
#import "DesigningCell.h"
#import "CommonTipsCell.h"
#import "DesigningHeaderView.h"
#import "DesignerListController.h"
#import "RegisterDesignerController.h"
#import "DesignerDetailsController.h"
#import "RegisterDesignerController.h"
#import "DesignerData.h"
#import "DesignerProductData.h"

#import "DesignerCheckingController.h"
#import "DesignerUploadController.h"

#import "LoginViewController.h"
#import "CustomNavController.h"


@interface DesigningController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) DesigningHeaderView *headerView;

@property (nonatomic,strong) NSMutableArray *designerArr;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property (nonatomic,strong) NSMutableArray *productArr;

@property(nonatomic,assign) DesignerStatus designerType;
@property(nonatomic,strong) DesignerData *myInfo;

@end

@implementation DesigningController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configDesignerDataShowHud:true];
}

- (void)viewDidLoad {
    self.title = @"设计馆";
    [super viewDidLoad];
    [self configUI];
    _page = 0;
    _lastRequsetCount = 0;
    _limit = 10;
    _productArr = [NSMutableArray array];
    if ([Utils getUserInfo].token) {
        [self getMyInfo];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSucessHandle) name:@"LoginSuccess" object:nil];
    [self configProductList:true showHud:true];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    _headerView = [[DesigningHeaderView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(676.0))];
    _tableView.tableHeaderView = _headerView;
    __weak typeof(self) weakSelf = self;
    _headerView.attentionBtnActionHandle = ^(UIButton *btn){
        [weakSelf topDesignerLikeWithBtn:btn];
    };
    
    _headerView.designerHandle = ^(NSInteger index){//设计师列表
        DesignerListController *deserVC = [[DesignerListController alloc]initWithDesignerIndex:index];
        deserVC.hidesBottomBarWhenPushed = true;
        [weakSelf.navigationController pushViewController:deserVC animated:true];
    };
    _headerView.designerChoiceHandle = ^(NSInteger index){//单个设计师详情
        if (index > _designerArr.count - 1) {
            return ;
        }
        DesignerData *item = weakSelf.designerArr[index];
        DesignerDetailsController *detailsVC = [[DesignerDetailsController alloc]initWithDesignerId:item.designer_id];
        detailsVC.hidesBottomBarWhenPushed = true;
        [weakSelf.navigationController pushViewController:detailsVC animated:true];
    };
    _headerView.topHandle = ^(NSInteger index){//0 认证  1 投稿
        [weakSelf topBtnActionWithIndex:index];
    };
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page += 0;
        [self configProductList:true showHud:false];
        [self configDesignerDataShowHud:false];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self configProductList:false showHud:false];
    }];
    [self.view addSubview:_tableView];
}

//获取本人是否是设计师
-(void)getMyInfo{
    [RequestManager requestWithMethod:GET WithUrlPath:@"designer/designer/my" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"status"]) {
                    NSString *str = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"status"]];
                    if (str.integerValue == -1) {
                        _designerType = DesignerStatusNoUpload;
                    }
                    if (str.integerValue == 0) {
                        _designerType = DesignerStatusChecking;
                    }
                    if (str.integerValue == 1) {
                        _designerType = DesignerStatusCheckSucceed;
                    }
                    if (str.integerValue == 2) {
                        _designerType = DesignerStatusCheckNoPass;
                    }
                }
                if ([objDic objectForKey:@"designer"] && [[objDic objectForKey:@"designer"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *desDic = [objDic objectForKey:@"designer"];
                    _myInfo = [DesignerData dataForDictionary:desDic];
                }
                if (_designerType != DesignerStatusNoUpload) {
                    [_headerView setupInfoWithDesignerStatus:DesignerStatusCheckSucceed andDesignerData:_myInfo];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configDesignerDataShowHud:(BOOL)showHud{
    [RequestManager requestWithMethod:GET WithUrlPath:@"designer/designer?page=0&limit=10" params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            _designerArr = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *dic in objectArr) {
                    DesignerData *item = [DesignerData dataForDictionary:dic];
                    [_designerArr addObject:item];
                }
                [_headerView setupInfoWithDesignerDataArr:_designerArr];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)configProductList:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"designer/works?page=%ld&lmiti=%ld",(long)_page,(long)_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _productArr = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objectArr = [responseDic objectForKey:@"object"];
                for (NSDictionary *d in objectArr) {
                    DesignerProductData *item = [DesignerProductData dataForDictionary:d];
                    [_productArr addObject:item];
                }
                [_tableView reloadData];
            }
        }
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}


#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 0 ? 1 : _productArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CommonTipsCellID = @"CommonTipsCellID";
        CommonTipsCell * cell = [tableView dequeueReusableCellWithIdentifier:CommonTipsCellID];
        if (cell == nil) {
            cell = [[CommonTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonTipsCellID];
        }
        cell.titleName.text = @"作品专展";
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *DesigningCellID = @"DesigningCellID";
        DesigningCell * cell = [tableView dequeueReusableCellWithIdentifier:DesigningCellID];
        if (cell == nil) {
            cell = [[DesigningCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DesigningCellID];
        }
        __weak typeof(self) weakSelf = self;
        DesignerProductData *item = _productArr[indexPath.row];
        [cell setupInfoWithDesignerProductData:item];
        cell.likeHandle = ^(UIButton *btn){
            [weakSelf collectWithButton:btn withIndexPath:indexPath];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
//        DesignerProductData *item = _productArr[indexPath.row];
//        return item.cellHight;
        return FitHeight(680.0);
    }
    return FitHeight(100.0) ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DesignerProductData *item = _productArr[indexPath.row];
    WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@designer/works/%@",BaseUrl,item.obj_id] NavTitle:@"" ShowRightBtn:true];
    webVC.hidesBottomBarWhenPushed = true;
    webVC.isFromDesignerDetails = true;
    webVC.designerProductData = item;
    [self.navigationController pushViewController:webVC animated:true];
}

-(void)topBtnActionWithIndex:(NSInteger)index{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    if (index == 0) {
        if (_designerType == DesignerStatusNoUpload) {//提交申请
            RegisterDesignerController *registrtVC = [[RegisterDesignerController alloc]init];
            registrtVC.hidesBottomBarWhenPushed = true;
            registrtVC.registerHandle = ^(){
                [self getMyInfo];
            };
            [self.navigationController pushViewController:registrtVC animated:true];
            return;
        }
        if (_designerType == DesignerStatusChecking) {//审核中
            DesignerCheckingController *registrtVC = [[DesignerCheckingController alloc]init];
            registrtVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:registrtVC animated:true];
            return;
        }
        if (_designerType == DesignerStatusCheckNoPass) {//驳回修改
            RegisterDesignerController *registrtVC = [[RegisterDesignerController alloc]init];
            registrtVC.registerHandle = ^(){
                [self getMyInfo];
            };
            registrtVC.isEdit = true;
            registrtVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:registrtVC animated:true];
            return;
        }
        if (_designerType == DesignerStatusCheckSucceed) {
            DesignerDetailsController *detailsVC = [[DesignerDetailsController alloc]initWithDesignerId:_myInfo.designer_id];
            detailsVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:detailsVC animated:true];
        }
    }
    if (index == 1) {
        if (_designerType == DesignerStatusCheckSucceed) {
            DesignerUploadController *upVC = [[DesignerUploadController alloc]init];
            upVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:upVC animated:true];
        }
        if (_designerType == DesignerStatusNoUpload) {//提交申请
            RegisterDesignerController *registrtVC = [[RegisterDesignerController alloc]init];
            registrtVC.hidesBottomBarWhenPushed = true;
            registrtVC.registerHandle = ^(){
                [self getMyInfo];
            };
            [self.navigationController pushViewController:registrtVC animated:true];
            return;
        }
        if (_designerType == DesignerStatusChecking) {//审核中
            DesignerCheckingController *registrtVC = [[DesignerCheckingController alloc]init];
            registrtVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:registrtVC animated:true];
            return;
        }
        if (_designerType == DesignerStatusCheckNoPass) {//驳回修改
            RegisterDesignerController *registrtVC = [[RegisterDesignerController alloc]init];
            registrtVC.registerHandle = ^(){
                [self getMyInfo];
            };
            registrtVC.isEdit = true;
            registrtVC.hidesBottomBarWhenPushed = true;
            [self.navigationController pushViewController:registrtVC animated:true];
            return;
        }
    }
}

-(BOOL)checkLogin{
    UserInfo *info = [Utils getUserInfo];
    return info.token.length > 0;
}

-(void)userlogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    CustomNavController *loginNav = [[CustomNavController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

-(void)topDesignerLikeWithBtn:(UIButton *)btn{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    DesignerData *item = _designerArr[btn.tag];
    if (item.follow) {//取消点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.designer_id forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/collectCancel" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.userInteractionEnabled = true;
                item.follow = false;
                [_headerView setupInfoWithDesignerDataArr:_designerArr];
            }
        } fail:^(NSError *error) {
            //
        }];
    }else{//点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.designer_id forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/collect" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.userInteractionEnabled = true;
                item.follow = true;
                [_headerView setupInfoWithDesignerDataArr:_designerArr];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(void)collectWithButton:(UIButton *)btn withIndexPath:(NSIndexPath *)indexPath{
    if (![self checkLogin]) {
        [self userlogin];
        return;
    }
    DesignerProductData *item = _productArr[indexPath.row];
    if (btn.selected) {//取消点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.obj_id forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/works/collectCancel" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.selected = false;
                btn.userInteractionEnabled = true;
                item.collect = false;
                if ([responseDic objectForKey:@"object"]){
                    NSString *str = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"object"]];
                    [btn setTitle:str forState:UIControlStateNormal];
                    item.collectCount = str;
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }else{//点赞
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.obj_id forKey:@"id"];
        btn.userInteractionEnabled = false;
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/works/collect" params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                btn.selected = true;
                btn.userInteractionEnabled = true;
                item.collect = true;
                if ([responseDic objectForKey:@"object"]){
                    NSString *str = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"object"]];
                    [btn setTitle:str forState:UIControlStateNormal];
                    item.collectCount = str;
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}
-(void)loginSucessHandle{
    [self getMyInfo];
}

@end
