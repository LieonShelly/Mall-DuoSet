//
//  ReturnAndChangeDesInputCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeDesInputCell.h"

@interface ReturnAndChangeDesInputCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *resionTipLable;
@property (nonatomic,strong) UIView *InputBgView;
@property (nonatomic,strong) UILabel *subLable;

@end

@implementation ReturnAndChangeDesInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _resionTipLable = [UILabel newAutoLayoutView];
        _resionTipLable.text = @"问题描述";
        _resionTipLable.textColor = [UIColor colorFromHex:0x212121];
        _resionTipLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_resionTipLable];
        
        _rightTipsLable = [UILabel newAutoLayoutView];
        _rightTipsLable.text = @"注：换货请注明换货的型号或颜色尺寸";
        _rightTipsLable.textColor = [UIColor mainColor];
        _rightTipsLable.font = CUSNEwFONT(14);
        _rightTipsLable.textAlignment = NSTextAlignmentLeft;
        _rightTipsLable.hidden = true;
        [self.contentView addSubview:_rightTipsLable];
        
        _InputBgView = [UIView newAutoLayoutView];
        _InputBgView.backgroundColor = [UIColor colorFromHex:0xfafafa];
        _InputBgView.userInteractionEnabled = true;
        [self.contentView addSubview:_InputBgView];
        
        _inputView = [UITextView newAutoLayoutView];
        _inputView.backgroundColor = [UIColor colorFromHex:0xfafafa];
        _inputView.placeholder = @"请您输入问题描述";
        _inputView.font = CUSNEwFONT(14);
        _inputView.editable = true;
        _inputView.textColor = [UIColor colorFromHex:0x222222];
        [_InputBgView addSubview:_inputView];
        
        _subLable = [UILabel newAutoLayoutView];
        _subLable.textColor = [UIColor colorFromHex:0x808080];
        _subLable.text = @"不超过200字";
        _subLable.font = CUSNEwFONT(14);
        [_InputBgView addSubview:_subLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_resionTipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_resionTipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_rightTipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_resionTipLable withOffset:10];
        [_rightTipsLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_resionTipLable];
        
        [_InputBgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_InputBgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_InputBgView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(82.0)];
        [_InputBgView autoSetDimension:ALDimensionHeight toSize:FitHeight(250.0)];
        
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(20.0)];
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(60.0)];
        
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_subLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(10.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
