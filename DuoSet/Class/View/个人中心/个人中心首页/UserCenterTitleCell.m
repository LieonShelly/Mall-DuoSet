//
//  UserCenterTitleCell.m
//  DuoSet
//
//  Created by lieon on 2017/6/13.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "UserCenterTitleCell.h"

@interface UserCenterTitleCell()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *arrowView;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,assign) BOOL didUpdateConstraints;
@end
@implementation UserCenterTitleCell

- (void)configTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf3f3f3];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.line];
        [self.bgView addSubview:self.arrowView];
        [self.bgView addSubview:self.titleLabel];
        [self.contentView setNeedsUpdateConstraints];
    }
    return  self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [self.bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        [_arrowView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12];
        [_arrowView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:12];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
    }
    [super updateConstraints];
}

- (UIView *)bgView {
    if (_bgView == nil) {
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor colorFromHex:0x222222];
        _titleLabel.text = @"shequ";
    }
    return _titleLabel;
}

- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        UserInfo *info = [Utils getUserInfo];
        _arrowView = [UIImageView newAutoLayoutView];
        _arrowView.image = [UIImage imageNamed:@"user_center_more"];
        [_arrowView sizeToFit];
    }
    return _arrowView;
}

- (UIView *)line {
    if (_line == nil) {
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
    }
    return _line;
}
@end
