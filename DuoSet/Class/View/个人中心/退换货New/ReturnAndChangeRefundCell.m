//
//  ReturnAndChangeRefundCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeRefundCell.h"

@interface ReturnAndChangeRefundCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *tipLable;
@property (nonatomic,strong) UIButton *returnBtn;
@property (nonatomic,strong) UIView *line;

@end

@implementation ReturnAndChangeRefundCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.text = @"退款方式";
        _tipLable.textColor = [UIColor colorFromHex:0x212121];
        _tipLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_tipLable];
        
        _returnBtn = [UIButton newAutoLayoutView];
        _returnBtn.titleLabel.font = CUSNEwFONT(16);
        [_returnBtn setTitle:@"原支付返还" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _returnBtn.layer.borderWidth = 0.5;
        _returnBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _returnBtn.layer.cornerRadius = 3;
        _returnBtn.userInteractionEnabled = false;
        [self.contentView addSubview:_returnBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_returnBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipLable];
        [_returnBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipLable withOffset:FitHeight(20.0)];
        [_returnBtn autoSetDimension:ALDimensionWidth toSize:FitWith(200.0)];
        [_returnBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
