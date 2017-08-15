//
//  ReturnAndChangeTipsView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeTipsView.h"
#import "ReturnAndChangeTipsCell.h"

@interface ReturnAndChangeTipsView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *agreeBtn;
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,strong) NSMutableArray*cellHightArr;

@end

@implementation ReturnAndChangeTipsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headerView];
        
        UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        titleLable.textColor = [UIColor colorFromHex:0x222222];
        titleLable.text = @"注意事项";
        titleLable.font = CUSNEwFONT(16);
        titleLable.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleLable];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitHeight(70.0) - FitWith(24.0), FitHeight(10.0), FitHeight(70.0), FitHeight(70.0))];
        [closeBtn setImage:[UIImage imageNamed:@"close_coupons"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:closeBtn];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FitHeight(90.0), mainScreenWidth, FitHeight(506.0)) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:_tableView];
        
        _agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(24.0), _tableView.frame.origin.y + _tableView.frame.size.height + FitHeight(20.0), mainScreenWidth - FitWith(48.0), FitHeight(88.0))];
        _agreeBtn.backgroundColor = [UIColor mainColor];
        _agreeBtn.titleLabel.font = CUSNEwFONT(21);
        _agreeBtn.layer.cornerRadius = 3;
        [_agreeBtn addTarget:self action:@selector(agreeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_agreeBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self addSubview:_agreeBtn];
        
    }
    return self;
}

-(void)setupInfoWithArticles:(NSMutableArray *)items AndArticlesCellHight:(NSMutableArray *)cellHightArr{
    _items = items;
    _cellHightArr = cellHightArr;
    [self.tableView reloadData];
}

-(void)setupInfoWithProductDetailsArticleArr:(NSMutableArray *)items{
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *AftermarketDetailsCellID = @"AftermarketDetailsCellID";
    ReturnAndChangeTipsCell * cell = [_tableView dequeueReusableCellWithIdentifier:AftermarketDetailsCellID];
    if (cell == nil) {
        cell = [[ReturnAndChangeTipsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AftermarketDetailsCellID];
    }
    cell.tipLable.text = _items[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *num = _cellHightArr[indexPath.row];
    return num.floatValue;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)closeBtnAction{
    CloseBlock block = _closeHandle;
    if (block) {
        block();
    }
}

-(void)agreeBtnAction{
    AgreeBlock block = _agreeHandle;
    if (block) {
        block();
    }
}

@end
