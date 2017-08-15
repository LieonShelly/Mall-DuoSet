//
//  AttentionViewController.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/7.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "AttentionViewController.h"
#import "SingleProductNewController.h"
#import "TodayRecommendSectionView.h"
#import "DesignerDetailsController.h"
#import "HaveGoodProductCell.h"
#import "DesigningCell.h"
#import "CollectionDesigerCell.h"
//data
#import "ProductForListData.h"
#import "DesignerProductData.h"
#import "DesignerData.h"

typedef enum : NSUInteger {
    CollectionDataWithProduct,
    CollectionDataWithDesigeProduct,
    CollectionDataWithDesiger
}CollectionDataType;


@interface AttentionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong) TodayRecommendSectionView *sectionView;
@property (nonatomic, copy) NSMutableArray *collectionDataArray;

@property (nonatomic,assign) CollectionDataType collectionStatus;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger limit;
@property (nonatomic,assign) NSInteger lastRequsetCount;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;

@end

@implementation AttentionViewController

#pragma mark - viewWillAppear & viewWillDisappear & viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏关注";
    [self creatUI];
    _collectionStatus = CollectionDataWithProduct;
    _page = 0;
    _limit = 10;
    _lastRequsetCount = 0;
    [self getCollectCount];
    [self getAttentionData:true];
}

-(void)getCollectCount{
    [RequestManager requestWithMethod:GET WithUrlPath:@"product/collect/count" params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                NSString *product = @"";
                NSString *designer = @"";
                NSString *works = @"";
                if ([objDic objectForKey:@"sku"]) {
                    product = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"sku"]];
                }
                if ([objDic objectForKey:@"designer"]) {
                    designer = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"designer"]];
                }
                if ([objDic objectForKey:@"works"]) {
                    works = [NSString stringWithFormat:@"%@",[objDic objectForKey:@"works"]];
                }
                NSMutableArray *arr = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"商品收藏(%@)",product],[NSString stringWithFormat:@"作品收藏(%@)",works],[NSString stringWithFormat:@"设计师(%@)",designer], nil];
                if (_sectionView == nil) {
                    [self.tableView reloadData];
                }
                [_sectionView resetSectionViewTitleNameWithNameArr:arr];
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)getAttentionData:(BOOL)clear{
    NSString *urlStr = @"";
    if (_collectionStatus == CollectionDataWithProduct) {
        urlStr = [NSString stringWithFormat:@"product/collect/sku?page=%ld&limit=%ld",_page,_limit];
    }
    if (_collectionStatus == CollectionDataWithDesigeProduct) {
        urlStr = [NSString stringWithFormat:@"designer/works/myCollect?page=%ld&limit=%ld",_page,_limit];
    }
    if (_collectionStatus == CollectionDataWithDesiger) {
        urlStr = [NSString stringWithFormat:@"designer/designer/myCollect?page=%ld&limit=%ld",_page,_limit];
    }
    [RequestManager requestWithMethod:GET WithUrlPath:urlStr params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if (clear) {
                _collectionDataArray = [NSMutableArray array];
            }
            if (_collectionStatus == CollectionDataWithProduct) {//
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *objDic = [responseDic objectForKey:@"object"];
                    if ([objDic objectForKey:@"collect"] && [[objDic objectForKey:@"collect"] isKindOfClass:[NSArray class]]) {
                        NSArray *arr = [objDic objectForKey:@"collect"];
                        _lastRequsetCount = arr.count;
                        for (NSDictionary *d in arr) {
                            ProductForListData *item = [ProductForListData dataForDictionary:d];
                            [_collectionDataArray addObject:item];
                        }
                    }
                }
            }else{
                if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSArray class]]) {
                    NSArray *objArr = [responseDic objectForKey:@"object"];
                    _lastRequsetCount = objArr.count;
                if (_collectionStatus == CollectionDataWithDesigeProduct) {
                    for (NSDictionary *d in objArr) {
                        DesignerProductData *item = [DesignerProductData dataForDictionary:d];
                        [_collectionDataArray addObject:item];
                    }
                }
                if (_collectionStatus == CollectionDataWithDesiger) {
                    for (NSDictionary *dic in objArr) {
                        DesignerData *item = [DesignerData dataForDictionary:dic];
                        [_collectionDataArray addObject:item];
                        }
                    }
                }
            }
            [_tableView.mj_footer endRefreshing];
            [_tableView reloadData];
            [self showDefeatedView:_collectionDataArray.count == 0];
        }
    } fail:^(NSError *error) {
        [_tableView.mj_footer endRefreshing];
        //
    }];
}

- (void) creatUI{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = false;
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (_lastRequsetCount < _limit) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        _page += 1;
        [self getAttentionData:false];
    }];
}

#pragma 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _collectionDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{//HaveGoodProductCell
    if (_collectionStatus == CollectionDataWithProduct) {
        static NSString *AttentionProductCellID = @"AttentionProductCellID";
        HaveGoodProductCell * cell = [tableView dequeueReusableCellWithIdentifier:AttentionProductCellID];
        if (cell == nil) {
            cell = [[HaveGoodProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AttentionProductCellID];
        }
        ProductForListData *item  = _collectionDataArray[indexPath.row];
        [cell setupInfoWithProductForListData:item];
        cell.buyBtn.hidden = true;
        cell.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (_collectionStatus == CollectionDataWithDesigeProduct) {
        static NSString *DesigningCellID = @"DesigningCellID";
        DesigningCell * cell = [tableView dequeueReusableCellWithIdentifier:DesigningCellID];
        if (cell == nil) {
            cell = [[DesigningCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DesigningCellID];
        }
        DesignerProductData *item = _collectionDataArray[indexPath.row];
        [cell setupInfoWithDesignerProductData:item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.likeBtn.hidden = true;
        return cell;
    }
    if (_collectionStatus == CollectionDataWithDesiger) {
        static NSString *CollectionDesigerCellID = @"CollectionDesigerCellID";
        CollectionDesigerCell * cell = [tableView dequeueReusableCellWithIdentifier:CollectionDesigerCellID];
        if (cell == nil) {
            cell = [[CollectionDesigerCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CollectionDesigerCellID];
        }
        DesignerData *item = _collectionDataArray[indexPath.row];
        [cell setupInfoWithDesignerData:item];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_collectionStatus == CollectionDataWithProduct) {
        return FitHeight(320.0);
    }
    if (_collectionStatus == CollectionDataWithDesigeProduct) {
        DesignerProductData *item = _collectionDataArray[indexPath.row];
        return item.cellHight;
    }
    if (_collectionStatus == CollectionDataWithDesiger) {
        return FitHeight(220.0);
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return FitHeight(100.0);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_sectionView != nil) {
        return _sectionView;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"商品收藏",@"作品收藏",@"设计师", nil];
    _sectionView = [[TodayRecommendSectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(100.0)) andBtnNameArr:arr];
    __weak typeof(self) weakSelf = self;
    _sectionView.btnActionHandle = ^(NSInteger index){
        _page = 0;
        _lastRequsetCount = 0;
        _collectionStatus = index;
        [weakSelf getAttentionData:true];
    };
    return _sectionView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_collectionStatus == CollectionDataWithProduct) {
        ProductForListData *item = _collectionDataArray[indexPath.row];
        SingleProductNewController *itemDetailVC = [[SingleProductNewController alloc]initWithProductId:item.productNumber andCover:item.cover productTitle:item.productName productPrice:item.price andPropertyCollection:item.propertyCollection];
        itemDetailVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:itemDetailVC animated:true];
    }
    if (_collectionStatus == CollectionDataWithDesigeProduct) {
        DesignerProductData *item = _collectionDataArray[indexPath.row];
        WebPageController *webVC = [[WebPageController alloc]initWithUrlStr:[NSString stringWithFormat:@"%@designer/works/%@",BaseUrl,item.obj_id] NavTitle:@"" ShowRightBtn:true];
        webVC.hidesBottomBarWhenPushed = true;
        webVC.isFromDesignerDetails = true;
        webVC.designerProductData = item;
        [self.navigationController pushViewController:webVC animated:true];
    }
    if (_collectionStatus == CollectionDataWithDesiger) {
        DesignerData *item = _collectionDataArray[indexPath.row];
        DesignerDetailsController *deserDetailsVC = [[DesignerDetailsController alloc]initWithDesignerId:item.designer_id];
        deserDetailsVC.hidesBottomBarWhenPushed = true;
        [self.navigationController pushViewController:deserDetailsVC animated:true];
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    return @"删除";
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteItem:indexPath];
    }
}

-(void)deleteItem:(NSIndexPath *)indexPath{
    if (_collectionStatus == CollectionDataWithProduct) {
        ProductForListData *item  = _collectionDataArray[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:@[item.propertyCollection] forKey:@"propertyCollections"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"product/collect/cancel/sku" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [self getCollectCount];
                [_collectionDataArray removeObjectAtIndex:indexPath.row];
                [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                if (_collectionDataArray.count == 0) {
                    [self showDefeatedView:true];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
    if (_collectionStatus == CollectionDataWithDesigeProduct) {
        DesignerProductData *item = _collectionDataArray[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.obj_id forKey:@"id"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/works/collectCancel" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [self getCollectCount];
                [_collectionDataArray removeObjectAtIndex:indexPath.row];
                [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                if (_collectionDataArray.count == 0) {
                    [self showDefeatedView:true];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
    if (_collectionStatus == CollectionDataWithDesiger) {
        DesignerData *item = _collectionDataArray[indexPath.row];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setObject:item.designer_id forKey:@"id"];
        [RequestManager requestWithMethod:POST WithUrlPath:@"designer/designer/collectCancel" params:params from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
            NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
            if ([resultCode isEqualToString:@"ok"]) {
                [self getCollectCount];
                [_collectionDataArray removeObjectAtIndex:indexPath.row];
                [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
                if (_collectionDataArray.count == 0) {
                    [self showDefeatedView:true];
                }
            }
        } fail:^(NSError *error) {
            //
        }];
    }
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, 64 + FitHeight(100.0), mainScreenWidth, mainScreenHeight - 64 - FitHeight(100.0)) andDefeatedImageName:@"defeated_no_order" messageName:@"你暂时还没有收藏记录哦~" backBlockBtnName:nil backBlock:^{
                
            }];
            [self.view addSubview:_defeatedView];
            [self.view bringSubviewToFront:_defeatedView];
        }else{
            _defeatedView.hidden = false;
        }
    }else{
        _defeatedView.hidden = true;
    }
}

@end
