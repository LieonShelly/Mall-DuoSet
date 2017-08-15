//
//  GlobalAdCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalAdCell.h"
#import "SDCycleScrollView.h"

@interface GlobalAdCell()<SDCycleScrollViewDelegate>

@property(nonatomic,strong) SDCycleScrollView *headerImgV;

@end

static NSInteger autoScrollTime = 3;

@implementation GlobalAdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _headerImgV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(230.0)) delegate:self placeholderImage:[UIImage imageNamed:@"placeholderImage16_9.jpg"]];
        _headerImgV.backgroundColor = [UIColor whiteColor];
        [_headerImgV setLocalizationImageNamesGroup:@[@"替代1"]];
        _headerImgV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headerImgV.pageDotColor = [UIColor whiteColor];
        _headerImgV.currentPageDotColor = [UIColor mainColor];
        _headerImgV.autoScrollTimeInterval = autoScrollTime;
        [self addSubview:_headerImgV];
        
    }
    return self;
}

-(void)setupInfoWithImgVArr:(NSArray *)imgvArr{
    _headerImgV.imageURLStringsGroup = imgvArr;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    GlobalAdCellBlock block = _adTapHandle;
    if (block) {
        block(index);
    }
}

@end
