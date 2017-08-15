//
//  HomeHeaderView.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "ViewControllerClassificationCollectionViewCell.h"

static NSInteger autoScrollTime = 3;

@interface HomeHeaderView()<SDCycleScrollViewDelegate,UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) SDCycleScrollView *banner;
//@property(nonatomic,strong) UIImageView *headerImgV;
@property(nonatomic,strong) UICollectionView *classificationCollectionViews;
@property(nonatomic,strong) HomeMainData *item;

@end

@implementation HomeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(420.0)) delegate:self placeholderImage:placeholderImageSize(750, 420)];
        _banner.backgroundColor = [UIColor whiteColor];
        _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _banner.pageDotColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _banner.currentPageDotColor = [UIColor whiteColor];
        _banner.autoScrollTimeInterval = autoScrollTime;
        [self addSubview:_banner];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(SCREEN_SIZE.width / 4.0, FitHeight(170.0));
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _classificationCollectionViews = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _banner.frame.origin.y + _banner.frame.size.height, mainScreenWidth, frame.size.height - FitHeight(420.0)) collectionViewLayout:flowLayout];
        _classificationCollectionViews.dataSource = self;
        _classificationCollectionViews.delegate = self;
        _classificationCollectionViews.backgroundColor = [UIColor clearColor];
        [_classificationCollectionViews registerClass:[ViewControllerClassificationCollectionViewCell class] forCellWithReuseIdentifier:@"ViewControllerClassificationCollectionViewCellIdentifier"];
        [self addSubview:_classificationCollectionViews];
    }
    return self;
}

-(void)setupInfoWithHomeMainData:(HomeMainData *)item{
    _item = item;
    NSMutableArray *bannerImgArr = [NSMutableArray array];
    for (HomeTopBanner *banner in item.homePageTopBanner) {
        [bannerImgArr addObject:banner.picture];
    }
    [_banner setImageURLStringsGroup:bannerImgArr];
    [_classificationCollectionViews reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (_item == nil) {
        return 0;
    }
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _item.appNavIcons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ViewControllerClassificationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ViewControllerClassificationCollectionViewCellIdentifier" forIndexPath:indexPath];
    NavIconData *it = _item.appNavIcons[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:it.titleIcon] placeholderImage:placeholderImageSize(170, 170) options:0];
    cell.imageViewLabel.text = it.title;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HeaderViewClassifierBlock block = _classChickHandle;
    if (block) {
        block(indexPath.row);
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    BannerActionBlcok block =  _bannerHandle;
    if (block) {
        block(index);
    }
}

-(void)singleTap:(UITapGestureRecognizer *)tap{
    HeaderViewAdActionBlock block = _adTapHandle;
    if (block) {
        block();
    }
}

@end
