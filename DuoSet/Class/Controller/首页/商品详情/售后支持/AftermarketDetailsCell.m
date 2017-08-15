//
//  AftermarketDetailsCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/3.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AftermarketDetailsCell.h"

@interface AftermarketDetailsCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@property(nonatomic,strong) UIImageView *iconImgV;
@property(nonatomic,strong) UILabel *titleLable;
@property(nonatomic,strong) UILabel *subTitleLale;
@property(nonatomic,strong) UIView *line;

@end

@implementation AftermarketDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _iconImgV = [UIImageView newAutoLayoutView];
        [self.contentView addSubview:_iconImgV];
        
        _titleLable = [UILabel newAutoLayoutView];
        _titleLable.textColor = [UIColor colorFromHex:0x222222];
        _titleLable.font = CUSNEwFONT(16);
        _titleLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLable];
        
        _subTitleLale = [UILabel newAutoLayoutView];
        _subTitleLale.textColor = [UIColor colorFromHex:0x808080];
        _subTitleLale.font = CUSNEwFONT(14);
        _subTitleLale.numberOfLines = 0;
        _subTitleLale.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_subTitleLale];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithProductDetailsArticle:(ProductDetailsArticle *)item{
    [_iconImgV sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:placeholderImage_226_256 options:0];
    _titleLable.text = item.name;
    _subTitleLale.text = item.remark;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_iconImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_iconImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        [_iconImgV autoSetDimension:ALDimensionWidth toSize:FitWith(40.0)];
        [_iconImgV autoSetDimension:ALDimensionHeight toSize:FitWith(40.0)];
        
        [_titleLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_iconImgV withOffset:FitWith(10.0)];
        [_titleLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_iconImgV];
        [_titleLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_subTitleLale autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_titleLable];
        [_subTitleLale autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_subTitleLale autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_titleLable withOffset:FitHeight(10.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
