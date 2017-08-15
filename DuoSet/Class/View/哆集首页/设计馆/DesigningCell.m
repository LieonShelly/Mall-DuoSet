//
//  DesigningCell.m
//  DuoSet
//
//  Created by mac on 2017/1/17.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "DesigningCell.h"

@interface DesigningCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *subTitle;
@property(nonatomic,strong) UILabel *shareLable;

@end

@implementation DesigningCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.layer.masksToBounds = true;
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        [_bgView addSubview:_imgV];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        _titleLable.font = CUSFONT(14);
        [_bgView addSubview:_titleLable];
        
        _subTitle = [UILabel newAutoLayoutView];
        _subTitle.textColor = [UIColor colorFromHex:0x808080];
        _subTitle.font = CUSFONT(12);
        _subTitle.numberOfLines = 3;
        [_bgView addSubview:_subTitle];
        
        _shareLable = [UILabel newAutoLayoutView];
        _shareLable.textColor = [UIColor colorFromHex:0x808080];
        _shareLable.font = CUSFONT(12);
        _shareLable.numberOfLines = 3;
        [_bgView addSubview:_shareLable];
        
        _likeBtn = [UIButton newAutoLayoutView];
        _likeBtn.titleLabel.font = CUSFONT(12);
        [_likeBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_likeBtn setImage:[UIImage imageNamed:@"Design_attention_nomal"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"Design_attention_seletced"] forState:UIControlStateSelected];
        [_likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        [_bgView addSubview:_likeBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


-(void)likeBtnAction:(UIButton *)btn{
    DesigningCellLikeBtnActionBlock block = _likeHandle;
    if (block) {
        block(btn);
    }
}

-(void)setupInfoWithDesignerProductData:(DesignerProductData *)item{
    [_imgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(750, 400) options:0];
    _titleLable.text = item.name;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(12),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.descr attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.descr.length)];
    _subTitle.attributedText = attributedString;
    _shareLable.text = [NSString stringWithFormat:@"热销%@件",item.sellCount];
    [_likeBtn setTitle:item.collectCount forState:UIControlStateNormal];
    _likeBtn.selected = item.collect;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(20.0)];
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitHeight(400.0)];
        
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_titleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:FitHeight(20.0)];
        
        [_subTitle autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_subTitle autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_subTitle autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable withOffset:FitHeight(20.0)];
        
        [_shareLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_shareLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_subTitle withOffset:FitHeight(20.0)];
        
        [_likeBtn autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_shareLable];
        [_likeBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_shareLable withOffset:FitWith(24.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
