//
//  DesignerView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/20.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesignerView.h"

@interface DesignerView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *subLable;

@end

@implementation DesignerView

-(instancetype)init{
    self = [super init];
    if (self) {
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        _tagImgV = [UIImageView newAutoLayoutView];
        [_bgView addSubview:_tagImgV];
        
        _avatarImgV = [UIImageView newAutoLayoutView];
        _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImgV.layer.cornerRadius = FitWith(140.0) * 0.5;
        _avatarImgV.layer.masksToBounds = true;
        [_bgView addSubview:_avatarImgV];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textAlignment = NSTextAlignmentCenter;
        _nameLable.textColor = [UIColor colorFromHex:0x222222];
        _nameLable.font = CUSFONT(14);
        [_bgView addSubview:_nameLable];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textAlignment = NSTextAlignmentCenter;
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        _subLable.font = CUSFONT(12);
        [_bgView addSubview:_subLable];
        
        _attentionBtn = [UIButton newAutoLayoutView];
        _attentionBtn.titleLabel.font = CUSFONT(12);
        [_attentionBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        [_attentionBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateSelected];
        [_attentionBtn setImage:[UIImage imageNamed:@"Design_add_attention_nomal"] forState:UIControlStateNormal];
        [_attentionBtn setImage:[UIImage imageNamed:@"Design_add_attention_seletced"] forState:UIControlStateSelected];
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_attentionBtn setTitle:@"已关注" forState:UIControlStateSelected];
        _attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        _attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -3);
        
        _attentionBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _attentionBtn.layer.borderWidth = 1;
        _attentionBtn.layer.cornerRadius = FitHeight(42.0) * 0.5;
        [_bgView addSubview:_attentionBtn];
        
        _markBtn = [UIButton newAutoLayoutView];
        [_bgView addSubview:_markBtn];
        
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithDesignerData:(DesignerData *)item{
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _nameLable.text = item.name;
    _subLable.text = item.typeName;
    _attentionBtn.selected = item.follow;
    if (item.follow) {
        _attentionBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }else{
        _attentionBtn.layer.borderColor = [UIColor mainColor].CGColor;
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_tagImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(10.0)];
        [_tagImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_tagImgV autoSetDimension:ALDimensionWidth toSize:FitWith(40.0)];
        [_tagImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(40.0)];
        
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_avatarImgV autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_avatarImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(140.0)];
        [_avatarImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(140.0)];
        
        [_nameLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatarImgV withOffset:FitHeight(10)];
        
        [_subLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_subLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLable withOffset:FitHeight(10)];
        
        [_attentionBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_attentionBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_subLable withOffset:FitHeight(10)];
        [_attentionBtn autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        [_attentionBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(42.0)];
        
        [_markBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_subLable];
        [_markBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_subLable];
        [_markBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_subLable];
        [_markBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
