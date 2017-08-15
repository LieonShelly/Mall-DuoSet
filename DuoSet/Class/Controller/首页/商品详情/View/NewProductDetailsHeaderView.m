//
//  NewProductDetailsHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "NewProductDetailsHeaderView.h"
#import "SDCycleScrollView.h"
#import "ProductDetailsSeckillData.h"

@interface NewProductDetailsHeaderView()<SDCycleScrollViewDelegate>

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) SDCycleScrollView *headerImgV;
@end

static NSInteger autoScrollTime = 3;

@implementation NewProductDetailsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _headerImgV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(750.0)) delegate:self placeholderImage:placeholderImageSize(750, 750)];
        _headerImgV.scrollAnimation = false;
        _headerImgV.backgroundColor = [UIColor whiteColor];
        _headerImgV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headerImgV.pageDotColor = [UIColor whiteColor];
        _headerImgV.currentPageDotColor = [UIColor mainColor];
        _headerImgV.autoScroll = false;
//        _headerImgV.autoScrollTimeInterval = autoScrollTime;
        [self addSubview:_headerImgV];
    }
    return self;
}


-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DetailImgChickBlock block = _imgTapHandle;
    if (block) {
        block(index);
    }
}

-(void)setupinfoWithImgArr:(NSArray *)imgArr{
    _headerImgV.imageURLStringsGroup = imgArr;
}

-(void)setupinfoWithProductDetailsData:(ProductDetailsData *)item{
    [_headerImgV setImageURLStringsGroup:item.showPics scrollToFirst:true];
}

@end
