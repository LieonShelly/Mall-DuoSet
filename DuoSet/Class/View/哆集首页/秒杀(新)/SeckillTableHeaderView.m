//
//  SeckillTableHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillTableHeaderView.h"
#import "SDCycleScrollView.h"

@interface SeckillTableHeaderView()<SDCycleScrollViewDelegate>

@property(nonatomic,strong) SDCycleScrollView *headerImgV;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UILabel *hourLable;
@property(nonatomic,strong) UILabel *cutLable;
@property(nonatomic,strong) UILabel *minLable;
@property(nonatomic,strong) UILabel *cutLable2;
@property(nonatomic,strong) UILabel *secLable;


@end

static NSInteger autoScrollTime = 3;

@implementation SeckillTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headerImgV = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(300.0)) delegate:self placeholderImage:placeholderImageSize(750, 300)];
        _headerImgV.backgroundColor = [UIColor whiteColor];
        _headerImgV.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _headerImgV.pageDotColor = [UIColor whiteColor];
        _headerImgV.currentPageDotColor = [UIColor mainColor];
        _headerImgV.autoScrollTimeInterval = autoScrollTime;
        [self addSubview:_headerImgV];
        
        _tipsLable = [[UILabel alloc]initWithFrame:CGRectMake(FitWith(24.0), FitHeight(300.0), FitWith(150.0), FitHeight(70.0))];
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.font = CUSNEwFONT(14);
        [self addSubview:_tipsLable];
        
        _hourLable = [[UILabel alloc]initWithFrame:CGRectMake(_tipsLable.frame.origin.x + _tipsLable.frame.size.width, FitHeight(320.0), FitWith(40.0), FitHeight(30.0))];
        _hourLable.adjustsFontSizeToFitWidth = true;
        _hourLable.textAlignment = NSTextAlignmentCenter;
        _hourLable.backgroundColor = [UIColor blackColor];
        _hourLable.textColor = [UIColor whiteColor];
        _hourLable.font = CUSNEwFONT(16);
        _hourLable.layer.cornerRadius = 2;
        _hourLable.layer.masksToBounds = true;
        [self addSubview:_hourLable];
        
        _cutLable = [[UILabel alloc]initWithFrame:CGRectMake(_hourLable.frame.origin.x + _hourLable.frame.size.width, FitHeight(320.0), FitWith(10.0), FitHeight(30.0))];
        _cutLable.text = @":";
        _cutLable.textAlignment = NSTextAlignmentCenter;
        _cutLable.textColor = [UIColor colorFromHex:0x222222];
        _cutLable.backgroundColor = [UIColor clearColor];
        [self addSubview:_cutLable];
        
        _minLable = [[UILabel alloc]initWithFrame:CGRectMake(_cutLable.frame.origin.x + _cutLable.frame.size.width, FitHeight(320.0), FitWith(40.0), FitHeight(30.0))];
        _minLable.adjustsFontSizeToFitWidth = true;
        _minLable.backgroundColor = [UIColor blackColor];
        _minLable.textAlignment = NSTextAlignmentCenter;
        _minLable.textColor = [UIColor whiteColor];
        _minLable.font = CUSNEwFONT(16);
        _minLable.layer.cornerRadius = 2;
        _minLable.layer.masksToBounds = true;
        [self addSubview:_minLable];

        _cutLable2 = [[UILabel alloc]initWithFrame:CGRectMake(_minLable.frame.origin.x + _minLable.frame.size.width, FitHeight(320.0), FitWith(10.0), FitHeight(30.0))];
        _cutLable2.text = @":";
        _cutLable2.textColor = [UIColor colorFromHex:0x222222];
        _cutLable2.backgroundColor = [UIColor clearColor];
        _cutLable2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cutLable2];

        _secLable = [[UILabel alloc]initWithFrame:CGRectMake(_cutLable2.frame.origin.x + _cutLable2.frame.size.width, FitHeight(320.0), FitWith(40.0), FitHeight(30.0))];
        _secLable.adjustsFontSizeToFitWidth = true;
        _secLable.backgroundColor = [UIColor blackColor];
        _secLable.textAlignment = NSTextAlignmentCenter;
        _secLable.textColor = [UIColor whiteColor];
        _secLable.font = CUSNEwFONT(16);
        _secLable.layer.cornerRadius = 2;
        _secLable.layer.masksToBounds = true;
        [self addSubview:_secLable];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self addSubview:line];
        
    }
    return self;
}

-(void)setupInfoWithImgVArr:(NSArray *)urlImgArr{
    _headerImgV.imageURLStringsGroup = urlImgArr;
}

-(void)setupCutDownLableShowWithHouStr:(NSString *)hourStr minStr:(NSString *)minStr secStr:(NSString *)secStr{
    _hourLable.text = hourStr;
    _minLable.text = minStr;
    _secLable.text = secStr;
}

-(void)setupInfoWithRobSessionData:(RobSessionData *)item{
    if (item.countDown.length == 0) {
        _tipsLable.text = @"秒杀进行中";
        _hourLable.hidden = true;
        _cutLable.hidden = true;
        _minLable.hidden = true;
        _cutLable2.hidden = true;
        _secLable.hidden = true;
    }else{
        _tipsLable.text = item.isInRob ? @"距本场结束" : @"距本场开始";
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    HeaderViewBannerBlock block = _bannerHandle;
    if (block) {
        block(index);
    }
}

@end
