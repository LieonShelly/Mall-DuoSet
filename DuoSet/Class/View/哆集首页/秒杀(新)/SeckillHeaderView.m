//
//  SeckillHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillHeaderView.h"
#import "SeckillHeaderBtnView.h"
#import "RobSessionData.h"

@interface SeckillHeaderView()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *bgScroll;
@property(nonatomic,strong) NSMutableArray *headerBtnViewArr;
@property(nonatomic,strong) NSMutableArray *items;
@property(nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation SeckillHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xfff5f7];
        
        _bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, FitHeight(102.0))];
        _bgScroll.delegate = self;
        _bgScroll.scrollEnabled = false;
        _bgScroll.showsHorizontalScrollIndicator = false;
        _bgScroll.showsVerticalScrollIndicator = false;
        [self addSubview:_bgScroll];
    }
    return self;
}

-(void)setupInfoWithRobSessionDataArr:(NSMutableArray *)items{
    if (_headerBtnViewArr.count > 0) {
        for (SeckillHeaderBtnView *btnView in _headerBtnViewArr) {
            [btnView removeFromSuperview];
        }
    }
    
    _bgScroll.contentSize = CGSizeMake(items.count * (mainScreenWidth * 0.2), 0);
    
    _headerBtnViewArr = [NSMutableArray array];
    for (int i = 0; i < items.count; i++) {
        SeckillHeaderBtnView *btnView = [[SeckillHeaderBtnView alloc]initWithFrame:CGRectMake((mainScreenWidth * 0.2) * i, -64,mainScreenWidth * 0.2 , FitHeight(102.0))];
        [_bgScroll addSubview:btnView];
        btnView.tag = i;
        [_headerBtnViewArr addObject:btnView];
        RobSessionData *item = items[i];
        [btnView setupInfoWithRobSessionData:item];
        btnView.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnViewTapAction:)];
        [btnView addGestureRecognizer:tap];
    }
}

-(void)btnViewTapAction:(UITapGestureRecognizer *)tap{
    SeckillHeaderViewBtnViewAtionBlock block = _btnViewHandle;
    if (block) {
        block(tap.view.tag);
    }
    [self setupSeletcedWithIndex:tap.view.tag];
}

-(void)setupSeletcedWithIndex:(NSInteger)index{
    for (int i = 0; i < _headerBtnViewArr.count; i++) {
        SeckillHeaderBtnView *btnView = _headerBtnViewArr[i];
        [btnView showWithSeletced:i == index];
    }
}

@end
