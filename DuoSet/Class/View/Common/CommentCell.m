//
//  CommentCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/8.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentCell.h"

@interface CommentCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) NSMutableArray *starImgVArr;
@property(nonatomic,strong) UILabel *contentLable;
@property(nonatomic,strong) UIScrollView *imgScrollView;
@property(nonatomic,strong) NSMutableArray *imgVArr;
@property(nonatomic,strong) UILabel *subTitle;
@property(nonatomic,strong) UIButton *seeBtn;
@property(nonatomic,strong) UIButton *likeBtn;

@end

@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        self.contentView.userInteractionEnabled = true;
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = true;
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitWith(60.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_bgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.font = CUSFONT(11);
        [_bgView addSubview:_userName];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.font = CUSFONT(11);
        _timeLable.textColor = [UIColor colorFromHex:0xb2b2b2];
        [_bgView addSubview:_timeLable];
        
        _starImgVArr = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            UIImageView *imgV = [UIImageView newAutoLayoutView];
            imgV.image = [UIImage imageNamed:@"commentList_star"];
            imgV.contentMode = UIViewContentModeScaleAspectFill;
            [_starImgVArr addObject:imgV];
            [_bgView addSubview:imgV];
        }
        
        _contentLable = [UILabel newAutoLayoutView];
        _contentLable.textColor = [UIColor colorFromHex:0x222222];
        _contentLable.font = CUSFONT(12);
        _contentLable.numberOfLines = 0;
        [_bgView addSubview:_contentLable];
        
        _imgScrollView = [UIScrollView newAutoLayoutView];
        _imgScrollView.contentSize = CGSizeMake(FitWith(240.0) * 10, 0);
        _imgScrollView.showsHorizontalScrollIndicator = false;
        _imgScrollView.userInteractionEnabled = true;
        [_bgView addSubview:_imgScrollView];
        
        _imgVArr = [NSMutableArray array];
        for (int i = 0 ; i < 10 ; i++) {
            UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake((FitWith(20) + (FitHeight(220.0) +FitWith(20.0))* i), 0, FitHeight(220.0), FitHeight(220.0))];
            imgV.tag = i;
            imgV.userInteractionEnabled = true;
            [_imgVArr addObject:imgV];
            UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTapAction:)];
            [imgV addGestureRecognizer:g];
            [_imgScrollView addSubview:imgV];
        }
        
        _subTitle = [UILabel newAutoLayoutView];
        _subTitle.textAlignment = NSTextAlignmentLeft;
        _subTitle.textColor = [UIColor colorFromHex:0xb2b2b2];
        _subTitle.font = CUSFONT(11);
        [_bgView addSubview:_subTitle];
        
        _seeBtn = [UIButton newAutoLayoutView];
        _seeBtn.titleLabel.font = CUSFONT(11);
        [_seeBtn setImage:[UIImage imageNamed:@"comment_seeCount"] forState:UIControlStateNormal];
        [_seeBtn setTitle:@"43" forState:UIControlStateNormal];
        [_seeBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_bgView addSubview:_seeBtn];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSFONT(11);
        [_likeBtn setTitle:@"98" forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"comment_lick_normal"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"comment_like_selected"] forState:UIControlStateSelected];
        [_likeBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(lickBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bgView addSubview:_likeBtn];
        
        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}
-(void)lickBtnAction:(UIButton *)btn{
    CommentlikeBtnActionBlock block = _lickBtnActionHandle;
    if (block) {
        block(btn);
    }
}

-(void)imgTapAction:(UITapGestureRecognizer *)tap{
    CommentImgVTapBlock block = _imgVTapActionHandle;
    if (block) {
        block(tap.view.tag);
    }
}

-(void)setupInfoWithCommentData:(CommentData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    _timeLable.text = item.createTime;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(12),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                  };
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.content attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.content.length)];
    _contentLable.attributedText = attributedString;
    _imgScrollView.contentSize = CGSizeMake(FitWith(20) + FitHeight(240.0) * item.pics.count, 0);
    if (item.pics.count > 0) {
        for (int i = 0; i < item.pics.count; i++) {
            UIImageView *imgV = _imgVArr[i];
//            [imgV sd_setImageWithURL:[NSURL URLWithString:item.pics[i]] placeholderImage:placeholderImage_226_256 options:0];
            [imgV sd_setImageWithURL:[NSURL URLWithString:item.pics[i]] placeholderImage:placeholderImage_226_256 options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    NSLog(@"sd_setImageWithURL - err:%@",error.description);
                }
            }];
        }
    }else{
        [_subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(28.0)];
    }
    _subTitle.text = item.propertyName;
    [_seeBtn setTitle:[NSString stringWithFormat:@"%@ ",item.seeCount] forState:UIControlStateNormal];
    [_likeBtn setTitle:[NSString stringWithFormat:@"%@ ",item.goodCount] forState:UIControlStateNormal];
    _seeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    _seeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _likeBtn.selected = item.isLike;
    [self setupStarShowWithScore:item.score];
}

-(void)setupStarShowWithScore:(NSString *)score{
    NSInteger starCount = score.integerValue / 20;
    for (int i = 1; i < 6; i++) {
        UIImageView *imgV = _starImgVArr[i - 1];
        imgV.image = i <=starCount ? [UIImage imageNamed:@"commentList_star"] : [UIImage imageNamed:@"commentList_star_lightgray"];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(37.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(60.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(60.0)];
        
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(21.0)];
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(FitWith(30.0))];
        [_timeLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        
        for (int i = 0; i < 5; i++) {
            UIImageView *imgV = _starImgVArr[i];
            [imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(16.0)];
            [imgV autoSetDimension:ALDimensionWidth toSize:FitWith(20.0)];
            [imgV autoSetDimension:ALDimensionHeight toSize:FitWith(20.0)];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0) + FitWith(25.0) * i];
        }
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(150.0)];
        
        [_imgScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(28.0)];
        [_imgScrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgScrollView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgScrollView autoSetDimension:ALDimensionHeight toSize:FitHeight(220.0)];
        
        [_subTitle autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_contentLable];
        [_subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgScrollView withOffset:FitHeight(28.0)];
        
        [_likeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
//        [_likeBtn autoSetDimension:ALDimensionWidth toSize:FitWith(200.0)];
        [_likeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_subTitle];
        
        [_seeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_subTitle];
        [_seeBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_likeBtn withOffset:-FitWith(34.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
