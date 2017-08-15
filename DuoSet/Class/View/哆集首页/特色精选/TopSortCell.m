//
//  TopSortCell.m
//  DuoSet
//
//  Created by mac on 2017/1/18.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "TopSortCell.h"

@interface TopSortCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIImageView *crownImgV;
@property (nonatomic,strong) UIImageView *productImgV;
@property (nonatomic,strong) UIView *leftTopView;
@property (nonatomic,strong) UILabel *topNumLable;
@property (nonatomic,strong) UILabel *topLable;
@property (nonatomic,strong) UILabel *productName;
@property (nonatomic,strong) UILabel *desLable;
@property (nonatomic,strong) UILabel *priceLable;

@end

@implementation TopSortCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        
        _crownImgV = [UIImageView newAutoLayoutView];
        _crownImgV.image = [UIImage imageNamed:@"huangguan"];
        [self.contentView addSubview:_crownImgV];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.image = [UIImage imageNamed:@"test_01.jpg"];
        [self.contentView addSubview:_productImgV];
        
        _leftTopView = [UIView newAutoLayoutView];
        _leftTopView.backgroundColor = [UIColor whiteColor];
        [_productImgV addSubview:_leftTopView];
        
        _topNumLable = [UILabel newAutoLayoutView];
        _topNumLable.text = @"1";
        _topNumLable.textAlignment = NSTextAlignmentCenter;
        _topNumLable.textColor = [UIColor blackColor];
        _topNumLable.font = CUSFONT(13);
        [_leftTopView addSubview:_topNumLable];
        
        _topLable = [UILabel newAutoLayoutView];
        _topLable.text = @"TOP";
        _topLable.textAlignment = NSTextAlignmentCenter;
        _topLable.textColor = [UIColor blackColor];
        _topLable.font = CUSFONT(13);
        [_leftTopView addSubview:_topLable];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor blackColor];
        _productName.numberOfLines = 2;
        _productName.text = @"气质通勤的2016最流行的连衣裙";
        _productName.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        [self.contentView addSubview:_productName];
        
        _desLable = [UILabel newAutoLayoutView];
        _desLable.textColor = [UIColor colorFromHex:0x666666];
        _desLable.numberOfLines = 8;
        _desLable.text = @"气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙气质通勤的2016最流行的连衣裙";
        _desLable.font = CUSFONT(13);
        [self.contentView addSubview:_desLable];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.text = @"￥169.00";
        _priceLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        [self.contentView addSubview:_priceLable];
        
        [self.contentView bringSubviewToFront:_crownImgV];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_crownImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_crownImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_crownImgV autoSetDimension:ALDimensionWidth toSize:FitWith(60.0)];
        [_crownImgV autoSetDimension:ALDimensionHeight toSize:FitWith(60.0)];
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_productImgV autoSetDimension:ALDimensionWidth toSize:FitWith(380.0)];
        
        [_leftTopView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_leftTopView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_leftTopView autoSetDimension:ALDimensionWidth toSize:FitWith(90.0)];
        [_leftTopView autoSetDimension:ALDimensionHeight toSize:FitWith(110.0)];
        
        [_topNumLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_topNumLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_topNumLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_topNumLable autoSetDimension:ALDimensionWidth toSize:FitWith(90.0)];
        
        [_topLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_topNumLable withOffset:FitHeight(10.0)];
        [_topLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_topLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_topLable autoSetDimension:ALDimensionWidth toSize:FitWith(90.0)];
        
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_productImgV withOffset:FitHeight(20.0)];
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_productImgV withOffset:FitWith(20.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        
        [_desLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_desLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_productName];
        [_desLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productName withOffset:FitHeight(10.0)];
        
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_priceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_productImgV withOffset:-FitHeight(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
