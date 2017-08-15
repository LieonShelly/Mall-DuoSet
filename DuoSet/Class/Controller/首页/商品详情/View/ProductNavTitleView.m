//
//  ProductNavTitleView.m
//  DuoSet
//
//  Created by fanfans on 2017/4/28.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ProductNavTitleView.h"

@interface ProductNavTitleView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIButton *webDetailsBtn;
@property(nonatomic,strong) UIButton *productDetailsBtn;
@property(nonatomic,strong) UIButton *commentBtn;
@property(nonatomic,strong) UIView *footLine;
@property(nonatomic,assign) NSInteger seletcedIndex;
@property(nonatomic,strong) UILabel *webLable;

@end

@implementation ProductNavTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _webDetailsBtn = [UIButton newAutoLayoutView];
        _webDetailsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_webDetailsBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        [_webDetailsBtn setTitle:@"详情" forState:UIControlStateNormal];
        _webDetailsBtn.tag = 1;
        [_webDetailsBtn addTarget:self action:@selector(butActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_webDetailsBtn];
        
        _productDetailsBtn = [UIButton newAutoLayoutView];
        _productDetailsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_productDetailsBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        [_productDetailsBtn setTitle:@"商品" forState:UIControlStateNormal];
        _productDetailsBtn.tag = 0;
        [_productDetailsBtn addTarget:self action:@selector(butActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_productDetailsBtn];
        
        _commentBtn = [UIButton newAutoLayoutView];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_commentBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        [_commentBtn setTitle:@"评价" forState:UIControlStateNormal];
        _commentBtn.tag = 2;
        [_commentBtn addTarget:self action:@selector(butActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_commentBtn];
        
//        _footLine = [[UIView alloc]initWithFrame:CGRectMake(FitWith(155.0), 42, 30, 2)];
        _footLine = [[UIView alloc]initWithFrame:CGRectMake(mainScreenWidth / 2 - 110, 40, 30, 2)];
        _footLine.backgroundColor = [UIColor colorFromHex:0x212121];
        [self addSubview:_footLine];
        
        _webLable = [UILabel newAutoLayoutView];
        _webLable.text = @"图文详情";
        _webLable.textAlignment = NSTextAlignmentCenter;
        _webLable.font = [UIFont systemFontOfSize:17];
        _webLable.textColor = [UIColor colorFromHex:0x212121];
        _webLable.hidden = true;
        [self addSubview:_webLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)butActionHandle:(UIButton *)btn{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = _footLine.frame;
        frame.origin.x = (mainScreenWidth / 2 - 110) + (50 * btn.tag);
        weakSelf.footLine.frame = frame;
    }];
    NavTitleButtonActionBlock block = _navbuttonHandle;
    if (block) {
        block(btn.tag);
    }
}

-(void)setupViewProductNavTitleViewShowStyle:(ProductNavTitleViewShowStyle)style LineFrameChangeWithIndex:(NSInteger)index{
    if (style == ProductNavTitleViewShowSubViews) {
        _webDetailsBtn.hidden = false;
        _productDetailsBtn.hidden = false;
        _commentBtn.hidden = false;
        _footLine.hidden = false;
        _webLable.hidden = true;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = weakSelf.footLine.frame;
            frame.origin.x = (mainScreenWidth / 2 - 110) + (50 * index);
            weakSelf.footLine.frame = frame;
        }];
    }
    if (style == ProductNavTitleViewShowWebDetails) {
        _webDetailsBtn.hidden = true;
        _productDetailsBtn.hidden = true;
        _commentBtn.hidden = true;
        _footLine.hidden = true;
        _webLable.hidden = false;
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_webDetailsBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_webDetailsBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [_webDetailsBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        [_webDetailsBtn autoSetDimension:ALDimensionWidth toSize:50];
        
        [_productDetailsBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [_productDetailsBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        [_productDetailsBtn autoSetDimension:ALDimensionWidth toSize:50];
        [_productDetailsBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_webDetailsBtn];
        
        [_commentBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [_commentBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
        [_commentBtn autoSetDimension:ALDimensionWidth toSize:50];
        [_commentBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_webDetailsBtn];
        
        [_webLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_webLable autoPinEdgeToSuperviewEdge:ALEdgeTop ];
        [_webLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
