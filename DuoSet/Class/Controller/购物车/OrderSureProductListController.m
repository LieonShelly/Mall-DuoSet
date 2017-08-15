//
//  OrderSureProductListController.m
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureProductListController.h"
#import "ShopCarSureProduct.h"
#import "OrderProductCell.h"

@interface OrderSureProductListController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation OrderSureProductListController

-(instancetype)initWithShopCarSureProductArr:(NSMutableArray *)dataArr{
    self = [super init];
    if (self) {
        _dataArr = dataArr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品清单";
    [self creatUI];
}

- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *rightLable = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth - FitWith(140.0), 20, FitWith(140.0), 44)];
    rightLable.textColor = [UIColor colorFromHex:0x808080];
    rightLable.textAlignment = NSTextAlignmentRight;
    rightLable.font = CUSNEwFONT(16);
    NSInteger tmpcount = 0;
    for (ShopCarSureProduct *product in _dataArr) {
        tmpcount += product.count.integerValue;
    }
    rightLable.text = [NSString stringWithFormat:@"共%ld件",tmpcount];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:rightLable];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *OrderProductCellID = @"OrderProductCellID";
    OrderProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderProductCellID];
    if (cell == nil) {
        cell = [[OrderProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderProductCellID];
    }
    ShopCarSureProduct *item = _dataArr[indexPath.section];
    [cell setUpdataInfoWithShopCarSureProduct:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == _dataArr.count - 1) {
        return 0.1;
    }
    return FitHeight(14.0);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(14.0))];
    view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(230.0);
}

@end
