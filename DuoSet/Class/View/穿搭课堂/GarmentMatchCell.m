//
//  GarmentMatchCell.m
//  DuoSet
//
//  Created by mac on 2017/1/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "GarmentMatchCell.h"

@interface GarmentMatchCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIImageView *faceImgV;
@property(nonatomic,strong) UILabel *likedLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation GarmentMatchCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _faceImgV = [UIImageView newAutoLayoutView];
        _faceImgV.image = [UIImage imageNamed:@"liked_count"];
        [self.contentView addSubview:_faceImgV];
        
        _likedLable = [UILabel newAutoLayoutView];
        _likedLable.textColor = [UIColor colorFromHex:0x333333];
        _likedLable.textAlignment = NSTextAlignmentCenter;
        _likedLable.text = @"2017次赞";
        _likedLable.font = CUSFONT(13);
        [self.contentView addSubview:_likedLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_faceImgV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_faceImgV autoAlignAxisToSuperviewMarginAxis:ALAxisVertical];
        [_faceImgV autoSetDimension:ALDimensionWidth toSize:FitWith(100.0)];
        [_faceImgV autoSetDimension:ALDimensionHeight toSize:FitWith(100.0)];
        
        [_likedLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_faceImgV withOffset:FitHeight(10.0)];
        [_likedLable autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_likedLable autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
