//
//  PiazzaHomeCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaHomeCell.h"

@interface PiazzaHomeCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *titleName;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) UILabel *contentLable;
@property(nonatomic,strong) UIImageView *firstImgV;
@property(nonatomic,strong) UIImageView *secoundImgV;
@property(nonatomic,strong) UIImageView *thirdImgV;
@property(nonatomic,strong) NSMutableArray *avatarArr;
@property(nonatomic,strong) UIButton *likeBtn;
@property(nonatomic,strong) UIButton *commentBtn;
@property(nonatomic,assign) BOOL isChoiceness;
@property(nonatomic,strong) UIButton *avatarsBtn;

@end

@implementation PiazzaHomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isChoiceness:(BOOL)isChoiceness{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        _isChoiceness = isChoiceness;
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 3;
        _bgView.layer.masksToBounds = true;
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitWith(88.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_bgView addSubview:_avatar];
        
        _nameLable = [UILabel newAutoLayoutView];
        _nameLable.textAlignment = NSTextAlignmentLeft;
        _nameLable.text = @"社区小助手";
        _nameLable.textColor = [UIColor colorFromHex:0x4d4d4d];
        _nameLable.font = CUSFONT(14);
        [_bgView addSubview:_nameLable];
        
        if (!_isChoiceness) {
            _timeLable = [UILabel newAutoLayoutView];
            _timeLable.text = @"2017-03-16 14:53";
            _timeLable.textColor = [UIColor colorFromHex:0x808080];
            _timeLable.textAlignment = NSTextAlignmentRight;
            _timeLable.font = CUSFONT(11);
            [_bgView addSubview:_timeLable];
        }
        
        _titleName = [UILabel newAutoLayoutView];
        _titleName.text = @"【设计作品】怎么让设计稿变美";
        _titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        _titleName.textAlignment = NSTextAlignmentLeft;
        _titleName.textColor = [UIColor colorFromHex:0x222222];
        [_bgView addSubview:_titleName];
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor colorFromHex:0x808080];
        _contentLable.font = CUSFONT(12);
        _contentLable.text = @"一段很长的话。一段很长的话。一段很长的话。一段很长的话。一段很长的话。一段很长的话。";
        _contentLable.numberOfLines = 0;
        [_bgView addSubview:_contentLable];
        
        _firstImgV = [UIImageView newAutoLayoutView];
        _firstImgV.userInteractionEnabled = true;
        _firstImgV.tag = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTapHandle:)];
        [_firstImgV addGestureRecognizer:tap];
        [_bgView addSubview:_firstImgV];
        
//        if (!_isChoiceness) {
            _secoundImgV = [UIImageView newAutoLayoutView];
            _secoundImgV.userInteractionEnabled = true;
            _secoundImgV.tag = 2;
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTapHandle:)];
            [_secoundImgV addGestureRecognizer:tap2];
            [_bgView addSubview:_secoundImgV];
            
            _thirdImgV = [UIImageView newAutoLayoutView];
            [_bgView addSubview:_thirdImgV];
            _thirdImgV.userInteractionEnabled = true;
            _thirdImgV.tag = 3;
            UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgVTapHandle:)];
            [_thirdImgV addGestureRecognizer:tap3];
//        }
        
        _avatarArr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.layer.cornerRadius = FitWith(62.0) * 0.5;
            imgV.layer.masksToBounds = true;
            [_avatarArr addObject:imgV];
            [_bgView addSubview:imgV];
        }
        
        _avatarsBtn = [UIButton newAutoLayoutView];
        [_avatarsBtn addTarget:self action:@selector(avatarActionHandle) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_avatarsBtn];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSFONT(11);
        [_likeBtn setTitle:@"45" forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"piazza_like_normal"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"piazza_like_seletced"] forState:UIControlStateSelected];
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_likeBtn addTarget:self action:@selector(lickBtnActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_likeBtn];
        
        _commentBtn = [UIButton newAutoLayoutView];
        _commentBtn.titleLabel.font = CUSFONT(11);
        [_commentBtn setTitle:@"45" forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"piazza_comment"] forState:UIControlStateNormal];
        _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        _commentBtn.userInteractionEnabled = false;
        [_bgView addSubview:_commentBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)imgVTapHandle:(UITapGestureRecognizer *)tap{
    ImgVTapActionBlock block = _imgVTapHandle;
    if (block) {
        block(tap.view.tag);
    }
}

-(void)lickBtnActionHandle:(UIButton *)btn{
    likeBtnActionBlock block = _likeHandle;
    if (block) {
        block(btn);
    }
}

-(void)avatarActionHandle{
    AvatarsActionBlock block = _avatarHandle;
    if (block) {
        block();
    }
}

-(void)setupInfoWithPiazzaData:(PiazzaData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _nameLable.text = item.nickName;
    _titleName.text = item.title;
    _timeLable.text = item.createTime;
    _timeLable.hidden = item.top;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName:CUSFONT(12),
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.content attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.content.length)];
    _contentLable.attributedText = attributedString;
    if (item.top) {
        if (item.pics.count > 0) {
            [_firstImgV sd_setImageWithURL:[NSURL URLWithString:item.pics[0]] placeholderImage:placeholderImage_702_420 options:0];
        }
    }else{
        NSArray *imgVArr = @[_firstImgV,_secoundImgV,_thirdImgV];
        for (int i = 0; i < 3 ; i++) {
            UIImageView *imgV = imgVArr[i];
            if (imgV == nil) {
                return;
            }
            if (i < item.pics.count ) {
                imgV.hidden = false;
                [imgV sd_setImageWithURL:[NSURL URLWithString:item.pics[i]] placeholderImage:placeholderImage_702_420 options:0];
            }else{
                imgV.hidden = true;
            }
        }
    }
    _likeBtn.selected = item.likeCommunity;
    [_likeBtn setTitle:item.likeCount forState:UIControlStateNormal];
    [_commentBtn setTitle:item.commentCount forState:UIControlStateNormal];
    NSArray *newArr = [NSArray array];
    if (item.communityLikeReponses.count > 8) {//
        NSMutableArray *arr = [NSMutableArray arrayWithArray:item.communityLikeReponses];
        newArr = [arr subarrayWithRange:NSMakeRange(0,8)];
    }else{
        newArr = item.communityLikeReponses;
    }
    for (int i = 0; i < 9; i++) {
        UIImageView *imgV = _avatarArr[i];
        if (newArr.count == 0) {
            imgV.hidden = true;
            continue;
        }
        if (i < newArr.count) {
            imgV.hidden = false;
            PiazzaUserData *user = newArr[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:user.avastar] placeholderImage:placeholderImage_avatar options:0];
        }else if (i == newArr.count){
            imgV.image = [UIImage imageNamed:@"piazza_more_avatar"];
            continue;
        }else{
            imgV.hidden = true;
            continue;
        }
    }
}

-(void)resetAvatarListAndLikeBtnWithPiazzaData:(PiazzaData *)item{
    [_commentBtn setTitle:item.commentCount forState:UIControlStateNormal];
    _likeBtn.selected = item.likeCommunity;
    [_likeBtn setTitle:item.likeCount forState:UIControlStateNormal];
    NSArray *newArr = [NSArray array];
    if (item.communityLikeReponses.count > 8) {//
        NSMutableArray *arr = [NSMutableArray arrayWithArray:item.communityLikeReponses];
        newArr = [arr subarrayWithRange:NSMakeRange(0,8)];
    }else{
        newArr = item.communityLikeReponses;
    }
    for (int i = 0; i < 9; i++) {
        UIImageView *imgV = _avatarArr[i];
        if (newArr.count == 0) {
            imgV.hidden = true;
            continue;
        }
        if (i <= newArr.count) {
            if (i == newArr.count) {
                imgV.image = [UIImage imageNamed:@"piazza_more_avatar"];
                imgV.hidden = false;
                continue;
            }
            imgV.hidden = false;
            PiazzaUserData *user = newArr[i];
            [imgV sd_setImageWithURL:[NSURL URLWithString:user.avastar] placeholderImage:placeholderImage_avatar options:0];
        }else{
            imgV.hidden = true;
            continue;
        }
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(14.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(88.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(88.0)];
        
        [_nameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(12.0)];
        [_nameLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        
        if (!_isChoiceness) {
            [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
            [_timeLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        }
        
        [_titleName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleName autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(26.0)];
        
        [_contentLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleName];
        [_contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleName withOffset:FitHeight(28.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        if (_isChoiceness) {
            [_firstImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(36.0)];
            [_firstImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            [_firstImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
            [_firstImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(401.0)];
        }else{
            [_firstImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(36.0)];
            [_firstImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
            [_firstImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(300.0)];
            [_firstImgV autoSetDimension:ALDimensionWidth toSize:FitWith(470.0)];
            
            [_secoundImgV autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_firstImgV];
            [_secoundImgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
            [_secoundImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(144.0)];
            [_secoundImgV autoSetDimension:ALDimensionWidth toSize:FitWith(220.0)];
            
            [_thirdImgV autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_firstImgV];
            [_thirdImgV autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_secoundImgV];
            [_thirdImgV autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_secoundImgV];
            [_thirdImgV autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_secoundImgV];
        }
        
        UIImageView *imgView = [[UIImageView alloc]init];
        for (int i = 0; i < 9; i++) {
            UIImageView *imgV = _avatarArr[i];
            [imgV autoSetDimension:ALDimensionHeight toSize:FitWith(62.0)];
            [imgV autoSetDimension:ALDimensionWidth toSize:FitWith(62.0)];
            [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_firstImgV withOffset:FitHeight(30.0)];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16) + (FitWith(62.0) + FitWith(14)) * i];
            imgView = imgV;
        }
        
        [_avatarsBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_firstImgV withOffset:FitHeight(30.0)];
        [_avatarsBtn autoSetDimension:ALDimensionHeight toSize:FitWith(62.0)];
        [_avatarsBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_avatarsBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_likeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imgView withOffset:FitHeight(20.0)];
        [_likeBtn autoSetDimension:ALDimensionHeight toSize:FitWith(62.0)];
        
        [_commentBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_likeBtn];
        [_commentBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_likeBtn withOffset:FitWith(40.0)];
        [_commentBtn autoSetDimension:ALDimensionHeight toSize:FitWith(62.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
