//
//  PayWayCell.m
//  DuoSet
//
//  Created by mac on 2017/1/6.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "PayWayCell.h"

@interface PayWayCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;

@end

@implementation PayWayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipImgV = [UIImageView newAutoLayoutView];
        _tipImgV.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_tipImgV];
        
        _infoLable = [UILabel newAutoLayoutView];
        _infoLable.textAlignment = NSTextAlignmentLeft;
        _infoLable.textColor = [UIColor colorFromHex:0x333333];
        _infoLable.font = CUSFONT(14);
        [self.contentView addSubview:_infoLable];
        
        _selectedBtn =[UIButton newAutoLayoutView];
        _selectedBtn.contentMode = UIViewContentModeCenter;
        _selectedBtn.userInteractionEnabled = false;
        [_selectedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectedBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipImgV autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [_tipImgV autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipImgV autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_tipImgV autoSetDimension:ALDimensionWidth toSize:FitWith(80.0)];
        
        [_infoLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_tipImgV];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_infoLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_selectedBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_selectedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(80.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
