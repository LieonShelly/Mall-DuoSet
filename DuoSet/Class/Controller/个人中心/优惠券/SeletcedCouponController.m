//
//  SeletcedCouponController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeletcedCouponController.h"
#import "SeletcedConponCell.h"
#import "ShopCarSureProduct.h"
#import "CouponSeletcedData.h"

@interface SeletcedCouponController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) ShopCarSureData *dataItem;

@end

@implementation SeletcedCouponController

-(instancetype)initWithShopCarSureData:(ShopCarSureData *)dataItem{
    self = [super init];
    if (self) {
        _dataItem = dataItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择优惠券";
    self.view.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    [self creatUI];
}

- (void)creatUI{
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    rightBtn.titleLabel.font = CUSFONT(13);
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataItem.couponCodeResponses.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SeletcedConponCellID = @"SeletcedConponCellID";
    SeletcedConponCell * cell = [_tableView dequeueReusableCellWithIdentifier:SeletcedConponCellID];
    if (cell == nil) {
        cell = [[SeletcedConponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SeletcedConponCellID];
    }
    CouponInfoData *item = _dataItem.couponCodeResponses[indexPath.section];
    [cell setupInfoWithCouponInfoData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(140.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(BOOL)hasDicValueForKey:(NSString *)key withNSArray:(NSArray *)arr{
    for (NSDictionary *d in arr) {
        if ([d objectForKey:key]) {
            return  true;
        }
    }
    return false;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponInfoData *item = _dataItem.couponCodeResponses[indexPath.section];
    if (!item.couponSelectedResonse.canSelected) {
//        SeletcedConponCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
//        cell.leftSeletcedBtn.selected = !cell.leftSeletcedBtn.selected;
//        item.couponSelectedResonse.selected = !item.couponSelectedResonse.selected;
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        NSMutableDictionary *productPriceMap = [NSMutableDictionary dictionary];
        for (ShopCarSureProduct *product in _dataItem.products){
            if (![productPriceMap objectForKey:product.product_id]) {
                [productPriceMap setObject:[NSDictionary dictionary] forKey:product.product_id];
            }
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:[productPriceMap objectForKey:product.product_id]];
            [mutableDic setValue:product.price forKey:product.propertiesId];
            [productPriceMap setValue:mutableDic forKey:product.product_id];
        }
        [params setObject:productPriceMap forKey:@"productPriceMap"];
        NSMutableArray *arr = [NSMutableArray array];
        for (CouponInfoData *it in _dataItem.couponCodeResponses) {
            if (it == item) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:item.couponSelectedResonse.couponCodeId forKey:@"couponCodeId"];
                [dic setObject:[NSNumber numberWithBool:true] forKey:@"selected"];
                [arr addObject:dic];
            }else{
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:item.couponSelectedResonse.couponCodeId forKey:@"couponCodeId"];
                [dic setObject:[NSNumber numberWithBool:false] forKey:@"selected"];
                [arr addObject:dic];
            }
        }
        [params setObject:arr forKey:@"couponSelecteds"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"user/coupon/selectCoupon" params:params from:self showHud:true loadingText:nil enableUserActions:true success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    if ([objDic objectForKey:@"couponCodeResponses"] && [[objDic objectForKey:@"couponCodeResponses"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = [objDic objectForKey:@"couponCodeResponses"];
                        NSMutableArray *couponCodeResponses = [NSMutableArray array];
                        for (NSDictionary *d in arr) {
                            CouponInfoData *item = [CouponInfoData dataForDictionary:d];
                            [couponCodeResponses addObject:item];
                        }
                        _dataItem.couponCodeResponses = couponCodeResponses;
                        [tableView reloadData];
                    }
                }
            }
        } fail:^(NSError *error) {
            //
        }];
        return;
    }
    SeletcedConponCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    cell.leftSeletcedBtn.selected = !cell.leftSeletcedBtn.selected;
    item.couponSelectedResonse.selected = !item.couponSelectedResonse.selected;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *productPriceMap = [NSMutableDictionary dictionary];
    for (ShopCarSureProduct *product in _dataItem.products){
        if (![productPriceMap objectForKey:product.product_id]) {
            [productPriceMap setObject:[NSDictionary dictionary] forKey:product.product_id];
        }
        NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:[productPriceMap objectForKey:product.product_id]];
        [mutableDic setValue:product.price forKey:product.propertiesId];
        [productPriceMap setValue:mutableDic forKey:product.product_id];
    }
    [params setObject:productPriceMap forKey:@"productPriceMap"];
    NSMutableArray *arr = [NSMutableArray array];
    for (CouponInfoData *item in _dataItem.couponCodeResponses) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:item.couponSelectedResonse.couponCodeId forKey:@"couponCodeId"];
        [dic setObject:[NSNumber numberWithBool:item.couponSelectedResonse.selected] forKey:@"selected"];
        [arr addObject:dic];
    }
    [params setObject:arr forKey:@"couponSelecteds"];
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/coupon/selectCoupon" params:params from:self showHud:true loadingText:nil enableUserActions:true success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"couponCodeResponses"] && [[objDic objectForKey:@"couponCodeResponses"] isKindOfClass:[NSArray class]]) {
                    NSArray *arr = [objDic objectForKey:@"couponCodeResponses"];
                    NSMutableArray *couponCodeResponses = [NSMutableArray array];
                    for (NSDictionary *d in arr) {
                        CouponInfoData *item = [CouponInfoData dataForDictionary:d];
                        [couponCodeResponses addObject:item];
                    }
                    _dataItem.couponCodeResponses = couponCodeResponses;
                    [tableView reloadData];
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)sureBtnAction{
    CGFloat minusPrice = 0.0;
    NSMutableArray *selectedArr = [NSMutableArray array];
    for (CouponInfoData *item in _dataItem.couponCodeResponses) {
        if (item.couponSelectedResonse.selected) {
            minusPrice += item.amount.floatValue;
            [selectedArr addObject:item];
        }
    }
    SeletcedBlock block = _chioceHandle;
    if (block) {
        block(minusPrice,selectedArr);
    }
    [self.navigationController popViewControllerAnimated:true];
}

@end
