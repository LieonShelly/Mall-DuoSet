//
//  OrderSureMoreProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/1.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureMoreProductCell.h"

@interface OrderSureMoreProductCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) NSMutableArray *productCoverImgVArr;
@property (nonatomic,strong) UILabel *rightlable;
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) ShopCarSureData *item;

@end

@implementation OrderSureMoreProductCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.productCoverImgVArr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.layer.cornerRadius = 3;
            imgV.layer.masksToBounds = true;
            [self.contentView addSubview:imgV];
            [self.productCoverImgVArr addObject:imgV];
        }
        
        _rightlable = [UILabel newAutoLayoutView];
        _rightlable.textAlignment = NSTextAlignmentRight;
        _rightlable.textColor = [UIColor colorFromHex:0x808080];
        _rightlable.font = CUSNEwFONT(14);
        [self.contentView addSubview:_rightlable];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.image = [UIImage imageNamed:@"common_right_arrow_small"];
        _rightArrow.contentMode = UIViewContentModeRight;
        [self.contentView addSubview:_rightArrow];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setUpInfoShopCarSureData:(ShopCarSureData *)item{
    _item = item;
    for (int i = 0; i < 4; i++) {
        UIImageView *imgV = self.productCoverImgVArr[i];
        if (i >= item.products.count) {
            imgV.hidden = true;
        }else{
            imgV.hidden = false;
            ShopCarSureProduct *product = item.products[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:product.cover] placeholderImage:placeholderImage_226_256 options:0];
        }
    }
    NSInteger tmpcount = 0;
    for (ShopCarSureProduct *product in item.products) {
        tmpcount += product.count.integerValue;
    }
    _rightlable.text = [NSString stringWithFormat:@"共%ld件",tmpcount];
}



- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        for (int i = 0; i < 4; i++) {
            UIImageView *imgV = self.productCoverImgVArr[i];
            [imgV autoSetDimension:ALDimensionWidth toSize:FitWith(142.0)];
            [imgV autoSetDimension:ALDimensionHeight toSize:FitWith(142.0)];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0) + FitWith(150) * i];
        }
        
        [_rightlable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(50.0)];
        [_rightlable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_rightArrow autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
