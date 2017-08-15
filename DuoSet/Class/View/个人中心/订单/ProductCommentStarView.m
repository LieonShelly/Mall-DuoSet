//
//  ProductCommentStarView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductCommentStarView.h"

@interface ProductCommentStarView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) NSMutableArray *starArr;

@end

@implementation ProductCommentStarView

-(instancetype)init{
    self = [super init];
    if (self) {
        _titleNameLable = [UILabel newAutoLayoutView];
        _titleNameLable.text = @"商品包装";
        _titleNameLable.textColor = [UIColor colorFromHex:0x222222];
        _titleNameLable.font = CUSFONT(14);
        [self addSubview:_titleNameLable];
        
        _starArr = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            UIButton *star = [UIButton newAutoLayoutView];
            star.tag = i + 1;
            star.selected = true;
            [star setImage:[UIImage imageNamed:@"comment_star_normal"] forState:UIControlStateNormal];
            [star setImage:[UIImage imageNamed:@"comment_star_selected"] forState:UIControlStateSelected];
            [star addTarget:self action:@selector(starSelectedHandle:) forControlEvents:UIControlEventTouchUpInside];
            [_starArr addObject:star];
            [self addSubview:star];
        }
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoScoreView:(NSInteger)index{
    if (index == 0) {//好评
        for (int i = 0; i < 5; i++) {
            UIButton *star = _starArr[i];
            star.selected = true;
        }
    }
    if (index == 1) {//中评
        for (int i = 0; i < 5; i++) {
            UIButton *star = _starArr[i];
            star.selected = star.tag <= 3;
        }
    }
    if (index == 2) {//差评
        for (int i = 0; i < 5; i++) {
            UIButton *star = _starArr[i];
            star.selected =  star.tag == 1;
        }
    }
}


-(void)starSelectedHandle:(UIButton *)btn{
    for (UIButton *b in _starArr) {
        b.selected = b.tag <= btn.tag;
    }
    StarSelectedBlock block = _starSelectedHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_titleNameLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_titleNameLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_titleNameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        
        for (int i = 0; i < 5; i++) {
            UIButton *star = _starArr[i];
            [star autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
            [star autoSetDimension:ALDimensionWidth toSize:FitHeight(80.0)];
            [star autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [star autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(295.0) + FitHeight(80.0) * i];
        }
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
