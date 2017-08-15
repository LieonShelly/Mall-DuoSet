//
//  CommentDetailsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/14.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentDetailsCell.h"

@interface CommentDetailsCell()

@property(nonatomic,strong) CommentDetailsData *item;
@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *timeLable;
@property(nonatomic,strong) NSMutableArray *starImgVArr;
@property(nonatomic,strong) UILabel *contentLable;

@end

@implementation CommentDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier commentData:(CommentDetailsData *)item{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _item = item;
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        self.contentView.userInteractionEnabled = true;
        UserInfo *info = [Utils getUserInfo];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = true;
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitWith(60.0) * 0.5;
        [_avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseImgUrl,info.avatar]] placeholderImage:placeholderImage_avatar options:0];
        _avatar.layer.masksToBounds = true;
        [_bgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.font = CUSFONT(11);
        _userName.text = info.name;
        [_bgView addSubview:_userName];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.font = CUSFONT(11);
        _timeLable.textColor = [UIColor colorFromHex:0xb2b2b2];
        _timeLable.text = item.createTime;
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
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:CUSFONT(12),
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.content attributes:attributes];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.content.length)];
        _contentLable.attributedText = attributedString;
        [_bgView addSubview:_contentLable];
        [self.contentView setNeedsUpdateConstraints];
        
        [self setupStarShowWithScore:_item.score];
    }
    return self;
}

-(void)setupStarShowWithScore:(NSString *)score{
    NSInteger starCount = score.integerValue / 20;
    for (int i = 1; i < 6; i++) {
        UIImageView *imgV = _starImgVArr[i - 1];
        imgV.image = i <=starCount ? [UIImage imageNamed:@"commentList_star"] : [UIImage imageNamed:@"commentList_star_lightgray"];
    }
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    CommentTapBlock block = _tapHandle;
    if (block) {
        block(tap.view.tag);
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
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
