//
//  SubjectDetailController.m
//  DuoSet
//
//  Created by fanfans on 2017/3/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SubjectDetailController.h"
#import "SubjectDetailCell.h"
#import "SubjectData.h"
#import "CommonRecommendForYouCell.h"
#import "SingleProductNewController.h"
#import "ShoppingCartViewController.h"

@interface SubjectDetailController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,copy) NSString *subjectId;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) SubjectData *itemData;

@end

@implementation SubjectDetailController

-(instancetype)initWithSubjectId:(NSString *)subjectId{
    self = [super init];
    if (self) {
        _subjectId = subjectId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专题组合";
    [self configUI];
    [self configData];
}

-(void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [rightBtn setImage:[UIImage imageNamed:@"product_detail_shopcart"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBarButtonItemActionHandle) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    _tableView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)configData{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"/subject/%@",_subjectId];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _itemData = [SubjectData dataForDictionary:objDic];
            }
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        //
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _itemData == nil ? 0 : 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *SubjectDetailCellID = @"SubjectDetailCellID";
        SubjectDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:SubjectDetailCellID];
        if (cell == nil) {
            cell = [[SubjectDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SubjectDetailCellID ];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupInfoWithSubjectData:_itemData];
        return cell;
    }else{
        static NSString *CommonRecommendForYouCellID = @"CommonRecommendForYouCellID";
        CommonRecommendForYouCell * cell = [_tableView dequeueReusableCellWithIdentifier:CommonRecommendForYouCellID];
        if (cell == nil) {
            cell = [[CommonRecommendForYouCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommonRecommendForYouCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        [cell setupInfoWithHomeMatchProductDataArr:_itemData.productList];
        cell.recommendHandle = ^(NSInteger index){
            [weakSelf RecommendForYouProductItem:index];
        };
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return _itemData.cellHight;
    }
    if (indexPath.section == 1) {
        return (FitHeight(600.0) + 3) * ((_itemData.productList.count + 1) / 2);
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PiazzaData *item = _communityArr[indexPath.row];
//    PiazzaMessageDetailsController *detailVC = [[PiazzaMessageDetailsController alloc]initWithCommunityId:item.communityId];
//    detailVC.hidesBottomBarWhenPushed = true;
//    [self.navigationController pushViewController:detailVC animated:true];
}

-(void)ScanPictures:(NSArray *)imgArr andIndex:(NSInteger)index{
    ScanPictureViewController *picVC = [[ScanPictureViewController alloc]initWithPhotosUrl:imgArr WithCurrentIndex:index];
    [self presentViewController:picVC animated:true completion:nil];
}

-(void)RecommendForYouProductItem:(NSInteger)index{
    HomeMatchProductData *item = _itemData.productList[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc] initWithProductId:item.productNumber];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

-(void)rightBarButtonItemActionHandle{
    ShoppingCartViewController *shopCartVC = [[ShoppingCartViewController alloc]init];
    shopCartVC.isFromPrudoctDetail = true;
    shopCartVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:shopCartVC animated:true];
}

@end
