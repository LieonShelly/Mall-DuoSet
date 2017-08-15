//
//  PiazzaCommentCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/10.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PiazzaCommentCell.h"

@interface PiazzaCommentCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIImageView *avatar;
@property(nonatomic,strong) UILabel *userName;
@property(nonatomic,strong) UILabel *contenLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation PiazzaCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.layer.cornerRadius = FitWith(60.0) * 0.5;
        _avatar.layer.masksToBounds = true;
        [_bgView addSubview:_avatar];
        
        _userName = [UILabel newAutoLayoutView];
        _userName.textAlignment = NSTextAlignmentLeft;
        _userName.textColor = [UIColor colorFromHex:0x222222];
        _userName.font = CUSFONT(14);
        [_bgView addSubview:_userName];
        
        _contenLable = [UILabel newAutoLayoutView];
        _contenLable.textColor = [UIColor colorFromHex:0x808080];
        _contenLable.font = CUSFONT(12);
        _contenLable.numberOfLines = 0;
        [_bgView addSubview:_contenLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [_bgView addSubview:_line];
        
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithPiazzaCommentData:(PiazzaCommentData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _userName.text = item.nickName;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:CUSFONT(12),
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:item.content attributes:attributes];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,item.content.length)];
    _contenLable.attributedText = attributedString;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(48.0)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(14.0)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitWith(60.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitWith(60.0)];
        
        [_userName autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(30.0)];
        [_userName autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_avatar];
        
        [_contenLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_userName];
        [_contenLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_contenLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:FitHeight(10.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
