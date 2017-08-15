//
//  BrownRecordsController.m
//  BrownRecords
//
//  Created by issuser on 16/12/20.
//  Copyright © 2016年 xiaodi. All rights reserved.
//

#import "BrownRecordsController.h"
#import "SingleProductNewController.h"
#import "HistoryModel.h"
#import "AttentionProductCell.h"
#import "BrownRecordsFootView.h"

@interface BrownRecordsController ()<UITableViewDelegate,UITableViewDataSource>

//nav
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightEditBtn;
@property(nonatomic,strong) UIButton *rightClearBtn;
@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) BrownRecordsFootView *bottomView;
@property(nonatomic,strong) NSMutableArray *historyDataArray;
@property(nonatomic,assign) BOOL editStatus;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation BrownRecordsController

#pragma mark - viewWillAppear & viewWillDisappear & viewDidLoad
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
    [self configUI];
    [self configNav];
    _page = 0;
    _limit = 10;
    _historyDataArray = [NSMutableArray array];
    [self getHistoryData:true];
}

-(void)configUI{
    UIButton *rightMessageCenterButton = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [rightMessageCenterButton setImage:[UIImage imageNamed:@"消息png"] forState:UIControlStateNormal];
    [rightMessageCenterButton addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:rightMessageCenterButton];
    self.navigationItem.rightBarButtonItem = left;
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, mainScreenWidth, mainScreenHeight - 44) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self getHistoryData:false];
    }];
    [self.view addSubview:_tableView];
}

-(void)configNav{
    _navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 64)];
    _navView.backgroundColor = [UIColor colorFromHex:0xfafafa];
    [self.view addSubview:_navView];
    
    _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    [_leftBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(leftItemHandle) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.contentMode = UIViewContentModeCenter;
    [_navView addSubview:_leftBtn];
    
    _rightClearBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 88 - FitWith(20.0), 20, 44, 44)];
    _rightClearBtn.titleLabel.font = CUSFONT(13);
    [_rightClearBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [_rightClearBtn setTitle:@"清空" forState:UIControlStateNormal];
    [_rightClearBtn addTarget:self action:@selector(rightClearHandle) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightClearBtn];
    
    _rightEditBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44 - FitWith(20.0),20,44,44)];
    _rightEditBtn.titleLabel.font = CUSFONT(13);
    [_rightEditBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
    [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightEditBtn addTarget:self action:@selector(rightEditHandle) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_rightEditBtn];
    
    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, mainScreenWidth - 88, 44)];
    _titleLable.textAlignment = NSTextAlignmentCenter;
    _titleLable.textColor = [UIColor blackColor];
    _titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _titleLable.text = @"浏览记录";
    [_navView addSubview:_titleLable];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIColor colorFromHex:0xBABABA];
    [_navView addSubview:line];
}

#pragma mark - Nav 编辑按钮操作 & 消息按钮

-(void)leftItemHandle{
    [self.navigationController popViewControllerAnimated:true];
}

-(void)rightEditHandle{
    if (_historyDataArray.count == 0) {
        return;
    }
    _editStatus = !_editStatus;
    [self changeEditModle:_editStatus];
}

-(void)changeEditModle:(BOOL)editStatus{
    __weak typeof(self) weakSelf = self;
    if (editStatus) {
        _tableView.tintColor = [UIColor mainColor];
        [_tableView setEditing:true animated:true];
        [_rightEditBtn setTitle:@"完成" forState:UIControlStateNormal];
        _tableView.frame = CGRectMake(0, 44, mainScreenWidth, mainScreenHeight - 44 - FitHeight(100.0));
        if (_bottomView != nil) {
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame  = _bottomView.frame;
                frame.origin.y = mainScreenHeight - FitHeight(100.0);
                _bottomView.frame = frame;
                _bottomView.allSelectedBtn.selected = false;
            } completion:nil];
            _tableView.frame = CGRectMake(0, 44, mainScreenWidth, mainScreenHeight - 44 - FitHeight(100.0));
        }else{
            _bottomView = [[BrownRecordsFootView alloc]initWithFrame:CGRectMake(0, mainScreenHeight, mainScreenWidth, FitHeight(100.0))];
            _bottomView.buttonActionHandle =^(UIButton *btn){
                if (btn.tag == 0) {
                    btn.selected = !btn.selected;
                    for (int i = 0; i < _historyDataArray.count; i++) {
                        ProductListData *item = weakSelf.historyDataArray[i];
                        if (btn.selected) {
                            [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:true scrollPosition:UITableViewScrollPositionTop];
                            item.isSeletced = true;
                        }else{
                            [weakSelf.tableView deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO];
                            item.isSeletced = false;
                        }
                    }
                }else{
                    [weakSelf deletedItem];
                }
            };
            [self.view addSubview:_bottomView];
            [UIView animateWithDuration:0.25 animations:^{
                CGRect frame  = _bottomView.frame;
                frame.origin.y = mainScreenHeight - FitHeight(100.0);
                _bottomView.frame = frame;
            } completion:nil];
        }
    }else{
        [_tableView setEditing:false animated:true];
        _tableView.frame = CGRectMake(0, 44, mainScreenWidth, mainScreenHeight - 44);
        [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame  = _bottomView.frame;
            frame.origin.y = mainScreenHeight;
            _bottomView.frame = frame;
        } completion:nil];
    }
}

-(void)deletedItem{
    NSMutableArray *numArr = [NSMutableArray array];
    for (ProductListData *item in _historyDataArray) {
        if (item.isSeletced) {
            [numArr addObject:item.productNumber];
        }
    }
    if (numArr.count > 0) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:numArr forKey:@"productNumbers"];
        [params setObject:[NSNumber numberWithInteger:1] forKey:@"removeType"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"product/seelog" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [self changeEditModle:false];
                _page = 0;
                [self getHistoryData:true];
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}


-(void)rightClearHandle{
    if (_historyDataArray.count == 0) {
        return;
    }
    [RequestManager showAlertFrom:self title:@"" mesaage:@"确定清除所有浏览记录吗？" doneActionTitle:@"确定" handle:^{
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:[NSNumber numberWithInteger:0] forKey:@"removeType"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"product/seelog" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                _editStatus = false;
                [_rightEditBtn setTitle:@"编辑" forState:UIControlStateNormal];
                _historyDataArray = [NSMutableArray array];
                [_tableView reloadData];
                [self showDefeatedView:true];
            }
        } fail:^(NSError *error) {
            ///
        }];
    }];
}


- (void)getHistoryData:(BOOL)clear{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"product/seelog?page=%ld&limit=%ld",_page,_limit];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _historyDataArray = [NSMutableArray array];
            }
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                NSArray *objArr = [responseDic objectForKey:@"object"];
                _lastRequsetCount = objArr.count;
                for (NSDictionary *d in objArr) {
                    ProductListData *item = [ProductListData dataForDictionary:d];
                    if (_editStatus) {
                        item.isSeletced = true;
                    }
                    [_historyDataArray addObject:item];
                }
            }
            [_tableView.mj_footer endRefreshing];
            [_tableView reloadData];
            if (_editStatus) {
                for (int i = 0; i < _historyDataArray.count; i++) {
                    ProductListData *item = _historyDataArray[i];
                    if (item.isSeletced) {
                        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:true scrollPosition:UITableViewScrollPositionTop];
                    }
                }
            }
            if (_historyDataArray.count == 0) {
                [self showDefeatedView:true];
            }
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        //
    }];
}

- (void)rightItemAction {
    _tableView.tintColor = [UIColor mainColor];
//    [_tableView setEditing:!_isEdit animated:true];
//    _isEdit = !_isEdit;
}

- (UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_editStatus) {
        ProductListData *item = _historyDataArray[indexPath.row];
        item.isSeletced = !item.isSeletced;
        _bottomView.allSelectedBtn.selected = [self checkAllSeletced];
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    ProductListData *item = _historyDataArray[indexPath.row];
    SingleProductNewController *itemDetailVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price];
    [self.navigationController pushViewController:itemDetailVC animated:true];
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_editStatus) {
        ProductListData *item = _historyDataArray[indexPath.row];
        item.isSeletced = !item.isSeletced;
        _bottomView.allSelectedBtn.selected = [self checkAllSeletced];
        return;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _historyDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *AttentionProductCellID = @"AttentionProductCellID";
    AttentionProductCell * cell = [tableView dequeueReusableCellWithIdentifier:AttentionProductCellID];
    if (cell == nil) {
        cell = [[AttentionProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AttentionProductCellID];
    }
    ProductListData *item = _historyDataArray[indexPath.row];
    [cell setupInfoWithProductListData:item];
    cell.btnActionHandle = ^(UIButton *btn){
        ProductListData *item = _historyDataArray[indexPath.row];
        SingleProductNewController *itemDetailVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price];
        itemDetailVC.autoAddtoShopCart = true;
        [self.navigationController pushViewController:itemDetailVC animated:true];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(210.0);
}

-(BOOL)checkAllSeletced{
    for (ProductListData *item in _historyDataArray) {
        if (!item.isSeletced) {
            return false;
        }
    }
    return true;
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_net" messageName:@"您暂时还没有浏览记录哦~" backBlockBtnName:nil backBlock:^{
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
