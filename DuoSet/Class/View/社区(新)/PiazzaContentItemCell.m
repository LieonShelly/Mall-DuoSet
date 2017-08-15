
//
//  PiazzaContentItemCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaContentItemCell.h"

@interface PiazzaContentItemCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *markView;
@property (nonatomic,strong) UILabel *statusLable;
@property (nonatomic,strong) UIButton *allowBtn;
@property (nonatomic,strong) UILabel *nameLable;
@property (nonatomic,strong) UILabel *subLable;
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,assign) CGFloat coverImgVHight;

@end

@implementation PiazzaContentItemCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.shadowColor = [UIColor grayColor].CGColor;
        _bgView.layer.shadowRadius = 5;
        _bgView.layer.shadowOpacity = 0.3;
        _bgView.layer.shadowOffset = CGSizeMake(0, 0);
        [self.contentView addSubview:_bgView];
        
        _cover = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,FitWith(342.0),0)];
        _cover.contentMode = UIViewContentModeScaleAspectFill;
        _cover.layer.masksToBounds = true;
        [_bgView addSubview:_cover];
        
        _markView = [UIView newAutoLayoutView];
        _markView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _markView.hidden = true;
        [_cover addSubview:_markView];
        
        _statusLable = [UILabel newAutoLayoutView];
        _statusLable.textAlignment = NSTextAlignmentCenter;
        _statusLable.font = CUSNEwFONT(18);
        _statusLable.textColor = [UIColor whiteColor];
        _statusLable.numberOfLines = 0;
        [_cover addSubview:_statusLable];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        _nameLable.textColor = [UIColor colorFromHex:0x222222];
        _nameLable.numberOfLines = 2;
        [_bgView addSubview:_nameLable];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.font = CUSNEwFONT(12);
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        _subLable.numberOfLines = 2;
        [_bgView addSubview:_subLable];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitWith(68.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_bgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textColor = [UIColor colorFromHex:0x666666];
        _userName.font = CUSNEwFONT(12);
        [_bgView addSubview:_userName];
        
        _allowBtn = [UIButton newAutoLayoutView];
        _allowBtn.titleLabel.font = CUSNEwFONT(14);
        _allowBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -FitWith(10.0), 0, 0);
        _allowBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -FitWith(10.0));
        [_allowBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_allowBtn setImage:[UIImage imageNamed:@"piazza_home_allow_normol"] forState:UIControlStateNormal];
        [_allowBtn setImage:[UIImage imageNamed:@"piazza_home_allow_seletced"] forState:UIControlStateSelected];
        [_allowBtn addTarget:self action:@selector(allowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_allowBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)allowButtonAction:(UIButton *)btn{
    AllowButtonActionBlock block = _allowHandle;
    if (block) {
        block(btn);
    }
}

-(void)setupInfoCollectWithPiazzaItemData:(PiazzaItemData *)item{
    [_allowBtn setImage:[UIImage imageNamed:@"Design_attention_nomal"] forState:UIControlStateNormal];
    [_allowBtn setImage:[UIImage imageNamed:@"Design_attention_seletced"] forState:UIControlStateSelected];
    CGRect frame = _cover.frame;
    frame.size.height = item.coverHight;
    _cover.frame = frame;
    _didUpdateConstraints = false;
    [self updateConstraints];
    
    [_cover sd_setImageWithURL:[NSURL URLWithString:item.coverPic] placeholderImage:placeholderImageSize(170, item.coverHight)  options:0];
    _coverImgVHight = item.coverHight;
    [self.contentView needsUpdateConstraints];
    
    _nameLable.text = item.title;
    _subLable.text = item.content;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    _allowBtn.selected = item.isCollect;
    [_allowBtn setTitle:item.collectNum forState:UIControlStateNormal];
    UserInfo *info = [Utils getUserInfo];
    if ([item.userId isEqualToString:info.userId]) {
        if (item.status == CommunityStautsDefault) {
            _markView.hidden = true;
            _statusLable.text = @"";
        }else if (item.status == CommunityStautsNoCheck){
            _markView.hidden = false;
            _statusLable.text = @"审核中";
        }else if (item.status == CommunityStautsCheckFail){
            _markView.hidden = false;
            NSString *text = [NSString stringWithFormat:@"审核失败\n%@",item.checkReason];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
            [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(16) range:NSMakeRange(4,text.length - 4)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(4,text.length - 4)];
            _statusLable.attributedText = attributeString;
        }
    }
}

-(void)setupInfoWithPiazzaItemData:(PiazzaItemData *)item imgVloadEndHandle:(void (^)())imgVloadEndHandle{
    CGRect frame = _cover.frame;
    frame.size.height = item.coverHight;
    _cover.frame = frame;
    _didUpdateConstraints = false;
    [self updateConstraints];
    
    [_cover sd_setImageWithURL:[NSURL URLWithString:item.coverPic] placeholderImage:placeholderImageSize(170, 200) options:0];
    _coverImgVHight = item.coverHight;
    [self.contentView needsUpdateConstraints];
    
    _nameLable.text = item.title;
    _subLable.text = item.content;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    _allowBtn.selected = item.isLike;
    [_allowBtn setTitle:item.likeCount forState:UIControlStateNormal];
    UserInfo *info = [Utils getUserInfo];
    if ([item.userId isEqualToString:info.userId]) {
        if (item.status == CommunityStautsDefault) {
            _markView.hidden = true;
            _statusLable.text = @"";
        }else if (item.status == CommunityStautsNoCheck){
            _markView.hidden = false;
            _statusLable.text = @"审核中";
        }else if (item.status == CommunityStautsCheckFail){
            _markView.hidden = false;
            NSString *text = [NSString stringWithFormat:@"审核失败\n%@",item.checkReason];
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
            [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(16) range:NSMakeRange(4,text.length - 5)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(4,text.length - 5)];
            _statusLable.attributedText = attributeString;
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)].CGPath;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_markView autoPinEdgesToSuperviewEdges];
        
        [_statusLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_statusLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(22.0)];
        [_nameLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(22.0)];
        [_nameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cover withOffset:FitHeight(20.0)];
        
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(22.0)];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(22.0)];
        [_subLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameLable withOffset:FitHeight(6.0)];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(68.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(68.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(80.0)];
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(20.0)];
        
        [_allowBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_allowBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
                
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
