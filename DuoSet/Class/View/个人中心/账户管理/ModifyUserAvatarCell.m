//
//  ModifyUserAvatarCell.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ModifyUserAvatarCell.h"

@interface ModifyUserAvatarCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIImageView *arrowImgV;

@end

@implementation ModifyUserAvatarCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textColor = [UIColor colorFromHex:0x333333];
        _tipsLable.font = CUSFONT(14);
        [self.contentView addSubview:_tipsLable];
        
        _avatarImgV = [UIImageView newAutoLayoutView];
        _avatarImgV.contentMode = UIViewContentModeScaleAspectFill;
        _avatarImgV.layer.cornerRadius = FitWith(80.0) * 0.5 ;
        _avatarImgV.layer.masksToBounds = true;
        [self.contentView addSubview:_avatarImgV];
        
        _arrowImgV = [UIImageView newAutoLayoutView];
        _arrowImgV.contentMode = UIViewContentModeRight;
        _arrowImgV.image = [UIImage imageNamed:@"right_arrow"];
        [self.contentView addSubview:_arrowImgV];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_avatarImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(80.0)];
        [_avatarImgV autoSetDimension:ALDimensionWidth toSize:FitWith(80.0)];
        [_avatarImgV autoSetDimension:ALDimensionHeight toSize:FitWith(80.0)];
        
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_arrowImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
