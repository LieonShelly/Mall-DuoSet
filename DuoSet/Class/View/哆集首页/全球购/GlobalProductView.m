//
//  GlobalProductView.m
//  DuoSet
//
//  Created by mac on 2017/1/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GlobalProductView.h"

@interface GlobalProductView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *productImgV;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *priceLable;

@end

@implementation GlobalProductView

-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _productImgV = [UIImageView newAutoLayoutView];
        _productImgV.contentMode = UIViewContentModeScaleAspectFill;
        _productImgV.layer.masksToBounds = true;
        [self addSubview:_productImgV];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textAlignment = NSTextAlignmentLeft;
        _productName.numberOfLines = 2;
        _productName.textColor = [UIColor blackColor];
        _productName.font =CUSFONT(11);
        [self addSubview:_productName];
        
        _priceLable = [UILabel newAutoLayoutView];
        _priceLable.textColor = [UIColor mainColor];
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.font = CUSFONT(16);
        [self addSubview:_priceLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductForListData:(ProductForListData *)item{
    [_productImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(300, 300) options:0];
    _productName.text = item.productName;
    NSString *text = [NSString stringWithFormat:@"￥%@",item.price];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(text.length - 2,2)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(text.length - 2, 2)];
    _priceLable.attributedText = attributeString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_productImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_productImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(300.0)];
        
        [_productName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_productImgV withOffset:FitHeight(10.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(28.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(28.0)];
        
        [_priceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_priceLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}



@end
