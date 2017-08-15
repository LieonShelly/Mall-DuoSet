//
//  TodayRecommendSectionView.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TodayRecommendSectionView.h"

@interface TodayRecommendSectionView()

@property(nonatomic,strong) NSMutableArray *btnNameArr;
@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) UIView *bottomLine;

@end

@implementation TodayRecommendSectionView

-(instancetype)initWithFrame:(CGRect)frame andBtnNameArr:(NSMutableArray *)btnNameArr{
    self = [super initWithFrame:frame];
    if (self) {
        _btnNameArr = btnNameArr;
        self.backgroundColor = [UIColor whiteColor];
        _btnArr = [NSMutableArray array];
        CGFloat btnW = mainScreenWidth/_btnNameArr.count;
        for (int i = 0; i < _btnNameArr.count; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnW * i, 0, btnW, frame.size.height)];
            [btn setTitle:_btnNameArr[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorFromHex:0x333333] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(choiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = CUSFONT(13);
            btn.tag = i;
            [self addSubview:btn];
            [_btnArr addObject:btn];
            if (i == 0) {
                btn.selected = true;
            }
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height - 0.5, mainScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self addSubview:line];
        
        CGFloat bottomLineW = btnW - FitWith(40.0);
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(FitWith(20.0) , frame.size.height - 0.5 - 2, bottomLineW, 2)];
        _bottomLine.backgroundColor = [UIColor mainColor];
        [self addSubview:_bottomLine];
    }
    return self;
}

-(void)resetSectionViewTitleNameWithNameArr:(NSMutableArray *)nameArr{
    for (int i = 0; i < nameArr.count ; i++) {
        UIButton *btn = _btnArr[i];
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
    }
}

-(void)choiceBtnAction:(UIButton *)btn{
    CGFloat bottomLineW = mainScreenWidth/_btnNameArr.count - FitWith(40.0);
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _bottomLine.frame;
        frame.origin.x = FitWith(20.0) + (bottomLineW + FitWith(40.0)) * btn.tag;
        _bottomLine.frame = frame;
    }];
    for (UIButton *b in _btnArr) {
        b.selected = b.tag == btn.tag;
    }
    SectionViewBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)setBtnChangeWithIndex:(NSInteger)index{
    CGFloat bottomLineW = mainScreenWidth/_btnNameArr.count - FitWith(40.0);
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _bottomLine.frame;
        frame.origin.x = FitWith(20.0) + (bottomLineW + FitWith(40.0)) * index;
        _bottomLine.frame = frame;
    }];
    for (UIButton *b in _btnArr) {
        b.selected = b.tag == index;
    }
    SectionViewBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(index);
    }
}


@end
