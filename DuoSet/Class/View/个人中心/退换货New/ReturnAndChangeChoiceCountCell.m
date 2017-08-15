//
//  ReturnAndChangeChoiceCountCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeChoiceCountCell.h"

@interface ReturnAndChangeChoiceCountCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *choiceTypeLable;
@property (nonatomic,strong) UIView *line;

@end

@implementation ReturnAndChangeChoiceCountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _choiceTypeLable = [UILabel newAutoLayoutView];
        _choiceTypeLable.text = @"申请数量";
        _choiceTypeLable.textColor = [UIColor colorFromHex:0x212121];
        _choiceTypeLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_choiceTypeLable];
        
        _numBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(FitWith(26.0), FitHeight(88.0), FitWith(160.0), FitHeight(50.0))];
        _numBtn.editing = false;
        _numBtn.borderColor = [UIColor colorFromHex:0x808080];
        _numBtn.shakeAnimation = YES;
        _numBtn.minValue = 1;
        _numBtn.inputFieldFont = 13;
        _numBtn.increaseTitle = @"＋";
        _numBtn.decreaseTitle = @"－";
        _numBtn.currentNumber = 1;
        __weak typeof(self) weakSelf = self;
        _numBtn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            CountButtonACtionBlock block = weakSelf.btnActionHandle;
            if (block) {
                block(num);
            }
        };
        [self.contentView addSubview:_numBtn];
        
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}



- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_choiceTypeLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_choiceTypeLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
