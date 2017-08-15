//
//  GetCouponsTableView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/24.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GetCouponsTableView.h"
#import "CouponsCell.h"
#import "CouponInfoData.h"

@interface GetCouponsTableView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation GetCouponsTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(160.0))];
        headerView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self addSubview:headerView];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        titleLable.textColor = [UIColor colorFromHex:0x222222];
        titleLable.text = @"优惠券";
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleLable];
        
        UILabel *cangetlable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), titleLable.frame.origin.y + titleLable.frame.size.height, mainScreenWidth - FitWith(24.0), FitHeight(50.0))];
        cangetlable.text = @"可领优惠券";
        cangetlable.textAlignment = NSTextAlignmentLeft;
        cangetlable.font = CUSFONT(14);
        cangetlable.textColor = [UIColor colorFromHex:0x222222];
        [headerView addSubview:cangetlable];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitHeight(70.0) - FitWith(24.0), 0, FitHeight(70.0), FitHeight(70.0))];
        [closeBtn setImage:[UIImage imageNamed:@"close_coupons"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:closeBtn];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FitHeight(160.0), mainScreenWidth, FitHeight(590.0)) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_tableView];
    }
    return self;
}

-(void)setupInfoWithCouponInfoDataArr:(NSMutableArray *)items{
    _items = items;
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _items.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CouponsCellID = @"CouponsCellID";
    CouponsCell * cell = [_tableView dequeueReusableCellWithIdentifier:CouponsCellID];
    if (cell == nil) {
        cell = [[CouponsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CouponsCellID];
    }
    CouponInfoData *item = _items[indexPath.section];
    [cell setupInfoWithCouponInfoData:item];
    cell.getBtn.tag = indexPath.section;
    [cell.getBtn addTarget:self action:@selector(getCouponBtnAciton:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(140.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 0.1 : FitHeight(30.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)getCouponBtnAciton:(UIButton *)btn{
    GetCouponsAcitonBlock block = _getCouponsHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)closeBtnAction{
    CloseBtnAction block = _closeHandle;
    if (block) {
        block();
    }
}

@end
