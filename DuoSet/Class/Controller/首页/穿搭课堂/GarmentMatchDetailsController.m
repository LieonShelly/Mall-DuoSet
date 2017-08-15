//
//  GarmentMatchDetailsController.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GarmentMatchDetailsController.h"
#import "SingleProductNewController.h"
#import "MatchDetailsHeadeCell.h"
#import "MKJTagViewTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "SKTagButton.h"
#import "MatchDetailsPicsCell.h"
#import "CommonRecommendForYouCell.h"
//Data
#import "MatchDetailsData.h"

@interface GarmentMatchDetailsController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,copy) NSString *matchId;
@property(nonatomic,strong) UIView *navView;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) MatchDetailsData *itemData;

@end

static NSString *identyfy = @"MKJTagViewTableViewCell";

@implementation GarmentMatchDetailsController

-(instancetype)initWithMatchId:(NSString *)matchId{
    self = [super init];
    if (self) {
        _matchId = matchId;
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"搭配详情";
    [self configUI];
    [self configData];
}

-(void)configData{
    NSString *urlStr = @"";
    urlStr = [NSString stringWithFormat:@"match/%@",_matchId];
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {//MatchDetailsData *itemData
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objectDic = [responseDic objectForKey:@"object"];
                _itemData = [MatchDetailsData dataForDictionary:objectDic];
            }
            [_tableView reloadData];
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)configUI{
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableView.showsVerticalScrollIndicator = false;
    [_tableView registerNib:[UINib nibWithNibName:identyfy bundle:nil] forCellReuseIdentifier:identyfy];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _itemData == nil ? 0 : 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 2;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *MatchDetailsHeadeCellID = @"MatchDetailsHeadeCellID";
            MatchDetailsHeadeCell * cell = [_tableView dequeueReusableCellWithIdentifier:MatchDetailsHeadeCellID];
            if (cell == nil) {
                cell = [[MatchDetailsHeadeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MatchDetailsHeadeCellID];
            }
            [cell setupInfoWithTitle:_itemData.name andContent:_itemData.descr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 1) {
            MKJTagViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identyfy forIndexPath:indexPath];
            [self configCell:cell indexpath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        if (indexPath.row == 2) {
            static NSString *MatchDetailsHeadeCellID = @"MatchDetailsHeadeCellID";
            MatchDetailsPicsCell * cell = [_tableView dequeueReusableCellWithIdentifier:MatchDetailsHeadeCellID];
            if (cell == nil) {
                cell = [[MatchDetailsPicsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MatchDetailsHeadeCellID];
            }
            __weak typeof(self) weakSelf = self;
            cell.dressupHandle = ^(NSInteger index){
                [weakSelf matchTapIndex:index];
            };
            [cell setupIndoWithMatchDetailsData:_itemData];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *MatchDetailsHeadeCellID = @"MatchDetailsHeadeCellID";
            MatchDetailsHeadeCell * cell = [_tableView dequeueReusableCellWithIdentifier:MatchDetailsHeadeCellID];
            if (cell == nil) {
                cell = [[MatchDetailsHeadeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MatchDetailsHeadeCellID];
            }
            [cell setupInfoWithTitle:@"还可以这样搭配" andContent:_itemData.moreDescr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)configCell:(MKJTagViewTableViewCell *)cell indexpath:(NSIndexPath *)indexpath
{
    [cell.tagView removeAllTags];
    cell.tagView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width;
    cell.tagView.padding = UIEdgeInsetsMake(0, FitWith(20), FitHeight(20), FitWith(20));
    cell.tagView.lineSpacing = 10;
    cell.tagView.interitemSpacing = FitWith(28.0);
    cell.tagView.singleLine = NO;
    
    [_itemData.tag enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SKTag *tag = [[SKTag alloc] initWithText:_itemData.tag[idx]];
        tag.font = [UIFont systemFontOfSize:13];
        tag.textColor = [UIColor colorFromHex:0x666666];
        tag.bgColor =[UIColor whiteColor];
        tag.cornerRadius = FitWith(46.0) * 0.5;
        tag.borderColor = [UIColor colorFromHex:0x666666];
        tag.borderWidth = 1;
        tag.enable = true;
        tag.padding = UIEdgeInsetsMake(5, 10, 5, 10);
        [cell.tagView addTag:tag];
    }];
    
    cell.tagView.didTapTagAtIndex = ^(NSUInteger index,UIButton *btn,NSArray *tagBtns){
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return _itemData.headerDesHight + FitHeight(120.0);
        }
        if (indexPath.row == 1) {
            return  [tableView fd_heightForCellWithIdentifier:identyfy configuration:^(id cell) {
                [self configCell:cell indexpath:indexPath];
            }];
        }
        if (indexPath.row == 2) {
            return FitHeight(500);
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return _itemData.subDesHight + FitHeight(120.0);
        }
        if (indexPath.row == 1) {
            return (FitHeight(600.0) + 3) * ((_itemData.productList.count + 1) / 2);
        }
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return FitHeight(20.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(void)matchTapIndex:(NSInteger)index{
    if (index == 0) {
        ScanPictureViewController *picVC = [[ScanPictureViewController alloc]initWithPhotosUrl:@[_itemData.picture] WithCurrentIndex:0];
        [self.navigationController presentViewController:picVC animated:true completion:nil];
        return;
    }
    NSString *productNum = @"";
    if (index == 1) {
        productNum = _itemData.productEntityOne.productNumber;
    }
    if (index == 2) {
        productNum = _itemData.productEntityTwo.productNumber;
    }
    if (index == 3) {
        productNum = _itemData.productEntityThree.productNumber;
    }
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:productNum];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

-(void)RecommendForYouProductItem:(NSInteger)index{
    HomeMatchProductData *item = _itemData.productList[index];
    SingleProductNewController *singleItemVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price];
    singleItemVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:singleItemVC animated:true];
}

@end
