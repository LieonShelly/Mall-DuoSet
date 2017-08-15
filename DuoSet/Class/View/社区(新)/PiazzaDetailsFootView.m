//
//  PiazzaDetailsFootView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaDetailsFootView.h"

@interface PiazzaDetailsFootView()

@property(nonatomic,strong) UIButton *likeBtn;
@property(nonatomic,strong) UIButton *commentBtn;
@property(nonatomic,strong) UIButton *collectBtn;

@end

@implementation PiazzaDetailsFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHex:0x222222];
        
        _likeBtn = [[UIButton alloc]init];
        _commentBtn = [[UIButton alloc]init];
        _collectBtn = [[UIButton alloc]init];
        NSArray *btnArr = @[_likeBtn,_commentBtn,_collectBtn];
        NSArray *nomImgNameArr = @[@"piazza_details_foot_like_white",@"piazza_details_foot_comment",@"piazza_details_foot_star_white"];
        NSArray *seletcedImgNameArr = @[@"piazza_details_foot_like_red",@"piazza_details_foot_comment",@"piazza_details_foot_star_red"];
        CGFloat btnWight = mainScreenWidth / 3;
        for (int i = 0; i < btnArr.count; i++) {
            UIButton *btn = btnArr[i];
            btn.tag = i;
            btn.titleLabel.font = CUSNEwFONT(15);
            btn.frame = CGRectMake(btnWight * i, 0, btnWight , 50);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -FitWith(20.0), 0, 0);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -FitWith(20.0));
            [btn setImage:[UIImage imageNamed:nomImgNameArr[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:seletcedImgNameArr[i]] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(footViewBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

-(void)setupInfoWithPiazzaItemCollectAndLikeData:(PiazzaItemCollectAndLikeData *)item{
    _likeBtn.selected = item.isLike;
    [_likeBtn setTitle:item.likeCount forState:UIControlStateNormal];
    [_commentBtn setTitle:item.commentCount forState:UIControlStateNormal];
    _collectBtn.selected = item.isCollect;
    [_collectBtn setTitle:item.collectCount forState:UIControlStateNormal];
}


-(void)footViewBtnsAction:(UIButton *)btn{
    PiazzaDetailsFootViewBtnActionBlock block = _btnActionHandle;
    if (block) {
        block(btn);
    }
}

@end
