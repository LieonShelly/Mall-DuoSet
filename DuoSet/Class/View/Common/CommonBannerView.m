//
//  CommonBannerView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommonBannerView.h"
#import "SDCycleScrollView.h"

@interface CommonBannerView()<SDCycleScrollViewDelegate>

@property(nonatomic,strong) SDCycleScrollView *headerImgV;

@end

static NSInteger autoScrollTime = 3;

@implementation CommonBannerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headerImgV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, mainScreenWidth, frame.size.height) delegate:self placeholderImage:placeholderImageSize(750, 300)];
        _headerImgV.backgroundColor = [UIColor whiteColor];
        _headerImgV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headerImgV.pageDotColor = [UIColor whiteColor];
        _headerImgV.currentPageDotColor = [UIColor mainColor];
        _headerImgV.autoScrollTimeInterval = autoScrollTime;
        [self addSubview:_headerImgV];
    }
    return self;
}

-(void)setupInfoWithImgVArr:(NSArray *)urlImgArr{
    _headerImgV.imageURLStringsGroup = urlImgArr;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DetailImgChickBlock block = _imgTapHandle;
    if (block) {
        block(index);
    }
}


@end
