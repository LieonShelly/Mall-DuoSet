//
//  GarmentMatchProductCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GarmentMatchProductCell.h"

@interface GarmentMatchProductCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *priceLable;
@property(nonatomic,strong) UIButton *buyBtn;
@property(nonatomic,strong) UIView *line;

@end

@implementation GarmentMatchProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.image = [UIImage imageNamed:@"testAvatar.jpg"];
        [self.contentView addSubview:_productImgV];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textColor = [UIColor colorFromHex:0x666666];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.text = @"2017年上市的连衣裙很好看的哦。走过路过不要错过的，买不了吃亏，买不了上当";
        _nameLable.font = CUSFONT(11);
        _nameLable.numberOfLines = 1;
        [self.contentView addSubview:_nameLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.text = @"￥169.00";
        _priceLable.font = CUSFONT(12);
        _priceLable.numberOfLines = 1;
        [self.contentView addSubview:_priceLable];
        
        _buyBtn = [UIButton newAutoLayoutView];
        _buyBtn.titleLabel.font = CUSFONT(10.0);
        _buyBtn.layer.borderWidth = 1;
        _buyBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _buyBtn.layer.masksToBounds = true;
        _buyBtn.layer.cornerRadius = 2;
        [_buyBtn setTitle:@"去购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _buyBtn.userInteractionEnabled = false;
        [self.contentView addSubview:_buyBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(135.0)];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitWith(135.0)];
        
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV withOffset:FitHeight(20.0)];
        [_nameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(20.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(160.0)];
        
        [_priceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV withOffset: -FitHeight(20.0)];
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameLable];
        
        [_buyBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_buyBtn autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_buyBtn autoSetDimension:ALDimensionHeight toSize:FitWith(50.0)];
        [_buyBtn autoAlignAxisToSuperviewMarginAxis:ALAxisHorizontal];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
