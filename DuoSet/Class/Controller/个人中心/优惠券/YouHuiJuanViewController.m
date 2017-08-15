//
//  YouHuiJuanViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "YouHuiJuanViewController.h"
#import "PersonYouhuiJuanCell.h"
#import "YouhuiJuanModel.h"
#import "CouponCell.h"
#import "CouponHeaderView.h"

@interface YouHuiJuanViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) CouponHeaderView *headerView;
@property (nonatomic, strong) UITableView *unUseTableView;//未使用
@property (nonatomic, strong) UIScrollView *bgScrollView;
@property (nonatomic, strong) UITableView *useTableView;//已使用
@property (nonatomic, assign) NSUInteger customerId;
@property (nonatomic, strong) NSMutableArray *youhuijuanDataArray;
@property (nonatomic, strong) NSMutableArray *guoqiYouHuijuanDataArray;
@property (nonatomic, copy) NSString *useStr;
@property (nonatomic, copy) NSString *unUseStr;

@end

@implementation YouHuiJuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    [self creatUI];
    [self getYouhuijuanListData];
    [self getGuoqiYouhuijuanData];
}

- (void) getYouhuijuanListData{
    _customerId = 1;
    NSString *str = [NSString stringWithFormat:@"{\"customerId\":%ld}", _customerId];
    NSDictionary *dict = @{@"data": str};
    [WebRequest webRequestWithURLGetMethod:YouHuiJuan_List_Url params:dict success:^(id result) {
        NSLog(@"%@", result);
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result valueForKey:@"coupons"]) {
                if ([[result valueForKey:@"coupons"] isKindOfClass:[NSArray class]]) {
                    NSArray *coupons = [result valueForKey:@"coupons"];
                    _youhuijuanDataArray = [NSMutableArray array];
                    for (NSDictionary *d in coupons) {
                        YouhuiJuanModel *model = [YouhuiJuanModel dataForDictionary:d];
                        [_youhuijuanDataArray addObject:model];
                    }
                    [_unUseTableView reloadData];
                }
            }
        }
    } fail:^(NSString *result) {
        NSLog(@"%@", result);
    }];
}

- (void) getGuoqiYouhuijuanData{
    NSString *str = [NSString stringWithFormat:@"{\"customerId\":%ld, \"state\":\"EXPIRE\"}", _customerId];
    NSLog(@"%@", str);
    NSDictionary *dict = @{@"data": str};
    [WebRequest webRequestWithURLGetMethod:YouHuiJuan_List_Url params:dict success:^(id result) {
        NSLog(@"%@", result);
        if(!_guoqiYouHuijuanDataArray){
            _guoqiYouHuijuanDataArray = [[NSMutableArray alloc] init];
        }
        [_guoqiYouHuijuanDataArray removeAllObjects];
        [_guoqiYouHuijuanDataArray addObjectsFromArray:[YouhuiJuanModel objectArrayWithKeyValuesArray:result[@"coupons"]]];
        [_useTableView reloadData];
        
    } fail:^(NSString *result) {
        NSLog(@"%@",result);
    }];
}

- (void)creatUI{
    _headerView = [[CouponHeaderView alloc]initWithFrame:CGRectMake(0, 64, mainScreenWidth, FitHeight(90.0))];
    __weak typeof(self) weekSelf = self;
    _headerView.headerBtnActionHandle = ^(NSInteger index){
        [weekSelf.bgScrollView setContentOffset:CGPointMake(mainScreenWidth * index , 0) animated:true];
    };
    [self.view addSubview:_headerView];
    _bgScrollView= [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headerView.frame), mainScreenWidth, mainScreenHeight-104)];
    [self.view addSubview:_bgScrollView];
     _bgScrollView.pagingEnabled = YES;
    _bgScrollView.delegate = self;
    _bgScrollView.contentSize = CGSizeMake(mainScreenWidth*2, mainScreenHeight-104);
    
    _unUseTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, _bgScrollView.frame.size.height) style:UITableViewStylePlain];
    _unUseTableView.delegate = self;
    _unUseTableView.dataSource = self;
    _unUseTableView.tableFooterView = [UIView new];
    _unUseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _unUseTableView.showsVerticalScrollIndicator = false;
    [_bgScrollView addSubview:_unUseTableView];
    
    _useTableView = [[UITableView alloc] initWithFrame:CGRectMake(mainScreenWidth, 0, mainScreenWidth, _bgScrollView.frame.size.height) style:UITableViewStylePlain];
    _useTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _useTableView.showsVerticalScrollIndicator = false;
    _useTableView.delegate = self;
    _useTableView.dataSource = self;
    _useTableView.tableFooterView = [UIView new];
    [_bgScrollView addSubview:_useTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _useTableView){
//        return _guoqiYouHuijuanDataArray.count;
        return 10;
    }
//    return _youhuijuanDataArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CouponCellID = @"CouponCellID";
    CouponCell * cell = [tableView dequeueReusableCellWithIdentifier:CouponCellID];
    if (cell == nil) {
        cell = [[CouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponCellID];
    }
    YouhuiJuanModel *model = _youhuijuanDataArray[indexPath.row];
    cell.choiceHandle = ^(){
        TickSeletedBlock block = _seletedHandle;
        if (block) {
            block(model);
            [self.navigationController popViewControllerAnimated:true];
        }
    };
//    [cell setupInfoWithYouhuiJuanModel:model];
    return cell;;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return false;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(170.0);
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    YouhuiJuanModel *model = _youhuijuanDataArray[indexPath.row];
    NSUInteger customerId = 1;
    NSString *str = [NSString stringWithFormat:@"{\"customerId\":%ld,\"couponIds\":[%@]}",customerId, model.couponId];
    NSLog(@"%@", str);
    NSDictionary *dict = @{@"data":str};
    [WebRequest webRequestWithURLGetMethod:DeleCoupon_Url params:dict success:^(id result) {
        NSLog(@"%@", result);
        if ([result[@"code"] integerValue] == 1) {
            Toast(@"删除成功");
        }else
        {
            Toast(@"删除失败");
        }
    } fail:^(NSString *result) {
        NSLog(@"%@",result);
    }];
    
    [_youhuijuanDataArray removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
    
}
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return @"删除";
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    YouhuiJuanModel *model = _youhuijuanDataArray[indexPath.section];
    
//    TickSeletedBlock block = _seletedHandle;
//    if (block) {
//        block(model.);
//    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/ mainScreenWidth;
    [_headerView setBtnChangeWithIndex:index];
}


@end
