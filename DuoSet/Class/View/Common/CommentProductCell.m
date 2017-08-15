//
//  CommentProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/4.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommentProductCell.h"

@interface CommentProductCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) NSMutableArray *starImgVArr;
@property(nonatomic,strong) UILabel *contentLable;
@property(nonatomic,strong) UIScrollView *imgScrollView;
@property(nonatomic,strong) NSMutableArray *imgVArr;
@property(nonatomic,strong) UIView *line;

@end

@implementation CommentProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        self.contentView.userInteractionEnabled = true;
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = true;
        [self.contentView addSubview:_bgView];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.font = CUSFONT(11);
        [_bgView addSubview:_userName];
        
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
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}

-(void)imgTapAction:(UITapGestureRecognizer *)tap{
    CommentImgVTapBlock block = _imgVTapActionHandle;
    if (block) {
        block(tap.view.tag);
    }
}

-(void)setupInfoWithCommentData:(CommentData *)item{
    _userName.text = item.nickName;
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
            [imgV sd_setImageWithURL:[NSURL URLWithString:item.pics[i]] placeholderImage:placeholderImage_226_256 options:0];
        }
    }
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
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_userName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        
        for (int i = 0; i < 5; i++) {
            UIImageView *imgV = _starImgVArr[i];
            [imgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_userName];
            [imgV autoSetDimension:ALDimensionWidth toSize:FitWith(20.0)];
            [imgV autoSetDimension:ALDimensionHeight toSize:FitWith(20.0)];
            [imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(610.0) + FitWith(25.0) * i];
        }
        
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_contentLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(72.0)];
        
        [_imgScrollView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:FitHeight(28.0)];
        [_imgScrollView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgScrollView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgScrollView autoSetDimension:ALDimensionHeight toSize:FitHeight(220.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
