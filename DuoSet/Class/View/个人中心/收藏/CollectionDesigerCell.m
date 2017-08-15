//
//  CollectionDesigerCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/29.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CollectionDesigerCell.h"

@interface CollectionDesigerCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *desigerNameLable;
@property (nonatomic,strong) UILabel *fanscountLabel;
@property (nonatomic,strong) UIView *line;

@end

@implementation CollectionDesigerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        [self.contentView addSubview:_bgView];
        
        _avatar = [UIImageView newAutoLayoutView];
        _avatar.contentMode = UIViewContentModeScaleAspectFill;
        _avatar.layer.masksToBounds = true;
        _avatar.layer.cornerRadius = FitHeight(160.0) * 0.5;
        _avatar.image = [UIImage imageNamed:@"替代11"];
        [_bgView addSubview:_avatar];
        
        _desigerNameLable = [UILabel newAutoLayoutView];
        _desigerNameLable.text = @"设计师名字";
        _desigerNameLable.textColor = [UIColor colorFromHex:0x222222];
        _desigerNameLable.textAlignment = NSTextAlignmentLeft;
        _desigerNameLable.font = CUSFONT(14);
        [_bgView addSubview:_desigerNameLable];
        
        _fanscountLabel = [UILabel newAutoLayoutView];
        _fanscountLabel.textColor = [UIColor colorFromHex:0x666666];
        _fanscountLabel.textAlignment = NSTextAlignmentLeft;
        _fanscountLabel.font = CUSFONT(13);
        _fanscountLabel.text = @"100万粉丝";
        [_bgView addSubview:_fanscountLabel];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [_bgView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithDesignerData:(DesignerData *)item{
    [_avatar sd_setImageWithURL:[NSURL URLWithString:item.avastar] placeholderImage:placeholderImage_avatar options:0];
    _desigerNameLable.text = item.name;
    if (item.followCount.longLongValue > 10000) {
        long follow = item.followCount.longLongValue / 10000;
        _fanscountLabel.text = [NSString stringWithFormat:@"%ld万粉丝",follow];
    }else{
        _fanscountLabel.text = [NSString stringWithFormat:@"%@粉丝",item.followCount];
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgesToSuperviewEdges];
        
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30)];
        [_avatar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24)];
        [_avatar autoSetDimension:ALDimensionWidth toSize:FitHeight(160.0)];
        [_avatar autoSetDimension:ALDimensionHeight toSize:FitHeight(160.0)];
        
        [_desigerNameLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_avatar withOffset:FitWith(44.0)];
        [_desigerNameLable autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_avatar withOffset:FitHeight(20.0)];
        
        [_fanscountLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_desigerNameLable];
        [_fanscountLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_desigerNameLable withOffset:FitHeight(20.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
