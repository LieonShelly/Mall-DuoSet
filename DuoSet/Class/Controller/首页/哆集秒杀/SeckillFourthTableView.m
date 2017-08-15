//
//  SeckillFourthTableView.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillFourthTableView.h"
#import "SeckillCell.h"

@interface SeckillFourthTableView()<UITableViewDataSource, UITableViewDelegate>



@end

@implementation SeckillFourthTableView

+ (SeckillFourthTableView *)contentTableView{
    SeckillFourthTableView *contentTV = [[SeckillFourthTableView alloc] initWithFrame:CGRectMake(mainScreenWidth * 3, 0, [UIScreen mainScreen].bounds.size.width, mainScreenHeight - 64 - FitHeight(100)) style:UITableViewStyleGrouped];
    contentTV.backgroundColor = [UIColor clearColor];
    contentTV.dataSource = contentTV;
    contentTV.delegate = contentTV;
    contentTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    contentTV.showsVerticalScrollIndicator = false;
    return contentTV;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitHeight(285.0);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *SeckillCellID = @"SeckillCellID";
    SeckillCell * cell = [tableView dequeueReusableCellWithIdentifier:SeckillCellID];
    if (cell == nil) {
        cell = [[SeckillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SeckillCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(20.0))];
    view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(20.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    DuoSetOrder *item = _itemArr[indexPath.row];
    //    AllOrderTableViewDetailBlock block =  _cellSeletcedAction;
    //    if (block) {
    //        block(item);
    //    }
}
@end
