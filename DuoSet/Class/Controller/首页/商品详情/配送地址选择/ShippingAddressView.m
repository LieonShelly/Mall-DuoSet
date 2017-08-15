//
//  ShippingAddressView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShippingAddressView.h"
#import "ShippingAddressViewCell.h"
#import "CouponInfoData.h"
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"

@interface ShippingAddressView()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) ChooseLocationView *chooseLocationView;
@property(nonatomic,assign) BOOL includeAddressAddressModel;

@end

@implementation ShippingAddressView

-(instancetype)initWithFrame:(CGRect)frame includeAddressAddressModel:(BOOL)includeAddressAddressModel{
    self = [super initWithFrame:frame];
    if (self) {
        _includeAddressAddressModel = includeAddressAddressModel;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headerView];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        titleLable.textColor = [UIColor colorFromHex:0x222222];
        titleLable.text = @"配送至";
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleLable];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitHeight(70.0) - FitWith(24.0), FitHeight(10), FitHeight(70.0), FitHeight(70.0))];
        [closeBtn setImage:[UIImage imageNamed:@"close_coupons"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:closeBtn];
        
        if (includeAddressAddressModel) {
            _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(10.0), FitHeight(10), FitHeight(70.0), FitHeight(70.0))];
            [_backBtn setImage:[UIImage imageNamed:@"new_nav_arrow_black"] forState:UIControlStateNormal];
            [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
            _backBtn.hidden = true;
            [headerView addSubview:_backBtn];
            
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, FitHeight(90.0), mainScreenWidth, FitHeight(660.0))];
            _scrollView.contentSize = CGSizeMake(mainScreenWidth * 2, 0);
            _scrollView.pagingEnabled = YES;
            _scrollView.delegate = self;
            _scrollView.showsHorizontalScrollIndicator = false;
            _scrollView.userInteractionEnabled = true;
            _scrollView.delegate = self;
            [self addSubview:_scrollView];
            
            //已有地址显示的tableview
            UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(70.0))];
            tableHeaderView.backgroundColor = [UIColor whiteColor];
            
            UILabel *cangetlable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), 0, mainScreenWidth - FitWith(24.0), FitHeight(50.0))];
            cangetlable.text = @"已有配送地址";
            cangetlable.textAlignment = NSTextAlignmentLeft;
            cangetlable.font = CUSFONT(14);
            cangetlable.textColor = [UIColor colorFromHex:0x222222];
            [tableHeaderView addSubview:cangetlable];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, FitHeight(70.0) - 0.5, mainScreenWidth, 0.5)];
            line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
            [tableHeaderView addSubview:line];
            
            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(660.0)) style:UITableViewStyleGrouped];
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _tableView.backgroundColor = [UIColor whiteColor];
            _tableView.dataSource = self;
            _tableView.delegate = self;
            _tableView.tableHeaderView = tableHeaderView;
            _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            [_scrollView addSubview:_tableView];
            
            UIButton *otherAddressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _scrollView.frame.size.height - 50, mainScreenWidth, 50)];
            otherAddressBtn.backgroundColor = [UIColor mainColor];
            otherAddressBtn.titleLabel.font = CUSNEwFONT(18);
            [otherAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [otherAddressBtn setTitle:@"选择其他地址" forState:UIControlStateNormal];
            [otherAddressBtn addTarget:self action:@selector(choiceOtherAdress) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:otherAddressBtn];
            
            //选择地址
            [[CitiesDataTool sharedManager] requestGetData];
            [_scrollView addSubview:self.chooseLocationView];
            __weak typeof (self) weakSelf = self;
            _chooseLocationView.chooseFinish = ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ResetAddressModleSeletcedStatus" object:nil];
                SeletcedBlock block = weakSelf.seletcedHandle;
                if (block) {
                    block(weakSelf.chooseLocationView.address);
                }
                //延迟两秒，回到第一个界面
                dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0* NSEC_PER_SEC));
                dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                    weakSelf.backBtn.hidden = true;
                    [weakSelf.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
                });
            };
        }else{//未登陆或者没有填写地址的情况
            //选择地址
            
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, FitHeight(90.0), mainScreenWidth, FitHeight(660.0))];
            _scrollView.contentSize = CGSizeMake(mainScreenWidth, 0);
            _scrollView.pagingEnabled = YES;
            _scrollView.delegate = self;
            _scrollView.showsHorizontalScrollIndicator = false;
            _scrollView.userInteractionEnabled = true;
            _scrollView.delegate = self;
            [self addSubview:_scrollView];
            
            [[CitiesDataTool sharedManager] requestGetData];
            [_scrollView addSubview:self.chooseLocationView];
            __weak typeof (self) weakSelf = self;
            _chooseLocationView.chooseFinish = ^{
                SeletcedBlock block = weakSelf.seletcedHandle;
                if (block) {
                    block(weakSelf.chooseLocationView.address);
                }
            };
        }
    }
    return self;
}

-(void)setupInfoWithAddressModelInfoDataArr:(NSMutableArray *)items{
    _items = items;
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ShippingAddressViewCellID = @"ShippingAddressViewCellID";
    ShippingAddressViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:ShippingAddressViewCellID];
    if (cell == nil) {
        cell = [[ShippingAddressViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShippingAddressViewCellID];
    }
    AddressModel *item = _items[indexPath.row];
    [cell setupInfoWithAddressModel:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return FitHeight(100.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModel *item = _items[indexPath.row];
    for (AddressModel *it in _items) {
        if (it == item) {
            it.isSeletced = true;
        }else{
            it.isSeletced = false;
        }
    }
    [tableView reloadData];
    SeletcedBlock block = self.seletcedHandle;
    if (block) {
        block([NSString stringWithFormat:@"%@%@%@%@",item.province,item.city,item.area,item.addr]);
    }
}

-(void)choiceOtherAdress{
    _backBtn.hidden = false;
    [_scrollView setContentOffset:CGPointMake(mainScreenWidth, 0) animated:true];
}

-(void)closeBtnAction{
    CloseBlock block = _closeHandle;
    if (block) {
        block();
    }
}

-(void)backBtnAction{
    _backBtn.hidden = true;
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:true];
}

- (ChooseLocationView *)chooseLocationView{
    if (!_chooseLocationView) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(_includeAddressAddressModel ?  mainScreenWidth : 0, 0, mainScreenWidth, FitHeight(590.0))];
        _chooseLocationView.userInteractionEnabled = true;
        [_scrollView addSubview:self.chooseLocationView];
    }
    return _chooseLocationView;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        NSInteger index = scrollView.contentOffset.x/ mainScreenWidth;
        _backBtn.hidden = index == 0;
    }
}

@end
