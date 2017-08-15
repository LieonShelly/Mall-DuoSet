//
//  PiazzaTypeHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaTypeHeaderView.h"

@interface PiazzaTypeHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *bannerView;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *titleName;
@property(nonatomic,strong) UILabel *desTitle;

@end

@implementation PiazzaTypeHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _bannerView = [UIImageView newAutoLayoutView];
        [self addSubview:_bannerView];
        
        _markView = [UIView newAutoLayoutView];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [_bannerView addSubview:_markView];
        
        _avatarImgV = [UIImageView newAutoLayoutView];
        [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,[Utils getUserInfo].avatar]] placeholderImage:[UIImage imageNamed:@"user_nologin"] options:0];
        _avatarImgV.layer.cornerRadius = FitWith(150.0) *0.5;
        _avatarImgV.layer.masksToBounds = true;
        _avatarImgV.layer.borderColor = [UIColor whiteColor].CGColor;
        _avatarImgV.layer.borderWidth = 2;
        [_markView addSubview:_avatarImgV];
        
        _titleName = [UILabel newAutoLayoutView];
        _titleName.textColor = [UIColor colorFromHex:0xfffefe];
        _titleName.textAlignment = NSTextAlignmentCenter;
        _titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [_markView addSubview:_titleName];
        
        _subTitle = [UILabel newAutoLayoutView];
        _subTitle.textColor = [UIColor colorFromHex:0xf8f8f8];
        _subTitle.textAlignment = NSTextAlignmentCenter;
        _subTitle.font = CUSFONT(12);
        [_markView addSubview:_subTitle];
        
        _desTitle = [UILabel newAutoLayoutView];
        _desTitle.textColor = [UIColor colorFromHex:0xf8f8f8];
        _desTitle.textAlignment = NSTextAlignmentCenter;
        _desTitle.font = CUSFONT(11);
        [_markView addSubview:_desTitle];
        
        [self updateConstraints];
    }
    return self;
}



-(void)setupInfoWithType:(NSInteger)type{
    if (type == 0) {
        _bannerView.image = [UIImage imageNamed:@"piazza_headerImg"];
        _titleName.text = @"设计爱好者";
        _desTitle.text = @"设计改变生活，世界别样精彩";
    }else{
        _bannerView.image = [UIImage imageNamed:@"pizaaz_header_design"];
        _titleName.text = @"摄影爱好者";
        _desTitle.text = @"镜头记录生活，世界别样精彩";
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [_bannerView autoPinEdgesToSuperviewEdges];
        
        [_markView autoPinEdgesToSuperviewEdges];
        
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(100.0)];
        [_avatarImgV autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        [_avatarImgV autoSetDimension:ALDimensionHeight toSize:FitWith(150.0)];
        [_avatarImgV autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
        
        [_titleName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatarImgV withOffset:FitHeight(20.0)];
        [_titleName autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
        
        [_subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleName withOffset:5];
        [_subTitle autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
        
        [_desTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_subTitle withOffset:5];
        [_desTitle autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
        
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
