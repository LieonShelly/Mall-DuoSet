//
//  ProductTexDesView.m
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductTexDesView.h"
#import "ProductTexDesCell.h"

@interface ProductTexDesView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation ProductTexDesView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headerView];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        titleLable.textColor = [UIColor colorFromHex:0x222222];
        titleLable.text = @"税率";
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        titleLable.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleLable];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitHeight(70.0) - FitWith(24.0), FitHeight(10.0), FitHeight(70.0), FitHeight(70.0))];
        [closeBtn setImage:[UIImage imageNamed:@"close_coupons"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:closeBtn];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FitHeight(90.0), mainScreenWidth, FitHeight(660.0)) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_tableView];
    }
    return self;
}

-(void)setupInfoWithProductDetailsArticleArr:(NSMutableArray *)items{
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
    static NSString *AftermarketDetailsCellID = @"AftermarketDetailsCellID";
    ProductTexDesCell * cell = [_tableView dequeueReusableCellWithIdentifier:AftermarketDetailsCellID];
    if (cell == nil) {
        cell = [[ProductTexDesCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AftermarketDetailsCellID];
    }
    ProductDetailsArticle *item = _items[indexPath.row];
    [cell setupInfoWithProductDetailsArticle:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailsArticle *item = _items[indexPath.row];
    return item.taxCellHight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)closeBtnAction{
    ProductTexDesViewCloseBlock block = _closeHandle;
    if (block) {
        block();
    }
}


@end
