//
//  ShopCartEmptyCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ShopCartEmptyCell.h"

@interface ShopCartEmptyCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *emptyImgV;
@property (nonatomic,strong) UILabel *tipsLable;
@property (nonatomic,strong) UIButton *actionBtn;

@end

@implementation ShopCartEmptyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _emptyImgV = [UIImageView newAutoLayoutView];
        _emptyImgV.image = [UIImage imageNamed:@"defeated_no_order"];
        [self.contentView addSubview:_emptyImgV];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.font = [UIFont systemFontOfSize:12];
        _tipsLable.textColor = [UIColor colorFromHex:0x808080];
        _tipsLable.text = @"购物车空空如也";
        [self.contentView addSubview:_tipsLable];
        
        _actionBtn = [UIButton newAutoLayoutView];
        _actionBtn.backgroundColor = [UIColor mainColor];
        _actionBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _actionBtn.layer.cornerRadius = 3;
        _actionBtn.layer.masksToBounds = true;
        [_actionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        [_actionBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        [self.contentView addSubview:_actionBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)tapAction{
    GotoLookBlock block = _lookProductListHandle;
    if (block) {
        block();
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_emptyImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(200)];
        [_emptyImgV autoSetDimension:ALDimensionWidth toSize:FitWith(116)];
        [_emptyImgV autoSetDimension:ALDimensionHeight toSize:FitWith(130)];
        [_emptyImgV autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
        
        [_tipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_emptyImgV withOffset:FitWith(40)];
        [_tipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_emptyImgV withOffset:12];
        
        [_actionBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipsLable withOffset:11];
        [_actionBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable withOffset:20];
        [_actionBtn autoSetDimension:ALDimensionWidth toSize:50];
        [_actionBtn autoSetDimension:ALDimensionHeight toSize:20];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
