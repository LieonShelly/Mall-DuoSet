//
//  OrderHeaderView.m
//  DuoSet
//
//  Created by fanfans on 1/4/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "OrderHeaderView.h"

@interface OrderHeaderView()

@property(nonatomic,strong) NSMutableArray *btnArr;
@property(nonatomic,strong) UIView *borderView;

@end

@implementation OrderHeaderView

-(instancetype)initWithFrame:(CGRect)frame backBlock:(void(^)(NSInteger)) moreclick{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _OrderHeaderViewBtnActionBlock = moreclick;
        
        _borderView = [[UIView alloc]initWithFrame:CGRectMake(FitWith(15.0), FitHeight(25.0), FitWith(120.0), FitHeight(70.0))];
        _borderView.backgroundColor = [UIColor clearColor];
        _borderView.layer.borderColor = [UIColor mainColor].CGColor;
        _borderView.layer.borderWidth = 1;
        [self addSubview:_borderView];
        
        _btnArr = [NSMutableArray array];
        NSArray *arr = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"];
        for (int i = 0; i < arr.count ; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(FitWith(20.0) + (FitWith(110.0) + FitWith(40.0)) * i,FitHeight(30.0), FitWith(110.0), FitHeight(60.0));
            btn.titleLabel.font = CUSFONT(12);
            btn.tag = i;
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHex:0xfef9f5]] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHex:0xffffff]] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorFromHex:0x333333] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(navButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [_btnArr addObject:btn];
            if (i == 0) {
                btn.selected = true;
            }
        }
    }
    return self;
}

-(void)navButtonAciton:(UIButton *)btn{
    [self setBtnChangeWithIndex:btn.tag];
}

-(void)setBtnChangeWithIndex:(NSInteger)index{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _borderView.frame;
        frame.origin.x = FitWith(15.0) + (FitWith(110.0) + FitWith(40.0)) * index;
        _borderView.frame = frame;
        
    } completion:nil];
    for (UIButton *b in _btnArr) {
        b.selected = index == b.tag;
    }
    if (_OrderHeaderViewBtnActionBlock) {
        _OrderHeaderViewBtnActionBlock(index);
    }
}


@end
