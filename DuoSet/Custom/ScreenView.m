//
//  ScreenView.m
//  wangzongdexiaodi
//
//  Created by issuser on 16/12/15.
//  Copyright © 2016年 xiaodi. All rights reserved.
//

#import "ScreenView.h"
#import "DiscountAndSeverCell.h"
#import "MenuPriceCell.h"
#import "MenuAddressCell.h"
#import "PriceIntervalsModel.h"
#import "SeverModel.h"

@interface ScreenView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *view;

@end

@implementation ScreenView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initViews];
        [self getPriceIntervals];
        [self getProLabel];
    }
    return self;
}
//获取商品价格标签
- (void) getProLabel {
}
- (void) getPriceIntervals{
}

- (void) initViews{
    _view = [[UIView alloc] initWithFrame:CGRectMake(89*AdapterWidth(), 0, 288*AdapterWidth(), self.frame.size.height)];
    _view.backgroundColor = [UIColor whiteColor];
    [self addSubview:_view];
    self.clipsToBounds = YES;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64, _view.frame.size.width, mainScreenHeight-64-30*AdapterWidth())];
    [_view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[DiscountAndSeverCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[MenuPriceCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[MenuAddressCell class] forCellReuseIdentifier:@"cell2"];
    _tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = 180;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, _view.frame.size.height-45*AdapterWidth(), _view.frame.size.width, 45*AdapterWidth())];
    [_view addSubview:btn];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        DiscountAndSeverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        for (int i = 0; i < 4; i++) {
            SeverModel *model = _severDataArray[i];
            UIButton *btn = [cell viewWithTag:101+i];
            NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"222222"],
                                    NSFontAttributeName:[UIFont systemFontOfSize:12*AdapterWidth()]};
            NSAttributedString * str = [[NSAttributedString alloc]initWithString:[model.name length]?model.name:@"" attributes:dict];
            [btn setAttributedTitle:str forState:UIControlStateNormal];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1){
    MenuPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    for (int i=0; i<_priceDataArray.count; i++) {
        NSLog(@"%@", _priceDataArray);
        UIButton *btn = [cell viewWithTag:301+i];
        NSDictionary * dict = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"222222"],
                                NSFontAttributeName:[UIFont systemFontOfSize:12*AdapterWidth()]};
        NSAttributedString * str = [[NSAttributedString alloc]initWithString:@"28%的人选择" attributes:dict];
        [btn setAttributedTitle:str forState:UIControlStateNormal];
        PriceIntervalsModel *model = _priceDataArray[i];
        UILabel *label = [cell viewWithTag:201+i];
        NSString *priceStr = [NSString stringWithFormat:@"%@-%@", model.minPrice, model.maxPrice];
        label.text = priceStr;
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    MenuAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        return 140*AdapterWidth();
    }
    if (indexPath.section == 1){
        return 150*AdapterWidth();
    }
    return 100*AdapterWidth();
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width,  0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        //
    }];

}
@end
