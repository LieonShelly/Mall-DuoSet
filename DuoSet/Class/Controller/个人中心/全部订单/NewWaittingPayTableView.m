//
//  NewWaittingPayTableView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NewWaittingPayTableView.h"
#import "OrderListMainCell.h"

@interface NewWaittingPayTableView()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray *itemArr;

@end

@implementation NewWaittingPayTableView


+ (NewWaittingPayTableView *)contentTableViewAndHeaderRefreshBlock:(void (^)())headerBlock footRefreshBlock:(void (^)())footBlock{
    NewWaittingPayTableView *contentTV = [[NewWaittingPayTableView alloc] initWithFrame:CGRectMake(mainScreenWidth, 0, [UIScreen mainScreen].bounds.size.width, mainScreenHeight - 64 - FitHeight(80)) style:UITableViewStyleGrouped];
    contentTV.backgroundColor = [UIColor clearColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    contentTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTV.showsVerticalScrollIndicator = false;
    contentTV.mj_header= [FFGifHeader headerWithRefreshingBlock:^{
        headerBlock();
    }];
    contentTV.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        footBlock();
    }];
    return contentTV;
}

-(void)setupInfoWithDuoSetOrderArr:(NSMutableArray *)itemArr{
    _itemArr = itemArr;
    [self reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DuojiOrderData *item = _itemArr[indexPath.row];
    return item.mainCellHight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DuojiOrderData *item = _itemArr[indexPath.row];
    NSString *OrderListMainCellID = [NSString stringWithFormat:@"OrderListMainCellID-%ld",item.orderDetailResponses.count];
    OrderListMainCell * cell = [tableView dequeueReusableCellWithIdentifier:OrderListMainCellID];
    if (cell == nil) {
        cell = [[OrderListMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderListMainCellID andDuoSetOrder:item];
    }
    [cell setupInfoWithDuoSetOrder:item];
    cell.btnActionHandle = ^(DuojiOrderData *order,NSInteger index){
        WaittingPayTableViewBtnActionBlock block = _cellBtnAction;
        if (block) {
            block(order,index);
        }
    };
    cell.productTapHandle = ^(DuojiOrderData *order, NSInteger index) {
        WaittingPayTableViewProductActionBlock block = _productTapAction;
        if (block) {
            if (block) {
                block(order,index);
            }
        }
    };
    cell.cellDeletedHandle = ^(DuojiOrderData *order) {
        TableViewDeleteBlock block = _deleteHandle;
        if (block) {
            block(order);
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(20.0))];
    view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DuojiOrderData *item = _itemArr[indexPath.row];
    WaittingPayTableViewDetailBlock block =  _cellSeletcedAction;
    if (block) {
        block(item);
    }
}
@end
