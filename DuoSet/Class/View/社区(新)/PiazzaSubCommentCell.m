//
//  PiazzaSubCommentCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/23.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaSubCommentCell.h"
#import "MEIQIA_TTTAttributedLabel.h"

@interface PiazzaSubCommentCell()<MEIQIA_TTTAttributedLabelDelegate>

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) MEIQIA_TTTAttributedLabel *contentLable;
@property(nonatomic,strong) UIButton *likeBtn;
@property(nonatomic,strong) UIButton *replyBtn;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation PiazzaSubCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        UserInfo *info = [Utils getUserInfo];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitHeight(50.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_avatar sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:placeholderImage_avatar options:0];
        [self.contentView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textColor = [UIColor colorFromHex:0x808080];
        _userName.font = CUSNEwFONT(16);
        _userName.text = info.name;
        [self.contentView addSubview:_userName];
        
        _contentLable = [MEIQIA_TTTAttributedLabel newAutoLayoutView];
        _contentLable.font = CUSNEwFONT(16);
        _contentLable.textColor = [UIColor colorFromHex:0x222222];
        _contentLable.delegate = self;
        _contentLable.numberOfLines = 0;
        _contentLable.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
        [self.contentView addSubview:_contentLable];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSNEwFONT(14);
        [_likeBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_likeBtn setTitle:@"14" forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"comment_lick_normal"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"comment_like_selected"] forState:UIControlStateSelected];
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -FitWith(20.0));
        [_likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_likeBtn];
        
        _replyBtn = [UIButton newAutoLayoutView];
        _replyBtn.titleLabel.font = CUSNEwFONT(14);
        [_replyBtn setTitle:@"回复" forState:UIControlStateNormal];
        [_replyBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_replyBtn addTarget:self action:@selector(replyButtonAtionHandle) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_replyBtn];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textColor = [UIColor colorFromHex:0x808080];
        _timeLable.font = CUSNEwFONT(14);
        _timeLable.textAlignment= NSTextAlignmentRight;
        [self.contentView addSubview:_timeLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
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

-(void)setupInfoWithPiazzaItemChildCommentData:(PiazzaItemChildCommentData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    if (item.likeCount.integerValue <= 0) {
        [_likeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }else{
        [_likeBtn setTitle:item.likeCount forState:UIControlStateNormal];
    }
    _likeBtn.selected = item.liked;
    //增加间距 _isChildReply
    NSString *text = @"";
    if (item.isChildReply) {
        text = item.commentListContent;
    }else{
        text = item.content;
    }
    [_contentLable setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange fromRange = [[mutableAttributedString string] rangeOfString:@"@" options:NSCaseInsensitiveSearch];
        NSRange toRange = [[mutableAttributedString string] rangeOfString:[NSString stringWithFormat:@"%@", item.relatedUserNickName] options:NSCaseInsensitiveSearch];
        //设定可点击文字的的大小
        UIFont *boldSystemFont = CUSNEwFONT(16);
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            //设置可点击文本的大小
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:toRange];
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:fromRange];
            //设置可点击文本的颜色
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blueColor] CGColor] range:toRange];
            [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor blueColor] CGColor] range:fromRange];
            CFRelease(font);
        }
        return mutableAttributedString;
    }];
    if (item.isChildReply) {
        NSRange toRang = [text rangeOfString:item.relatedUserNickName];
        [_contentLable addLinkToURL:[NSURL URLWithString:[NSString stringWithFormat:@"scheme://?id=%@", item.relatedUserId]] withRange:toRang];
    }
    _timeLable.text = item.createTime;
}


#pragma mark - TYAttributedLabelDelegate
-(void)attributedLabel:(MEIQIA_TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url{
    if ([url.absoluteString hasPrefix:@"scheme://?id="]) {
        NSString *str = [url.absoluteString stringByReplacingOccurrencesOfString:@"scheme://?id=" withString:@""];
        CellUserNameTapActionBlock block = _userNameTapBlock;
        if (block) {
            block(str);
        }
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(120.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(16.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(50.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(30.0)];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(120.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(20.0)];
        
        [_likeBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_contentLable];
        [_likeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(20.0)];
        
        [_replyBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_likeBtn];
        [_replyBtn autoSetDimension:ALDimensionWidth toSize:FitWith(80.0)];
        [_replyBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_likeBtn withOffset:FitWith(30.0)];
        
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_timeLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_likeBtn];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(120.0)];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
