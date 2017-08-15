//
//  UserCenterLastCell.m
//  DuoSet
//
//  Created by Wong Mr on 2016/12/13.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "UserCenterLastCell.h"
#import "ViewControllerRecommendToYouCollectionViewCell.h"
#import "RecommendForYouProductsDataModel.h"
@interface UserCenterLastCell() <UICollectionViewDataSource, UICollectionViewDelegate>
@end
@implementation UserCenterLastCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initViews];
        if (!_dataArray) {
            _dataArray = [[NSMutableArray alloc] init];
        }
    }
    [_collectionView reloadData];
    return self;
}

- (void) initViews{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 270) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 6;
    
    layout.itemSize = CGSizeMake((mainScreenWidth-6)/2, (_collectionView.frame.size.height-50*AdapterHeight()-6*AdapterHeight())/2-6*AdapterHeight());
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake((mainScreenWidth-5)/2, 130);
    [self.contentView addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[ViewControllerRecommendToYouCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

-(void)setupInfoWithDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewControllerRecommendToYouCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    RecommendForYouProductsDataModel *model = _dataArray[indexPath.row];
    // 商品图片
    // 商品描述
    cell.productsRecommendDetailLabel.text = model.name;
    // 商品价格
    cell.productsRecommendPriceLabel.text = [NSString stringWithFormat:@"¥ %ld", model.price];
    // 付款人数
    cell.productsRecommendPerSonNumLabel.text = [NSString stringWithFormat:@"%ld", model.soldAmout];
    return cell;
}

@end
