//
//  CommonTipsCell.m
//  DuoSet
//
//  Created by mac on 2017/1/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "CommonTipsCell.h"

@interface CommonTipsCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIView *leftLine;
@property(nonatomic,strong) UIView *leftDotView;
@property(nonatomic,strong) UIView *rightDotView;
@property(nonatomic,strong) UIView *rightLine;

@end

@implementation CommonTipsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf8f8f8];
        
        _leftLine = [UIView newAutoLayoutView];
        _leftLine.backgroundColor = [UIColor colorFromHex:0xf55f8d];
        [self.contentView addSubview:_leftLine];
        
        _leftDotView = [UIView newAutoLayoutView];
        _leftDotView.backgroundColor = [UIColor colorFromHex:0xf55f8d];
        _leftDotView.layer.cornerRadius = FitWith(10) * 0.5;
        _leftDotView.layer.masksToBounds = true;
        [self.contentView addSubview:_leftDotView];
        
        _titleName = [UILabel newAutoLayoutView];
        _titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        _titleName.textColor = [UIColor colorFromHex:0xf55f8d];
        _titleName.textAlignment = NSTextAlignmentCenter;
        _titleName.text = @"超实惠";
        [self.contentView addSubview:_titleName];
        
        _rightDotView = [UIView newAutoLayoutView];
        _rightDotView.backgroundColor = [UIColor colorFromHex:0xf55f8d];
        _rightDotView.layer.cornerRadius = FitWith(10) * 0.5;
        _rightDotView.layer.masksToBounds = true;
        [self.contentView addSubview:_rightDotView];
        
        _rightLine = [UIView newAutoLayoutView];
        _rightLine.backgroundColor = [UIColor colorFromHex:0xf55f8d];
        [self.contentView addSubview:_rightLine];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
    
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_leftLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_leftLine autoSetDimension:ALDimensionHeight toSize:1];
        [_leftLine autoSetDimension:ALDimensionWidth toSize:mainScreenWidth *0.5 - FitWith(120.0)];
        [_leftLine autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_leftDotView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_leftLine];
        [_leftDotView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_leftDotView autoSetDimension:ALDimensionWidth toSize:FitWith(10.0)];
        [_leftDotView autoSetDimension:ALDimensionHeight toSize:FitWith(10.0)];
        
        [_titleName autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_titleName autoAlignAxisToSuperviewAxis:ALAxisVertical];
        
        [_rightLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_rightLine autoSetDimension:ALDimensionHeight toSize:1];
        [_rightLine autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_leftLine];
        [_rightLine autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [_rightDotView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:_rightLine];
        [_rightDotView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_rightDotView autoSetDimension:ALDimensionWidth toSize:FitWith(10.0)];
        [_rightDotView autoSetDimension:ALDimensionHeight toSize:FitWith(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
