//
//  GlobalAreaDetailController.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalAreaDetailController.h"
#import "SingleProductNewController.h"
#import "ShoppingCartViewController.h"

#import "GlobalBuyProductCell.h"
#import "GlobalBuyDetailSectionView.h"
#import "GloballistData.h"
#import "ProductForListData.h"

@interface GlobalAreaDetailController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,copy) NSString *area_id;
@property(nonatomic,copy) NSString *titleName;
@property(nonatomic,strong) NSMutableArray *listItems;
@property(nonatomic, strong) UILabel *unreadLabel;
@property(nonatomic,strong) CommonDefeatedView *defeatedView;
@end

@implementation GlobalAreaDetailController

-(instancetype)initWithAreaId:(NSString *)area_id titleName:(NSString *)titleName{
    self = [super init];
    if (self) {
        _area_id = area_id;
        _titleName = titleName;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleName;
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    [self configData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getSopCartNumber];
}

-(void)configData{
    [RequestManager requestWithMethod:GET WithUrlPath:[NSString stringWithFormat:@"product/global/%@",_area_id] params:nil from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {//
            _listItems = [NSMutableArray array];
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"]isKindOfClass:[NSDictionary class]]) {
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"global"] && [[objDic objectForKey:@"global"] isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *globalDic = [objDic objectForKey:@"global"];
                    if ([globalDic objectForKey:@"subList"] && [[globalDic objectForKey:@"subList"] isKindOfClass:[NSArray class]]) {
                        NSArray *items = [globalDic objectForKey:@"subList"];
                        for (NSDictionary *d in items) {
                            GloballistData *item = [GloballistData dataForDictionary:d];
                            [_listItems addObject:item];
                        }
                    }
                }
            }
            [_collectionView reloadData];
            [self showDefeatedView:_listItems.count == 0];
        }
    } fail:^(NSError *error) {
        //
    }];
}

- (void)configUI{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth - 44, 20, 44, 44)];
    [btn setImage:[UIImage imageNamed:@"product_detail_shopcart"] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
    [btn addTarget:self action:@selector(rightButtonAciton) forControlEvents:UIControlEventTouchUpInside];
  
    self.unreadLabel = [UILabel new];
    self.unreadLabel.backgroundColor = [UIColor mainColor];
    self.unreadLabel.textColor = [UIColor whiteColor];
    self.unreadLabel.layer.cornerRadius = 9;
    self.unreadLabel.layer.masksToBounds = true;
    self.unreadLabel.font = [UIFont systemFontOfSize:13];
    self.unreadLabel.frame = CGRectMake(44 - 15, 5, 18, 18);
    self.unreadLabel.textAlignment = NSTextAlignmentCenter;
    self.unreadLabel.hidden = true;
      [btn addSubview:self.unreadLabel];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
    self.view.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((mainScreenWidth-4)/2, FitHeight(600.0));
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 4;
    flowLayout.minimumInteritemSpacing = 4;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = false;
    _collectionView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
    [_collectionView registerClass:[GlobalBuyProductCell class] forCellWithReuseIdentifier:@"GlobalBuyProductCellID"];
    [flowLayout setHeaderReferenceSize:CGSizeMake(mainScreenWidth, FitHeight(340.0))];
    [flowLayout setFooterReferenceSize:CGSizeMake(0, 0)];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GlobalBuyDetailSectionViewID"];
    [self.view addSubview:_collectionView];
}

-(void)getSopCartNumber{
    [RequestManager requestWithMethod:GET WithUrlPath:@"user/cart/count" params:nil from:self showHud:false loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
            if ([responseDic objectForKey:@"object"] && [[responseDic objectForKey:@"object"] isKindOfClass:[NSDictionary class]]){
                NSDictionary *objDic = [responseDic objectForKey:@"object"];
                if ([objDic objectForKey:@"count"]) {//_footView
                    NSString *count = [objDic objectForKey:@"count"] != [NSNull null] ? [NSString stringWithFormat:@"%@",[objDic objectForKey:@"count"]] : @"0";
                    if (count.integerValue > 0) {
                        self.unreadLabel.hidden = false;
                        self.unreadLabel.text = count.integerValue > 99 ? @"99+" : count;
                        if (count.integerValue > 99) {
                            self.unreadLabel.layer.cornerRadius = 15;
                            self.unreadLabel.frame = CGRectMake(self.unreadLabel.origin.x, self.unreadLabel.origin.y, 30, 30);
                        }
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        //
    }];
}

-(void)showSingleItemDetailWithIndex:(NSInteger)index{
    SingleProductNewController *detailVC = [[SingleProductNewController alloc]init];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:true];
}

- (void)addToShoppingCarWithParam: (NSDictionary*)param {
    [RequestManager requestWithMethod:POST WithUrlPath:@"user/cart" params:param from:self showHud:true loadingText:nil enableUserActions:false success:^(id responseDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[responseDic objectForKey:@"result"]];
        if ([resultCode isEqualToString:@"ok"]) {
        }
    } fail:^(NSError *error) {
        //
    }];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _listItems.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    GloballistData *item = _listItems[section];
    return item.productList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GlobalBuyProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GlobalBuyProductCellID" forIndexPath:indexPath];
    GloballistData *item = _listItems[indexPath.section];
    ProductForListData *product = item.productList[indexPath.row];
    [cell setupInfoWithProductForListData:product];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reuseableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reuseableView  = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GlobalBuyDetailSectionViewID" forIndexPath:indexPath];
        GloballistData *item = _listItems[indexPath.section];
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(320.0))];
        [imgV  sd_setImageWithURL:[NSURL URLWithString:item.picture] placeholderImage:placeholderImageSize(750, 400) options:0];
        [reuseableView addSubview:imgV];
        return reuseableView;
    }
    return reuseableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GloballistData *item = _listItems[indexPath.section];
    ProductForListData *product = item.productList[indexPath.row];
    SingleProductNewController *singleProductVC = [[SingleProductNewController alloc]initWithProductId:product.productNumber andCover:product.cover productTitle:product.productName productPrice:product.price];
    singleProductVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:singleProductVC animated:true];
}

#pragma mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((mainScreenWidth-4)/2, FitHeight(600.0));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)rightButtonAciton{
    ShoppingCartViewController *shopCartVC = [[ShoppingCartViewController alloc]init];
    shopCartVC.isFromPrudoctDetail = true;
    shopCartVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:shopCartVC animated:true];
}

-(void)showDefeatedView:(BOOL)show{
    if (show) {
        if (_defeatedView == nil) {
            __weak typeof(self) weakSelf = self;
            _defeatedView = [[CommonDefeatedView alloc]initWithFrame:CGRectMake(0, FitHeight(100) + 64, mainScreenWidth, mainScreenHeight - 64 - FitHeight(100.0)) andDefeatedImageName:@"defeated_no_find_product" messageName:@"找不到相关商品哦~" backBlockBtnName:nil backBlock:^{
                [weakSelf.navigationController popViewControllerAnimated:true];
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
