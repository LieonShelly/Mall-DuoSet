//
//  ActivityCell.m
//  DuoSet
//
//  Created by fanfans on 1/3/17.
//  Copyright © 2017 Seven-Augus. All rights reserved.
//

#import "ActivityCell.h"

@interface ActivityCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *timeLable;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *activityTitleLable;
@property (nonatomic,strong) UIImageView *imgV;
@property (nonatomic,strong) UILabel *subTitleLable;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *detailsLable;
@property (nonatomic,strong) UIImageView *rightArrow;

@end

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf3f4f7];
        
        _timeLable = [UILabel newAutoLayoutView];
        _timeLable.textAlignment = NSTextAlignmentCenter;
        _timeLable.textColor = [UIColor colorFromHex:0x808080];
        _timeLable.font = CUSFONT(11);
        [self.contentView addSubview:_timeLable];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderWidth = 1;
        _bgView.layer.cornerRadius = 3;
        _bgView.layer.borderColor = [UIColor colorFromHex:0xe5e5e5].CGColor;
        [self.contentView addSubview:_bgView];
        
        _activityTitleLable = [UILabel newAutoLayoutView];
        _activityTitleLable.textColor = [UIColor colorFromHex:0x222222];
        _activityTitleLable.font = CUSFONT(14);
        _activityTitleLable.textAlignment = NSTextAlignmentLeft;
        _activityTitleLable.numberOfLines = 1;
        [_bgView addSubview:_activityTitleLable];
        
        _imgV = [UIImageView newAutoLayoutView];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.layer.masksToBounds = true;
        _imgV.layer.cornerRadius = 3;
        [_bgView addSubview:_imgV];
        
        _subTitleLable = [UILabel newAutoLayoutView];
        _subTitleLable.textColor = [UIColor colorFromHex:0x222222];
        _subTitleLable.numberOfLines = 2;
        _subTitleLable.font = CUSFONT(14);
        _subTitleLable.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_subTitleLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [_bgView addSubview:_line];
        
        _detailsLable = [UILabel newAutoLayoutView];
        _detailsLable.textColor = [UIColor colorFromHex:0x808080];
        _detailsLable.text = @"查看详情";
        _detailsLable.font = CUSFONT(12);
        _detailsLable.textAlignment = NSTextAlignmentLeft;
        [_bgView addSubview:_detailsLable];
        
        _rightArrow = [UIImageView newAutoLayoutView];
        _rightArrow.image = [UIImage imageNamed:@"right_arrow"];
        _rightArrow.contentMode = NSTextAlignmentCenter;
        [_bgView addSubview:_rightArrow];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_timeLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_timeLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_timeLable autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_bgView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_timeLable];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_bgView autoSetDimension:ALDimensionHeight toSize:FitHeight(514.0)];
        
        [_activityTitleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_activityTitleLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_activityTitleLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_activityTitleLable autoSetDimension:ALDimensionHeight toSize:FitHeight(80.0)];
        
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_imgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(16.0)];
        [_imgV autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_activityTitleLable];
        [_imgV autoSetDimension:ALDimensionHeight toSize:FitHeight(270.0)];
        
        [_subTitleLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_imgV withOffset:FitHeight(5)];
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_subTitleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(16.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(16.0)];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(60.0)];
        
        [_detailsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(16.0)];
        [_detailsLable autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_detailsLable autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        [_detailsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_rightArrow autoSetDimension:ALDimensionHeight toSize:FitHeight(30.0)];
        [_rightArrow autoSetDimension:ALDimensionWidth toSize:FitHeight(30.0)];
        [_rightArrow autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_detailsLable];
        [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)setupDataInfoWithActivityData:(ActivityData *)item{
    _timeLable.text = item.createTime;
    _activityTitleLable.text = item.title;
    [_imgV sd_setImageWithURL:[NSURL URLWithString:item.cover] placeholderImage:[UIImage imageNamed:@"数据加载失败"] options:0];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                  NSFontAttributeName:CUSFONT(14),
                                  NSParagraphStyleAttributeName:paragraphStyle

                                 };
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.descr attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.descr.length)];
    _subTitleLable.attributedText = attributedString;
    
}

@end
