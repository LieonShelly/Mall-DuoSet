//
//  SeckillHeaderView.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillHeaderView.h"

@interface SeckillHeaderView()

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIView *redView;
@property(nonatomic,strong) NSMutableArray *timeLableArr;
@property(nonatomic,strong) NSMutableArray *statusLableArr;
@property(nonatomic,strong) NSMutableArray *btnArr;

@end

@implementation SeckillHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, frame.size.height)];
        _bgView.backgroundColor = [UIColor colorFromHex:0x8a8b8d];
        [self addSubview:_bgView];
        
        _redView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth * 0.2, frame.size.height)];
        _redView.backgroundColor = [UIColor mainColor];
        [self addSubview:_redView];
        
        _timeLableArr = [NSMutableArray array];
        _statusLableArr = [NSMutableArray array];
        _btnArr = [NSMutableArray array];
        NSArray *timeStrArr = @[@"06:00",@"08:00",@"10:00",@"12:00",@"13:00"];
        NSArray *statusArr = @[@"已开抢",@"已开抢",@"已开抢",@"正在进行",@"即将开始"];
        
        for (int i = 0; i < 5; i++) {
            UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(i * mainScreenWidth * 0.2 , FitHeight(30.0), mainScreenWidth * 0.2, FitHeight(30.0))];
            time.text = timeStrArr[i];
            time.textAlignment = NSTextAlignmentCenter;
            time.textColor = [UIColor whiteColor];
            time.font = CUSFONT(12);
            [self addSubview:time];
            [_timeLableArr addObject:time];
            
            UILabel *status = [[UILabel alloc]initWithFrame:CGRectMake(i * mainScreenWidth * 0.2, time.frame.origin.y + time.frame.size.height + 3 , mainScreenWidth * 0.2, FitHeight(30.0))];
            status.text = statusArr[i];
            status.textAlignment = NSTextAlignmentCenter;
            status.textColor = [UIColor whiteColor];
            status.font = CUSFONT(9);
            [self addSubview:status];
            [_statusLableArr addObject:status];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i * mainScreenWidth * 0.2, FitHeight(20.0), mainScreenWidth * 0.2, FitHeight(50.0))];
            btn.tag = i;
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(timeBtnSeleted:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [_btnArr addObject:btn];
        }
    }
    return self;
}

-(void)setBtnChangeWithIndex:(NSInteger)index{
    [self changeFillViewFrameWithIndex:index];
}

-(void)timeBtnSeleted:(UIButton *)btn{
    [self changeFillViewFrameWithIndex:btn.tag];
    HeaderBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)changeFillViewFrameWithIndex:(NSInteger)index{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _redView.frame;
        frame.origin.x = index * mainScreenWidth * 0.2;
        _redView.frame = frame;
    } completion:nil];
}


@end
