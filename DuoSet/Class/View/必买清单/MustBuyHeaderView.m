//
//  MustBuyHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuyHeaderView.h"
#import "MustBuyBigView.h"
#import "MustBuySmallView.h"

@interface MustBuyHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) NSMutableArray *bigViews;
@property(nonatomic,strong) UIView *smallBgView;
@property(nonatomic,strong) NSMutableArray *smallViews;
@property(nonatomic,strong) NSArray *buyListTypeArr;

@end

@implementation MustBuyHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bigViews = [NSMutableArray array];
        _smallViews = [NSMutableArray array];
        
        for (int i = 0; i < 2; i++) {
            MustBuyBigView *view = [MustBuyBigView newAutoLayoutView];
            view.layer.cornerRadius = 3;
            view.layer.masksToBounds = true;
            view.userInteractionEnabled = true;
            view.tag = i;
            [_bigViews addObject:view];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigViewTapAction:)];
            [view addGestureRecognizer:tap];
            [self addSubview:view];
        }
        
        _smallBgView = [UIView newAutoLayoutView];
        _smallBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_smallBgView];
        
        
        for (int i = 0 ; i < 4; i++) {
            MustBuySmallView *view = [MustBuySmallView newAutoLayoutView];
            view.layer.cornerRadius = 3;
            view.layer.masksToBounds = true;
            view.userInteractionEnabled = true;
            view.tag = i;
            [_smallViews addObject:view];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(smallViewTapAction:)];
            [view addGestureRecognizer:tap];
            [_smallBgView addSubview:view];
        }
        
        [self updateConstraints];
    }
    return self;
}

-(void)bigViewTapAction:(UITapGestureRecognizer *)tap{
    BigViewTapAcitonBlock block = _bigViewHandle;
    if (block) {
        block(tap.view.tag);
    }
}

-(void)smallViewTapAction:(UITapGestureRecognizer *)tap{
    if (tap.view.tag >= _buyListTypeArr.count) {
        return;
    }
    for (int i = 0 ; i < _buyListTypeArr.count; i++) {
        MustBuySmallView *view = _smallViews[i];
        view.markView.backgroundColor = i == tap.view.tag ? [[UIColor colorFromHex:0xEd5353] colorWithAlphaComponent:0.4] : [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    SmallViewTapAcitonBlock block = _smallViewHandle;
    if (block) {
        block(tap.view.tag);
    }
}

-(void)setupInfoWithMustBuyHomeData:(MustBuyHomeData *)item{
    _buyListTypeArr = item.buyListType;
    for (int i = 0 ; i < item.recommend.count; i++) {
        MustBuyBigView *view = _bigViews[i];
        MustBuyRecommendData *data = item.recommend[i];
        [view setupInfoWithMustBuyRecommendData:data];
    }
    for (int i = 0; i < item.buyListType.count; i++) {
        MustBuySmallView *view = _smallViews[i];
        MustBuyListTypeData *data = item.buyListType[i];
        [view setupInfoWithMustBuyListTypeData:data];
        view.markView.backgroundColor = i == 0 ? [[UIColor colorFromHex:0xEd5353] colorWithAlphaComponent:0.4] : [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        for (int i = 0; i < 2; i++) {
            MustBuyBigView *view = _bigViews[i];
            [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
            [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0) + FitWith(356.0) * i];
            [view autoSetDimension:ALDimensionWidth toSize:FitWith(346.0)];
            [view autoSetDimension:ALDimensionHeight toSize:FitHeight(300.0)];
        }
        
        [_smallBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_smallBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_smallBgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        [_smallBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(200.0)];
        
        
        for (int i = 0; i < 4; i++) {
            MustBuySmallView *view = _smallViews[i];
            [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
            [view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
            [view autoSetDimension:ALDimensionWidth toSize:FitWith(168.0)];
            [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0) + FitWith(178.0) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
