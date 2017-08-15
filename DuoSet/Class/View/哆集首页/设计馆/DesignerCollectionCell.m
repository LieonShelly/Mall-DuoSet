//
//  DesignerCollectionCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/21.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerCollectionCell.h"

@interface DesignerCollectionCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UIImageView *designerCover;
@property(nonatomic,strong) UIButton *designerBtn;
@property(nonatomic,strong) UILabel *desLable;

@end

@implementation DesignerCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _designerCover = [UIImageView newAutoLayoutView];
        _designerCover.userInteractionEnabled = true;
        _designerCover.layer.masksToBounds = true;
        _designerCover.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_designerCover];
        
        _markView = [UIView newAutoLayoutView];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _markView.userInteractionEnabled = true;
        [_designerCover addSubview:_markView];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSFONT(13);
        [_likeBtn setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"like_nomal"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"like_seletced"] forState:UIControlStateSelected];
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_likeBtn addTarget:self action:@selector(likeBtnActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_markView addSubview:_likeBtn];
        
        _designerBtn = [UIButton newAutoLayoutView];
        _designerBtn.titleLabel.font = CUSFONT(13);
        _designerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_designerBtn setTitleColor:[UIColor colorFromHex:0xffffff] forState:UIControlStateNormal];
        [_designerBtn setImage:[UIImage imageNamed:@"Design_user"] forState:UIControlStateNormal];
        [_markView addSubview:_designerBtn];
        
        _desLable = [UILabel newAutoLayoutView];
        _desLable.textColor = [UIColor colorFromHex:0x222222];
        _desLable.font = CUSFONT(13);
        _desLable.textAlignment = NSTextAlignmentLeft;
        _desLable.numberOfLines = 2;
        [_bgView addSubview:_desLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithDesignerData:(DesignerData *)item{
    [_designerCover sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_226_256 options:0];
    [_likeBtn setTitle:item.followCount forState:UIControlStateNormal];
    [_designerBtn setTitle:item.name forState:UIControlStateNormal];
    _likeBtn.selected = item.follow;
    _desLable.text = item.tag;
}

-(void)likeBtnActionHandle:(UIButton *)btn{
    DesignerLikeBlock block = _likeHandle;
    if (block) {
        block(btn);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_designerCover autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_designerCover autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_designerCover autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_designerCover autoSetDimension:ALDimensionHeight toSize:FitHeight(370.0)];
        
        [_markView autoPinEdgesToSuperviewEdges];
        
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_designerBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_designerBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:3];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:3];
        [_desLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_designerCover withOffset:5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
