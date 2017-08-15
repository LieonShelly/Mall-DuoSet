//
//  GlobalBuyController.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalBuyController.h"
#import "CommonBannerView.h"
#import "GlobalAdCell.h"
#import "GlobalBuyFiveImgCell.h"
#import "GlobalBuyHomeProductCell.h"

#import "SingleProductNewController.h"
#import "GlobalAreaDetailController.h"
#import "SubjectDetailController.h"
#import "ScreenProductController.h"

#import "GlobalHomeData.h"

@interface GlobalBuyController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) CommonBannerView *headerView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) GlobalHomeData *homeData;

@end

@implementation GlobalBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全球购";
    [self configUI];
    [self configData];
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/global" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                _homeData = [GlobalHomeData dataForDictionary:objDic];
            }
            if (_homeData != nil && _homeData.globalTopBanner.count > 0) {
                CurrentFashionData *data = _homeData.globalTopBanner[0];
                [_headerView setupInfoWithImgVArr:@[data.picture]];
            }
            
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [self.view addSubview:_tableView];
    
    _headerView = [[CommonBannerView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(350.0))];
    __weak typeof(self) weakSelf = self;
    _headerView.imgTapHandle = ^(NSInteger index){
        if (_homeData != nil && _homeData.globalTopBanner.count > 0) {
            CurrentFashionData *banner = weakSelf.homeData.globalTopBanner[0];
            if (banner.type == BannerProduct) {//跳转到商品
                SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:banner.typeValue];
                singleItemVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:singleItemVC animated:true];
                return ;
            }
            if (banner.type == BannerWeb) {//跳转到网站
                WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:banner.typeValue NavTitle:@""];
                webVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:webVC animated:true];
                return ;
            }
            if (banner.type == BannerSubObject) {//跳转到专题
                SubjectDetailController *subJectVC = [[SubjectDetailController alloc]initWithSubjectId:banner.typeValue];
                subJectVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:subJectVC animated:true];
                return ;
            }
            if (banner.type == BannerClsaaify) {
                ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andclassifyLevel:banner.classifyLevel andItemId:banner.typeValue];
                listVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:listVC animated:true];
                return ;
            }
        }
    };
    _tableView.tableHeaderView = _headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *GlobalBuyFiveImgCellID = @"GlobalBuyFiveImgCellID";
        GlobalBuyFiveImgCell * cell = [_tableView dequeueReusableCellWithIdentifier:GlobalBuyFiveImgCellID];
        if (cell == nil) {
            cell = [[GlobalBuyFiveImgCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GlobalBuyFiveImgCellID];
        }
        cell.imgTapHandle = ^(NSInteger index){
            [self globalAreaDetailHandleWithIndex:index];
        };
        [cell setupInfoWithGlobalAreaDataArr:_homeData.globalList];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 1) {
        static NSString *GlobalAdCellID = @"GlobalAdCellID";
        GlobalAdCell * cell = [_tableView dequeueReusableCellWithIdentifier:GlobalAdCellID];
        if (cell == nil) {
            cell = [[GlobalAdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GlobalAdCellID];
        }
        if (_homeData != nil && _homeData.globalMiddleBanner.count > 0) {
            CurrentFashionData *banner = _homeData.globalMiddleBanner[0];
            [cell setupInfoWithImgVArr:@[banner.picture]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak typeof(self) weakSelf = self;
        cell.adTapHandle = ^(NSInteger index){
            [weakSelf adCellTapWithIndexPath:indexPath withAdArrIndex:index];
        };
        return cell;
    }
    
    if (indexPath.section == 2) {
        static NSString *GlobalBuyHomeProductCellID = @"GlobalBuyHomeProductCellID";
        GlobalBuyHomeProductCell * cell = [_tableView dequeueReusableCellWithIdentifier:GlobalBuyHomeProductCellID];
        if (cell == nil) {
            cell = [[GlobalBuyHomeProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GlobalBuyHomeProductCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupInfoWithProductForListDataArr:_homeData.productList];
        cell.productTapHandle = ^(NSInteger index){
            [self RecommendForYouProductItem:index];
        };
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return FitHeight(950.0);
    }
    if (indexPath.section == 1) {
        return FitHeight(230.0);
    }
    if (indexPath.section == 2) {
        return FitHeight(460.0);
    }
    return 0;
}

#pragma mark - buttonAciton  handle
- (void)progressLeftSignInButton{
    [self.navigationController popViewControllerAnimated:true];
}



-(void)progressRightButton{
    MessageCenterViewController *messageCenterVC = [[MessageCenterViewController alloc] init];
    messageCenterVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageCenterVC animated:true];
}

-(void)globalAreaDetailHandleWithIndex:(NSInteger)index{
    GlobalAreaData *data = _homeData.globalList[index];
    GlobalAreaDetailController *detailVC = [[GlobalAreaDetailController alloc]initWithAreaId:data.area_id titleName:data.name];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:true];
}

//为你推荐
-(void)RecommendForYouProductItem:(NSInteger)index{
    if ( _homeData.productList.count == 0) {
        return;
    }
    ProductForListData *item = _homeData.productList[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

//中间广告点击
-(void)adCellTapWithIndexPath:(NSIndexPath *)indexPath withAdArrIndex:(NSInteger)index{
    if (_homeData != nil && _homeData.globalMiddleBanner.count > 0) {
        CurrentFashionData *banner = _homeData.globalMiddleBanner[0];
        if (banner.type == BannerProduct) {//跳转到商品
            SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:banner.typeValue];
            singleItemVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:singleItemVC animated:true];
            return ;
        }
        if (banner.type == BannerWeb) {//跳转到网站
            WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:banner.typeValue NavTitle:@""];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:true];
            return ;
        }
        if (banner.type == BannerSubObject) {//跳转到专题
            SubjectDetailController *subJectVC = [[SubjectDetailController alloc]initWithSubjectId:banner.typeValue];
            subJectVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:subJectVC animated:true];
            return ;
        }
        if (banner.type == BannerClsaaify) {
            ScreenProductController *listVC = [[ScreenProductController alloc]initWithScreenProductStyle:ClassficationType andclassifyLevel:banner.classifyLevel andItemId:banner.typeValue];
            listVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:listVC animated:true];
            return ;
        }
    }
}

@end
