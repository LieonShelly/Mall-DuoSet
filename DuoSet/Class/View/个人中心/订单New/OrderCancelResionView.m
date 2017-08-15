//
//  OrderCancelResionView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/15.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderCancelResionView.h"
#import "OrderCancelResionCell.h"

@interface OrderCancelResionView()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIButton *agreeBtn;
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,strong) NSMutableArray*cellHightArr;

@end

@implementation OrderCancelResionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        headerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:headerView];
        
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(90.0))];
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        _titleLable.text = @"取消订单";
        _titleLable.font = CUSNEwFONT(16);
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:_titleLable];
        
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - FitHeight(70.0) - FitWith(24.0), FitHeight(10.0), FitHeight(70.0), FitHeight(70.0))];
        [closeBtn setImage:[UIImage imageNamed:@"close_coupons"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:closeBtn];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(FitWith(24.0), FitHeight(89.0), mainScreenWidth - FitWith(48.0), 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [headerView addSubview:line];
        
        UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(140.0))];
        tableHeaderView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable= [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), 0, mainScreenWidth - FitWith(48.0), FitHeight(70.0))];
        _tipsLable.text = @"取消订单后，本单所享用的优惠可能会一并取消，是否继续？";
        _tipsLable.textColor = [UIColor mainColor];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSNEwFONT(14);
        [tableHeaderView addSubview:_tipsLable];
        
        UIView *tableHeaderViewLine = [[UIView alloc]initWithFrame:CGRectMake(FitWith(24.0), FitHeight(70.0), mainScreenWidth - FitWith(48.0), 0.5)];
        tableHeaderViewLine.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [tableHeaderView addSubview:tableHeaderViewLine];
        
        _resiontipsLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), tableHeaderViewLine.frame.origin.y + 0.5, mainScreenWidth - FitWith(48.0), FitHeight(70.0))];
        _resiontipsLable.text = @"请选择取消订单的原因（必选）：";
        _resiontipsLable.textColor = [UIColor colorFromHex:0x212121];
        _resiontipsLable.textAlignment = NSTextAlignmentLeft;
        _resiontipsLable.font = CUSNEwFONT(15);
        [tableHeaderView addSubview:_resiontipsLable];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, FitHeight(90.0), mainScreenWidth, FitHeight(310.0)) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = tableHeaderView;
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

-(void)setupInfoWithCancelResionDataArr:(NSMutableArray *)items{
    _items = items;
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
    static NSString *OrderCancelResionCellID = @"OrderCancelResionCellID";
    OrderCancelResionCell * cell = [_tableView dequeueReusableCellWithIdentifier:OrderCancelResionCellID];
    if (cell == nil) {
        cell = [[OrderCancelResionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderCancelResionCellID];
    }
    CancelResionData *item = _items[indexPath.row];
    [cell setupInfoWithCancelResionData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CancelResionData *item = _items[indexPath.row];
    return item.cellHight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CancelResionData *item = _items[indexPath.row];
    for (CancelResionData *it in _items) {
        it.isSeletced = it == item;
    }
    [_tableView reloadData];
}

-(void)closeBtnAction{
    CloseBlock block = _closeHandle;
    if (block) {
        block();
    }
}

-(NSString *)checkSeletced{
    for (CancelResionData *it in _items) {
        if (it.isSeletced) {
            return it.text;
        }
    }
    return @"";
}

-(void)agreeBtnAction{
    NSString *str = [self checkSeletced];
    if (str.length > 0) {
        AgreeBlock block = _agreeHandle;
        if (block) {
            block(str);
        }
    }else{
        [MQToast showToast:@"请先选择原因" duration:1.0 window:[[UIApplication sharedApplication].windows lastObject]];
    }
}

@end
