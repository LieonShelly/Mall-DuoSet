//
//  ReturnAndChangeInputCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeInputCell.h"

@interface ReturnAndChangeInputCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIView *line;

@end

@implementation ReturnAndChangeInputCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xffffff];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.text = @"问题描述";
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textColor = [UIColor colorFromHex:0x333333];
        _tipsLable.font = CUSFONT(12);
        [self.contentView addSubview:_tipsLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe8e8e8];
        [self.contentView addSubview:_line];
        
        _inputView = [UITextView newAutoLayoutView];
        _inputView.text = @"请再次描述退货理由";
        _inputView.font = CUSFONT(10);
        _inputView.textAlignment = NSTextAlignmentLeft;
        _inputView.textColor = [UIColor colorFromHex:0x666666];
        _inputView.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:_inputView];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)bottomBtnsAction:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(60.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_inputView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line withOffset:FitHeight(10.0)];
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_inputView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_inputView autoSetDimension:ALDimensionHeight toSize:FitHeight(200.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
