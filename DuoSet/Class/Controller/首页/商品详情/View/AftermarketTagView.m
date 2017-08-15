//
//  AftermarketTagView.m
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AftermarketTagView.h"

@interface AftermarketTagView()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *tagImgV;
@property(nonatomic,strong) UILabel *tagLable;

@end

@implementation AftermarketTagView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _tagImgV = [UIImageView newAutoLayoutView];
        [self addSubview:_tagImgV];
        
        _tagLable = [UILabel newAutoLayoutView];
        _tagLable.textColor = [UIColor colorFromHex:0x808080];
        _tagLable.textAlignment = NSTextAlignmentLeft;
        _tagLable.font = CUSNEwFONT(13);
        [self addSubview:_tagLable];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductDetailsArticle:(ProductDetailsArticle *)item{
    [_tagImgV sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:placeholderImage_226_256 options:0];
    _tagLable.text = item.name;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tagImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_tagImgV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_tagImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(30.0)];
        [_tagImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(30.0)];
        
        [_tagLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tagImgV withOffset:FitWith(5.0)];
        [_tagLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_tagLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
