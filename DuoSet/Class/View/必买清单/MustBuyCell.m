//
//  MustBuyCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "MustBuyCell.h"

@interface MustBuyCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *subTitle;
@property(nonatomic,strong) UILabel *shareLable;
@property(nonatomic,strong) UIButton *seecountBtn;

@end

@implementation MustBuyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgV];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        _titleLable.font = CUSFONT(14);
        [self.contentView addSubview:_titleLable];
        
        _subTitle = [UILabel newAutoLayoutView];
        _subTitle.textColor = [UIColor colorFromHex:0x808080];
        _subTitle.font = CUSFONT(12);
        _subTitle.numberOfLines = 3;
        [self.contentView addSubview:_subTitle];
        
        _shareLable = [UILabel newAutoLayoutView];
        _shareLable.textColor = [UIColor colorFromHex:0x808080];
        _shareLable.font = CUSFONT(12);
        _shareLable.numberOfLines = 3;
        [self.contentView addSubview:_shareLable];
        
        _seecountBtn = [UIButton newAutoLayoutView];
        _seecountBtn.titleLabel.font = CUSFONT(12);
        [_seecountBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_seecountBtn setImage:[UIImage imageNamed:@"comment_seeCount"] forState:UIControlStateNormal];
        _seecountBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
        [self.contentView addSubview:_seecountBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithMustBuyRecommendData:(MustBuyRecommendData *)item{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(750, 280) options:0];
    _titleLable.text = item.title;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(12),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.summary attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.summary.length)];
    _subTitle.attributedText = attributedString;
    _shareLable.text = [NSString stringWithFormat:@"共分享%@个宝贝",item.shareCount];
    [_seecountBtn setTitle:item.pv forState:UIControlStateNormal];
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitHeight(300.0)];
        
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:FitHeight(20.0)];
        
        [_subTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_subTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable withOffset:FitHeight(20.0)];
        
        [_shareLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_shareLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_subTitle withOffset:FitHeight(20.0)];
        
        [_seecountBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_shareLable];
        [_seecountBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareLable withOffset:FitWith(24.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
