//
//  PiazzaCommentOriginalCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaCommentOriginalCell.h"

@interface PiazzaCommentOriginalCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *contentLable;
@property(nonatomic,strong) UIButton *likeBtn;
@property(nonatomic,strong) UIButton *replyBtn;
@property(nonatomic,strong) UILabel *timeLable;

@end

@implementation PiazzaCommentOriginalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UserInfo *info = [Utils getUserInfo];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitHeight(66.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_avatar sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:placeholderImage_avatar options:0];
        [self.contentView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textColor = [UIColor colorFromHex:0x808080];
        _userName.font = CUSNEwFONT(16);
        _userName.text = info.name;
        [self.contentView addSubview:_userName];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor colorFromHex:0x222222];
        _contentLable.font = CUSNEwFONT(16);
        _contentLable.numberOfLines = 0;
        [self.contentView addSubview:_contentLable];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSNEwFONT(14);
        [_likeBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_likeBtn setImage:[UIImage imageNamed:@"comment_lick_normal"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"comment_like_selected"] forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -FitWith(20.0));
        [self.contentView addSubview:_likeBtn];
        
        _replyBtn = [UIButton newAutoLayoutView];
        _replyBtn.titleLabel.font = CUSNEwFONT(14);
        [_replyBtn setTitle:@"回复" forState:UIControlStateNormal];
        [_replyBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_replyBtn addTarget:self action:@selector(replyButtonAtionHandle) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_replyBtn];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.text = @"05-15";
        _timeLable.textColor = [UIColor colorFromHex:0x808080];
        _timeLable.font = CUSNEwFONT(14);
        _timeLable.textAlignment= NSTextAlignmentRight;
        [self.contentView addSubview:_timeLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)likeBtnAction:(UIButton *)btn{
    CellLikeBtnActionBlock block = _likeHandle;
    if (block) {
        block(btn);
    }
}

-(void)replyButtonAtionHandle{
    CellReplyBtnActionBlock block = _replyHandle;
    if (block) {
        block();
    }
}

-(void)setupInfoWithPiazzaItemCommentData:(PiazzaItemCommentData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    if (item.likeCount.integerValue <= 0) {
        [_likeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }else{
        [_likeBtn setTitle:item.likeCount forState:UIControlStateNormal];
    }
    _likeBtn.selected = item.liked;
    //增加间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSNEwFONT(16),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.content attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.content.length)];
    self.contentLable.attributedText = attributedString;
    
    _timeLable.text = item.createTime;
    _didUpdateConstraints = false;
    [self updateConstraints];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(16.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(66.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(66.0)];
        
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(30.0)];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(100.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(20.0)];
        
        [_likeBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_contentLable];
        [_likeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(20.0)];
        
        [_replyBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_likeBtn];
        [_replyBtn autoSetDimension:ALDimensionWidth toSize:FitWith(80.0)];
        [_replyBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_likeBtn withOffset:FitWith(30.0)];
        
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_timeLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_likeBtn];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
