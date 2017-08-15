//
//  ProductScoreView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductScoreView.h"
#import "ProductCommentStarView.h"

@interface ProductScoreView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) NSMutableArray *btns;
@property(nonatomic,strong) UIView *cuttingView;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) ProductCommentStarView *starView1;
@property(nonatomic,strong) ProductCommentStarView *starView2;

@end

@implementation ProductScoreView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        [self addSubview:_line];
        
        _btns = [NSMutableArray array];
        NSArray *titleArr = @[@"好评",@"中评",@"差评"];
        NSArray *normalImgArr = @[@"commet_gootBtn_normal",@"commet_middleBtn_normal",@"commet_bagBtn_normal"];
        NSArray *selectedImgArr = @[@"comment_goodBtn_selected",@"comment_middleBtn_selected",@"comment_badBtn_selected"];
        for (int i = 0; i < 3; i++) {
            UIButton *btn = [UIButton newAutoLayoutView];
            btn.tag = i;
            btn.titleLabel.font = CUSFONT(15);
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:normalImgArr[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:selectedImgArr[i]] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnsAciton:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
            [_btns addObject:btn];
            if (i == 0) {
                btn.selected = true;
            }
            [self addSubview:btn];
        }
        
        _cuttingView = [UIView newAutoLayoutView];
        _cuttingView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        [self addSubview:_cuttingView];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.text = @"星级评分";
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        _titleLable.font = CUSFONT(15);
        [self addSubview:_titleLable];
        
        _starView1 = [ProductCommentStarView newAutoLayoutView];
        _starView1.titleNameLable.text = @"商品包装";
        __weak typeof(self) weakSelf = self;
        _starView1.starSelectedHandle = ^(NSInteger count){
            ProductScoreViewStarItemPack block = weakSelf.packHandle;
            if (block) {
                block(count);
            }
        };
        [self addSubview:_starView1];
        
        _starView2 = [ProductCommentStarView newAutoLayoutView];
        _starView2.titleNameLable.text = @"发货速度";
        _starView2.starSelectedHandle = ^(NSInteger count){
            ProductScoreViewStarSeepedBlock block = weakSelf.seepedHandle;
            if (block) {
                block(count);
            }
        };
        [self addSubview:_starView2];
        
        [self updateConstraints];
    }
    return self;
}

-(void)btnsAciton:(UIButton *)btn{
    [_starView1 setupInfoScoreView:btn.tag];
    [_starView2 setupInfoScoreView:btn.tag];
    
    for (UIButton *b in _btns) {
        b.selected = b.tag == btn.tag;
    }
    ProductScoreBtnSelectedBlock block = _btnselectedHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:2];
        
        for (int i = 0; i < 3; i++) {
            UIButton *btn = _btns[i];
            [btn autoSetDimension:ALDimensionWidth toSize:mainScreenWidth/3];
            [btn autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
            [btn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line];
            [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(mainScreenWidth/3) * i];
        }
        
        [_cuttingView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(125.0)];
        [_cuttingView autoSetDimension:ALDimensionHeight toSize:FitHeight(20.0)];
        [_cuttingView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_cuttingView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cuttingView];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_titleLable autoSetDimension:ALDimensionHeight toSize:FitHeight(70.0)];
        
        [_starView1 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_starView1 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_starView1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable];
        [_starView1 autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
        
        [_starView2 autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_starView2 autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_starView2 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_starView1];
        [_starView2 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_starView1];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
