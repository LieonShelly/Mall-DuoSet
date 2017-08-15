//
//  MustBuySmallView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuySmallView.h"

@interface MustBuySmallView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *subTitle;

@end

@implementation MustBuySmallView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imgV];
        
        _markView = [UIView newAutoLayoutView];
//        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [_imgV addSubview:_markView];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.font = CUSFONT(13);
        [_markView addSubview:_titleLable];
        
        _subTitle = [UILabel newAutoLayoutView];
        _subTitle.textColor = [UIColor whiteColor];
        _subTitle.textAlignment = NSTextAlignmentCenter;
        _subTitle.font = CUSFONT(11);
        [_markView addSubview:_subTitle];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithMustBuyListTypeData:(MustBuyListTypeData *)item{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    _titleLable.text = item.name;
    _subTitle.text = [NSString stringWithFormat:@"%@个清单",item.buyListCount];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_imgV autoPinEdgesToSuperviewEdges];
        
        [_markView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_imgV];
        [_markView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_imgV];
        [_markView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_imgV];
        [_markView autoSetDimension:ALDimensionHeight toSize:FitHeight(70.0)];
        
        [_titleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_markView];
        [_titleLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_markView];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_subTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_markView];
        [_subTitle autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_markView];
        [_subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
