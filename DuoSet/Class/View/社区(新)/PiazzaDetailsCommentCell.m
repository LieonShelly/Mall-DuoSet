//
//  PiazzaDetailsCommentCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaDetailsCommentCell.h"

@interface PiazzaDetailsCommentCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *contentLable;
@property(nonatomic,strong) UIButton *likeBtn;
@property(nonatomic,strong) UIButton *replyBtn;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UIView *replyView;
@property(nonatomic,strong) UILabel *replyContentLable;
@property(nonatomic,strong) UIButton *moreReplyBtn;

@property(nonatomic,assign) CGFloat replyViewHight;

@end

@implementation PiazzaDetailsCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _replyViewHight = 0.0;
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitHeight(66.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [self.contentView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textColor = [UIColor colorFromHex:0x808080];
        _userName.font = CUSNEwFONT(16);
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
        [_replyBtn addTarget:self action:@selector(replyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_replyBtn];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textColor = [UIColor colorFromHex:0x808080];
        _timeLable.font = CUSNEwFONT(14);
        _timeLable.textAlignment= NSTextAlignmentRight;
        [self.contentView addSubview:_timeLable];
        
        _replyView = [UIView newAutoLayoutView];
        _replyView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        [self.contentView addSubview:_replyView];
        
        _replyContentLable = [UILabel newAutoLayoutView];
        _replyContentLable.textColor = [UIColor colorFromHex:0x222222];
        _replyContentLable.font = CUSNEwFONT(16);
        _replyContentLable.numberOfLines = 0;
        [_replyView addSubview:_replyContentLable];
        
        _moreReplyBtn = [UIButton newAutoLayoutView];
        [_moreReplyBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _moreReplyBtn.titleLabel.font = CUSNEwFONT(14);
        [_moreReplyBtn addTarget:self action:@selector(replyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_replyView addSubview:_moreReplyBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)replyBtnAction{
    CellReplyBtnActionBlock block = _replyBtnHandle;
    if (block) {
        block();
    }
}

-(void)likeBtnAction:(UIButton *)btn{
    CellLikeBtnActionBlock block = _likeBtnHandle;
    if (block) {
        block(btn);
    }
}

-(void)setUpInfoWithPiazzaItemCommentData:(PiazzaItemCommentData *)item{
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
                                 NSFontAttributeName:[UIFont systemFontOfSize:13],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.content attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.content.length)];
    self.contentLable.attributedText = attributedString;
    _timeLable.text = item.createTime;
    if (item.childResponses.count > 0) {
        _replyView.hidden = false;
        PiazzaItemChildCommentData *childData = item.childResponses[0];
        [_moreReplyBtn setTitle:[NSString stringWithFormat:@"共%@条回复>",item.childTotalCount] forState:UIControlStateNormal];
        _replyViewHight = childData.mainChildHight;
        //属性字符串 增加间距 颜色
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 3;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:CUSNEwFONT(16),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        NSString *text = childData.mainChildContent;
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text attributes:attributes];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(16) range:NSMakeRange(0, childData.nickName.length + 1)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHex:0x808080] range:NSMakeRange(0, childData.nickName.length + 1)];
        }
        self.replyContentLable.attributedText = attributeString;
    }else{
        _replyView.hidden = true;
    }
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
        
        [_replyView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(100.0)];
        [_replyView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_replyView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_likeBtn withOffset:FitHeight(20.0)];
        [_replyView autoSetDimension:ALDimensionHeight toSize:_replyViewHight];
        
        [_replyContentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(6)];
        [_replyContentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(6)];
        [_replyContentLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10)];
        
        [_moreReplyBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_replyContentLable withOffset:3];
        [_moreReplyBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(6)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
