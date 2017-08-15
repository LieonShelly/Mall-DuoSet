//
//  DesignerProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerProductListCell.h"
#import "DeserProductCollectionCell.h"
#import "DesignerProductData.h"

@interface DesignerProductListCell()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *items;

@end

@implementation DesignerProductListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(FitWith(24.0), 0, mainScreenWidth - FitWith(48.0), FitHeight(430.0) * 4) collectionViewLayout:flowLayout];
        flowLayout.minimumInteritemSpacing = 5;
        
        flowLayout.itemSize = CGSizeMake((mainScreenWidth - FitWith(48.0) - 5)/2, FitHeight(430.0));
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = LGBgColor;
        [_collectionView registerClass:[DeserProductCollectionCell class] forCellWithReuseIdentifier:@"DeserProductCollectionCellID"];
        [self.contentView addSubview:_collectionView];
    }
    return self;
}

-(void)setupInfoWithDesignerProductDataArr:(NSMutableArray *)items{
    _items = items;
    _collectionView.frame = CGRectMake(FitWith(24.0), 0,  mainScreenWidth - FitWith(48.0),(FitHeight(430.0) * (_items.count + 1) / 2) + FitHeight(90.0));
    [_collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DeserProductCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DeserProductCollectionCellID" forIndexPath:indexPath];
    DesignerProductData *item = _items[indexPath.row];
    [cell setupInfoWithDesignerProductData:item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DesignerDetailsBlock block = _detailsHandle;
    if (block) {
        block(indexPath.row);
    }
}

@end
