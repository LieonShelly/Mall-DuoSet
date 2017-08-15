//
//  CommonRecommendForYouCell.m
//  DuoSet
//
//  Created by mac on 2017/1/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommonRecommendForYouCell.h"
#import "ViewControllerRecommendToYouCollectionViewCell.h"

#import "ProductListData.h"
#import "RecommendListData.h"
#import "HomeMatchProductData.h"
#import "ProductForListData.h"


@interface CommonRecommendForYouCell()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *items;
@property(nonatomic,strong) NSArray *recommendItems;
@property(nonatomic,strong) NSArray *matchProductItems;
@property(nonatomic,strong) NSArray *productForListDatas;

@end

@implementation CommonRecommendForYouCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0) collectionViewLayout:flowLayout];
        flowLayout.minimumLineSpacing = 3;
        flowLayout.minimumInteritemSpacing = 3;
        
        flowLayout.itemSize = CGSizeMake((mainScreenWidth-3)/2, FitHeight(600.0));
//        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = LGBgColor;
        [_collectionView registerClass:[ViewControllerRecommendToYouCollectionViewCell class] forCellWithReuseIdentifier:@"ViewControllerRecommendToYouCollectionViewCellIdentifier"];
        [self.contentView addSubview:_collectionView];
    }
    return self;
}

-(void)setupInfoWithProductListDataArr:(NSArray *)items{//_items
    _items = items;
    _collectionView.frame = CGRectMake(0, 0, mainScreenWidth, (FitHeight(600.0) + 3) * ((_items.count + 1) / 2 ));
    [_collectionView reloadData];
}

-(void)setupInfoWithRecommendListDataArr:(NSArray *)recommendItems{
    _recommendItems = recommendItems;
    _collectionView.frame = CGRectMake(0, 0, mainScreenWidth, (FitHeight(600.0) + 3) * ((_recommendItems.count + 1) / 2 ));
    [_collectionView reloadData];
}

-(void)setupInfoWithHomeMatchProductDataArr:(NSArray *)matchProductItems{
    _matchProductItems = matchProductItems;
    _collectionView.frame = CGRectMake(0, 0, mainScreenWidth, (FitHeight(600.0) + 3) * ((_matchProductItems.count + 1) / 2 ));
    [_collectionView reloadData];
}

-(void)setupInfoWithProductForListDataArr:(NSArray *)productForListDatas{
    _productForListDatas = productForListDatas;
    _collectionView.frame = CGRectMake(0, 0, mainScreenWidth, (FitHeight(600.0) + 3) * ((_productForListDatas.count + 1) / 2 ));
    [_collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_items) {
        return _items.count;
    }
    if (_recommendItems) {
        return _recommendItems.count;
    }
    if (_matchProductItems) {
        return _matchProductItems.count;
    }
    if (_productForListDatas) {
        return _productForListDatas.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewControllerRecommendToYouCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ViewControllerRecommendToYouCollectionViewCellIdentifier" forIndexPath:indexPath];
    if (_items) {
        ProductListData *item = _items[indexPath.row];
        [cell setupInfoWithProductListData:item];
    }
    if (_recommendItems) {
        RecommendListData *item = _recommendItems[indexPath.row];
        [cell setUPInfoWithRecommendListData:item];
    }
    if (_matchProductItems) {
        HomeMatchProductData *item = _matchProductItems[indexPath.row];
        [cell setUPInfoWithHomeMatchProductData:item];
    }
    if (_productForListDatas) {
        ProductForListData *item = _productForListDatas[indexPath.row];
        [cell setUPInfoWithProductForListData:item];
    }
    return cell;
}

-(UICollectionViewFlowLayout *)objectInCollectionViewAtIndex:(NSUInteger)index{
    ProductListData *item = _items[index];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((mainScreenWidth-3)/2, item.imgHight);
    return flowLayout;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RecommendForYouBlock block = _recommendHandle;;
    if (block) {
        block(indexPath.row);
    }
}

@end
