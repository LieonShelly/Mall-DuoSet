//
//  OrderSureOutOfStockView.m
//  DuoSet
//
//  Created by fanfans on 2017/6/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureOutOfStockView.h"
#import "OutOfStockCell.h"

typedef void(^LeftBtnBlock)();
typedef void(^RightBtnBlock)();

@interface OrderSureOutOfStockView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy) LeftBtnBlock leftHandle;
@property(nonatomic,copy) RightBtnBlock rightHandle;

@property(nonatomic,strong) UILabel *alertTitle;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UIButton *leftBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation OrderSureOutOfStockView

-(instancetype)initWithFrame:(CGRect)frame leftBtnTitle:(NSString *)leftTitle leftBtnBlock:(void (^)())leftBtnBlock rightBtnBlock:(void (^)())rightBtnBlock{
    self = [super initWithFrame:frame];
    if (self) {
        _leftHandle = leftBtnBlock;
        _rightHandle = rightBtnBlock;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _alertTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, frame.size.width, 15)];
        _alertTitle.text = @"选择商品无货";
        _alertTitle.textAlignment = NSTextAlignmentCenter;
        _alertTitle.font = [UIFont systemFontOfSize:16];
        _alertTitle.textColor = [UIColor colorFromHex:0x222222];
        [self addSubview:_alertTitle];
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _alertTitle.frame.origin.y + _alertTitle.frame.size.height + 5, frame.size.width, 83) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.frame.origin.y + _tableView.frame.size.height + 5, frame.size.width, 0.5)];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:_line];
        
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _line.frame.origin.y + 0.5, frame.size.width * 0.5, 50)];
        _leftBtn.backgroundColor = [UIColor whiteColor];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_leftBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftBtnActionHandle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBtn];
        
        _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width * 0.5, _line.frame.origin.y + 0.5, frame.size.width * 0.5, 50)];
        _rightBtn.backgroundColor = [UIColor mainColor];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightBtn setTitle:@"移除无库存商品" forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightBtnActionHandle) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return self;
}

-(void)leftBtnActionHandle{
    _leftHandle();
}

-(void)rightBtnActionHandle{
    _rightHandle();
}

-(void)setupInfoWithSellOutProductDataArr:(NSMutableArray *)items{
    _items = items;
    [_tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *OutOfStockCellID = @"OutOfStockCellID";
    OutOfStockCell * cell = [_tableView dequeueReusableCellWithIdentifier:OutOfStockCellID];
    if (cell == nil) {
        cell = [[OutOfStockCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OutOfStockCellID];
    }
    SellOutProductData *item = _items[indexPath.row];
    [cell setupInfoWithSellOutProductData:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

@end
