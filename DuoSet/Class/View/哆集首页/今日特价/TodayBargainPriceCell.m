//
//  TodayBargainPriceCell.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TodayBargainPriceCell.h"
#import "TodayBargainPriceCollectionCell.h"

@interface TodayBargainPriceCell()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation TodayBargainPriceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(FitWith(30.0), 0, mainScreenWidth - FitWith(60.0), FitHeight(620.0) * 4 + FitHeight(40.0)) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        flowLayout.minimumLineSpacing = 3;
        flowLayout.minimumInteritemSpacing = 3;
        
        flowLayout.itemSize = CGSizeMake((mainScreenWidth - FitWith(60.0)-4)/2, FitHeight(620.0));
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 0, 2, 0);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[TodayBargainPriceCollectionCell class] forCellWithReuseIdentifier:@"TodayBargainPriceCollectionCellIdentifier"];
        [self.contentView addSubview:_collectionView];
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TodayBargainPriceCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TodayBargainPriceCollectionCellIdentifier" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TodayBargainPriceCellBlock block = _cellHandle;;
    if (block) {
        block(indexPath.row);
    }
}

@end
