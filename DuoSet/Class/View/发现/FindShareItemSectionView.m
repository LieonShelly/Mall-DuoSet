//
//  FindShareItemSectionView.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "FindShareItemSectionView.h"

@interface FindShareItemSectionView()

@property(nonatomic,strong) UIButton *pubicBtn;
@property(nonatomic,strong) UIButton *likedBtn;
@property(nonatomic,strong) UIView *bottomView;

@end

@implementation FindShareItemSectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        
        _pubicBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth * 0.5, FitHeight(100.0))];
        _pubicBtn.titleLabel.font = CUSFONT(12);
        _pubicBtn.backgroundColor = [UIColor whiteColor];
        [_pubicBtn setTitleColor:[UIColor colorFromHex:0x333333] forState:UIControlStateNormal];
        [_pubicBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_pubicBtn setTitle:@"发布的帖子" forState:UIControlStateNormal];
        _pubicBtn.selected = true;
        _pubicBtn.tag = 0;
        [_pubicBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pubicBtn];
        
        _likedBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth * 0.5, 0, mainScreenWidth * 0.5, FitHeight(100.0))];
        _likedBtn.titleLabel.font = CUSFONT(12);
        _likedBtn.backgroundColor = [UIColor whiteColor];
        [_likedBtn setTitleColor:[UIColor colorFromHex:0x333333] forState:UIControlStateNormal];
        [_likedBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_likedBtn setTitle:@"赞过的帖子" forState:UIControlStateNormal];
        _likedBtn.tag = 1;
        [_likedBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_likedBtn];
        
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, FitHeight(95.0), mainScreenWidth * 0.5, FitHeight(5))];
        _bottomView.backgroundColor = [UIColor mainColor];
        [self addSubview:_bottomView];
    }
    return self;
}

-(void)btnAction:(UIButton *)btn{
    _pubicBtn.selected = btn.tag == 0 ? true : false;
    _likedBtn.selected = btn.tag == 0 ? false : true;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _bottomView.frame;
        frame.origin.x = btn.tag == 0 ? 0 : mainScreenWidth * 0.5;
        _bottomView.frame = frame;
    }];
}

@end
