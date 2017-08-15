//
//  PiazzaMessageDetailHeaderView.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaMessageDetailHeaderView.h"

@interface PiazzaMessageDetailHeaderView()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *bannerView;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UILabel *titleName;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *userNameTitle;
@property(nonatomic,strong) UILabel *timeTitle;

@end

@implementation PiazzaMessageDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _bannerView = [UIImageView newAutoLayoutView];
        _bannerView.image = [UIImage imageNamed:@"piazza_headerImg"];
        [self addSubview:_bannerView];
        
        _markView = [UIView newAutoLayoutView];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [_bannerView addSubview:_markView];
        
        _titleName = [UILabel newAutoLayoutView];
        _titleName.textColor = [UIColor colorFromHex:0xf8f8f8];
        _titleName.textAlignment = NSTextAlignmentLeft;
        _titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [_markView addSubview:_titleName];
        
        _avatarImgV = [UIImageView newAutoLayoutView];
        _avatarImgV.layer.cornerRadius = FitWith(120.0) *0.5;
        _avatarImgV.layer.masksToBounds = true;
        [_markView addSubview:_avatarImgV];
        
        _userNameTitle = [UILabel newAutoLayoutView];
        _userNameTitle.textColor = [UIColor colorFromHex:0xf8f8f8];
        _userNameTitle.textAlignment = NSTextAlignmentLeft;
        _userNameTitle.font = CUSFONT(14);
        [_markView addSubview:_userNameTitle];
        
        _timeTitle = [UILabel newAutoLayoutView];
        _timeTitle.textColor = [UIColor colorFromHex:0xf8f8f8];
        _timeTitle.textAlignment = NSTextAlignmentRight;
        _timeTitle.font = CUSFONT(11);
        [_markView addSubview:_timeTitle];
        
        [self updateConstraints];
    }
    return self;
}

-(void)setupInfoWithPiazzaData:(PiazzaData *)item{
    _titleName.text = item.title;
    [_avatarImgV sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userNameTitle.text = item.nickName;
    _timeTitle.text = item.createTime;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [_bannerView autoPinEdgesToSuperviewEdges];
        
        [_markView autoPinEdgesToSuperviewEdges];
        
        [_titleName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_titleName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitWith(218.0)];
        
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_avatarImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleName withOffset:FitHeight(32.0)];
        [_avatarImgV autoSetDimension:ALDimensionWidth toSize:FitWith(120.0)];
        [_avatarImgV autoSetDimension:ALDimensionHeight toSize:FitWith(120.0)];
        
        [_userNameTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatarImgV withOffset:FitWith(26.0)];
        [_userNameTitle autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatarImgV];
        
        [_timeTitle autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_userNameTitle];
        [_timeTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
