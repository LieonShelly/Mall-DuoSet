//
//  SeckillProductCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/16.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "SeckillProductCell.h"
#import "PercentShowView.h"

@interface SeckillProductCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *coverImgV;
@property(nonatomic,strong) UIView *markView;
@property(nonatomic,strong) UILabel *soldOutLable;
@property(nonatomic,strong) UILabel *productName;
@property(nonatomic,strong) UILabel *originalPriceLable;
@property(nonatomic,strong) UIButton *button;
@property(nonatomic,strong) UILabel *robPriceLable;
@property(nonatomic,strong) UILabel *subLable;
@property(nonatomic,strong) UILabel *buyLable;
@property(nonatomic,strong) PercentShowView *percentView;
@property(nonatomic,strong) UIView *line;


@end

@implementation SeckillProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _coverImgV = [UIImageView newAutoLayoutView];
        _coverImgV.contentMode = UIViewContentModeScaleAspectFill;
        _coverImgV.layer.masksToBounds = true;
        [self.contentView addSubview:_coverImgV];
        
        _markView = [UIView newAutoLayoutView];
        _markView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [_coverImgV addSubview:_markView];
        
        _soldOutLable = [UILabel newAutoLayoutView];
        _soldOutLable.text = @"抢光啦";
        _soldOutLable.textAlignment = NSTextAlignmentCenter;
        _soldOutLable.font = CUSNEwFONT(18);
        _soldOutLable.textColor = [UIColor whiteColor];
        [_coverImgV addSubview:_soldOutLable];
        
        _productName = [UILabel newAutoLayoutView];
        _productName.textColor = [UIColor colorFromHex:0x222222];
        _productName.font = CUSNEwFONT(15);
        _productName.numberOfLines = 2;
        [self.contentView addSubview:_productName];
        
        _originalPriceLable = [UILabel newAutoLayoutView];
        _originalPriceLable.font = CUSNEwFONT(20);
        _originalPriceLable.textAlignment = NSTextAlignmentLeft;
        _originalPriceLable.textColor = [UIColor mainColor];
        [self.contentView addSubview:_originalPriceLable];
        
        _robPriceLable = [UILabel newAutoLayoutView];
        _robPriceLable.font = CUSNEwFONT(14);
        _robPriceLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_robPriceLable];
        
        _button = [UIButton newAutoLayoutView];
        _button.backgroundColor = [UIColor mainColor];
        _button.titleLabel.font = CUSNEwFONT(15);
        _button.layer.cornerRadius = 3;
        _button.layer.masksToBounds = true;
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnActionHandle) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.font = CUSNEwFONT(13);
        _subLable.textAlignment = NSTextAlignmentCenter;
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_subLable];
        
        _buyLable = [UILabel newAutoLayoutView];
        _buyLable.font = CUSNEwFONT(13);
        _buyLable.textAlignment = NSTextAlignmentCenter;
        _buyLable.textColor = [UIColor colorFromHex:0x808080];
        [self.contentView addSubview:_buyLable];
        
        _percentView = [[PercentShowView alloc]initWithFrame:CGRectMake(FitWith(586.0), FitHeight(242.0), FitWith(142.0), FitHeight(14.0))];
        [self.contentView addSubview:_percentView];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)btnActionHandle{
    CellButtonnActionBlock block = _cellBtnActionHandle;
    if (block) {
        block();
    }
}

-(void)setupInfoWithRobProductData:(RobProductData *)item andRobSessionData:(RobSessionData *)robSession{
    [_coverImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImage_226_256 options:0];
    //名字
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(13),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
    _productName.attributedText = attributedString;
    
    //现在价格（名字写反了）
    if (item.curDetailResponse.robPrice != nil) {
        NSString *text = [NSString stringWithFormat:@"￥%.2lf",item.curDetailResponse.robPrice.floatValue];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
        }
        _originalPriceLable.attributedText = attributeString;
    }
    //原价
    NSString *oldPrice = [NSString stringWithFormat:@"原价：￥%@",item.curDetailResponse.price];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:oldPrice
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
    [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                             NSBaselineOffsetAttributeName : @0,
                             NSStrikethroughColorAttributeName : [UIColor colorFromHex:0x666666]
                             }
                     range:NSMakeRange(0, length)];
    _robPriceLable.attributedText = attrStr;
    
    if (robSession.isInRob) {//在抢购中
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forState:UIControlStateNormal];
        if (item.totalSellCount.integerValue >= item.totalCount.integerValue) {//抢完了
            _markView.hidden = false;
            _soldOutLable.hidden = false;
            _subLable.hidden = false;
            _buyLable.hidden = true;
            _percentView.hidden = true;
            [_button setTitle:@"去看看" forState:UIControlStateNormal];
            _subLable.text = @"原价仍有优惠哦";
        }else{
            _markView.hidden = true;
            _soldOutLable.hidden = true;
            _subLable.hidden = true;
            _buyLable.hidden = false;
            _percentView.hidden = false;
            [_button setTitle:@"马上抢" forState:UIControlStateNormal];
            NSString *flotVale = [NSString stringWithFormat:@"%f",item.progress.floatValue * 100];
            _buyLable.text = [NSString stringWithFormat:@"已售%ld%%",flotVale.integerValue];
            [_percentView setFillViewCoveWithProgress:item.progress.floatValue];
        }
    }else{
        _markView.hidden = true;
        _soldOutLable.hidden = true;
        _subLable.hidden = false;
        _buyLable.hidden = true;
        _percentView.hidden = true;
        if (item.isRemind) {
            [_button setTitle:@"取消提醒" forState:UIControlStateNormal];
            [_button setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHex:0xff8484]] forState:UIControlStateNormal];
        }else{
            [_button setTitle:@"开售提醒" forState:UIControlStateNormal];
            [_button setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forState:UIControlStateNormal];
        }
        _subLable.text = [NSString stringWithFormat:@"%@人已关注",item.remindCount];
    }
}

-(void)setupInfoRemindWithRobProductData:(RobProductData *)item{
    _markView.hidden = true;
    _soldOutLable.hidden = true;
    [_coverImgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:placeholderImageSize(110, 110) options:0];
    //名字
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(13),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.productName attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.productName.length)];
    _productName.attributedText = attributedString;
    
    //现在价格（名字写反了）
    if (item.curDetailResponse.robPrice != nil) {
        NSString *text = [NSString stringWithFormat:@"￥%.2lf",item.curDetailResponse.robPrice.floatValue];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSFONT(12) range:NSMakeRange(text.length - 2, 2)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(text.length - 2, 2)];
        }
        _originalPriceLable.attributedText = attributeString;
    }
    //原价
    NSString *oldPrice = [NSString stringWithFormat:@"原价：￥%@",item.curDetailResponse.price];
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor colorFromHex:0x666666] range:NSMakeRange(0, length)];
    [_robPriceLable setAttributedText:attri];
    
    _subLable.hidden = false;
    _buyLable.hidden = true;
    _percentView.hidden = true;
    _subLable.text = [NSString stringWithFormat:@"%@人已提醒",item.remindCount];
    if (item.isRemind) {
        [_button setTitle:@"取消提醒" forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHex:0xff8484]] forState:UIControlStateNormal];
    }else{
        [_button setTitle:@"开售提醒" forState:UIControlStateNormal];
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forState:UIControlStateNormal];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_coverImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(26.0)];
        [_coverImgV autoSetDimension:ALDimensionHeight toSize:FitHeight(222.0)];
        [_coverImgV autoSetDimension:ALDimensionWidth toSize:FitHeight(222.0)];
        
        [_markView autoPinEdgesToSuperviewEdges];
        
        [_soldOutLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_soldOutLable autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_productName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_coverImgV withOffset:FitWith(30.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(44.0)];
        [_productName autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_originalPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_originalPriceLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(160.0)];
        
        [_robPriceLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_productName];
        [_robPriceLable autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:_coverImgV withOffset: -FitHeight(6.0)];
        
        [_button autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_button autoSetDimension:ALDimensionHeight toSize:FitHeight(62.0)];
        [_button autoSetDimension:ALDimensionWidth toSize:FitWith(142.0)];
        [_button autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(156.0)];
        
        [_subLable autoAlignAxis:ALAxisVertical toSameAxisOfView:_button];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        [_buyLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        [_buyLable autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_button withOffset:-FitWith(10.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
