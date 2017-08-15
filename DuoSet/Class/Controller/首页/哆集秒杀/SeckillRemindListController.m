//
//  SeckillRemindListController.m
//  DuoSet
//
//  Created by fanfans on 2017/5/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillRemindListController.h"
#import "SeckillProductCell.h"
#import "RemindRobProductData.h"
#import "FFCalendarReminderTool.h"
#import "SingleProductNewController.h"

@interface SeckillRemindListController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;

@end

@implementation SeckillRemindListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的提醒";
    _page = 0;
    _limit = 10;
    _lastRequsetCount = 0;
    [self creatUI];
    [self getActivityData:true showHud:true];
}

- (void)getActivityData:(BOOL)clear showHud:(BOOL)showHud{
    NSString *urlStr = [NSString stringWithFormat:@"product/rob/remind?limit=%ld&page=%ld",_limit,_page];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:showHud loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if (clear) {
                    _dataArr = [NSMutableArray array];
                }
                if ([objDic objectForKey:@"robData"] && [[objDic objectForKey:@"robData"] isKindOfClass:[NSArray class]]) {
                    NSArray *robDataArr = [objDic objectForKey:@"robData"];
                    _lastRequsetCount = robDataArr.count;
                    for (NSDictionary *d in robDataArr) {
                        RemindRobProductData *item = [RemindRobProductData dataForDictionary:d];
                        [_dataArr addObject:item];
                    }
                }
                [self showDefeatedView:_dataArr.count == 0];
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
        [self getActivityData:false showHud:false];
    }];
    _tableView.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        _page = 0;
        _lastRequsetCount = 0;
        [self getActivityData:true showHud:false];
    }];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    RemindRobProductData *item = _dataArr[section];
    return item.robResponses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SeckillProductCellID = @"SeckillProductCellID";
    SeckillProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:SeckillProductCellID];
    if (cell == nil) {
        cell = [[SeckillProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SeckillProductCellID];
    }
    RemindRobProductData *item = _dataArr[indexPath.section];
    RobProductData *product = item.robResponses[indexPath.row];
    [cell setupInfoRemindWithRobProductData:product];
    cell.cellBtnActionHandle = ^{
        [self tableViewCellBtnActionHandleWithIndex:indexPath];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(276.0);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindRobProductData *item = _dataArr[indexPath.section];
    RobProductData *product = item.robResponses[indexPath.row];
    SingleProductNewController *singleVC = [[SingleProductNewController alloc]initWithProductId:product.productNumber andCover:product.cover productTitle:product.productName productPrice:product.curDetailResponse.price];
    singleVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleVC animated:true];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(72.0))];
    sectionView.backgroundColor = [UIColor colorFromHex:0xfff5f7];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24), 0, FitWith(220.0), FitHeight(72.0))];
    lable.textColor = [UIColor mainColor];
    lable.font = CUSNEwFONT(16);
    RemindRobProductData *item = _dataArr[section];
    lable.text = [NSString stringWithFormat:@"开始时间 %@",item.robSessionDisplay];
    [sectionView addSubview:lable];
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(72.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableViewCellBtnActionHandleWithIndex:(NSIndexPath *)indexPath{
    RemindRobProductData *item = _dataArr[indexPath.section];
    RobProductData *product = item.robResponses[indexPath.row];
    if (product.isRemind) {
        [self cancelRemindWithRobProductData:product andIndexPath:indexPath];
    }else{
        [self saveRemindWithRobProductData:product andIndexPath:indexPath];
    }
}

-(void)saveRemindWithRobProductData:(RobProductData *)product andIndexPath:(NSIndexPath *)indexPath{
    NSDate *beginDate = [NSString dateDateStr:product.sessionStartTime FormateDateStr:nil];
    long long endDateStr = product.sessionStartTime.longLongValue + 1800000;
    NSDate *endDate = [NSString dateDateStr:[NSString stringWithFormat:@"%lld",endDateStr] FormateDateStr:nil];
    
    [FFCalendarReminderTool saveEventWithTitle:@"哆集：定阅商品即将抢购" notes:@"" location:nil
     startDate:beginDate endDate:endDate alarms:@[[EKAlarm alarmWithRelativeOffset:-180.0f]] URL:nil availability:EKEventAvailabilityNotSupported successBlock:^(NSString *eventIdentifier) {
         //上传服务器
         NSMutableDictionary *params = [NSMutableDictionary dictionary];
         [params setObject:eventIdentifier forKey:@"code"];
         [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"product/rob/%@/remind",product.curDetailResponse.robId] params:params from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
             NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
             if ([resultCode isEqualToString:@"ok"]) {
                 [MQToast showToast:@"将在开抢前3分钟提醒您，可在'我的提醒'中查看" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
                 [self getActivityData:true showHud:true];
             }
         } fail:^(NSError *error) {
             //
         }];
     } failBlock:^(NSError *err) {
         //
     }];
}

-(void)cancelRemindWithRobProductData:(RobProductData *)product andIndexPath:(NSIndexPath *)indexPath{
    [RequestManager requestWithMethod:POST WithUrlPath:[NSString stringWithFormat:@"product/rob/%@/remind?cancel",product.curDetailResponse.robId] params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            [self getActivityData:true showHud:true];
            [MQToast showToast:@"取消成功，您可能会错过这个心仪的商品哦" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
        }
    } fail:^(NSError *error) {
        //
    }];
    [FFCalendarReminderTool deleteReminderWithIdentifer:product.remindCode];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, mainScreenHeight - 64) andDefeatedImageName:@"defeated_no_remind" messageName:@"呀！你还没有设置秒杀提醒哦~" backBlockBtnName:nil backBlock:^{
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
