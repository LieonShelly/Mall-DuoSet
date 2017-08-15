//
//  StandarCountChoiceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/2.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "StandarCountChoiceCell.h"
@interface StandarCountChoiceCell()

@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) UILabel *countLable;
@property (nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation StandarCountChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _topLine = [UIView newAutoLayoutView];
        _topLine.backgroundColor = [UIColor colorFromHex:0xe6e6e6];
        [self.contentView addSubview:_topLine];
        
        _countLable = [UILabel newAutoLayoutView];
        _countLable.textColor = [UIColor colorFromHex:0x666666];
        _countLable.font = CUSFONT(13);
        _countLable.textAlignment = NSTextAlignmentLeft;
        _countLable.text = @"数量";
        [self.contentView addSubview:_countLable];
        
        _numBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(mainScreenWidth - FitWith(150.0) - FitWith(40) , FitHeight(20.0), FitWith(150.0), FitHeight(50.0))];
        _numBtn.editing = true;
        _numBtn.borderColor = [UIColor grayColor];
        _numBtn.shakeAnimation = YES;
        _numBtn.minValue = 1;
        //        _numBtn.maxValue = 10;
        _numBtn.inputFieldFont = 11;
        _numBtn.increaseTitle = @"＋";
        _numBtn.decreaseTitle = @"－";
        _numBtn.currentNumber = 1;
        _numBtn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            NSLog(@"num : %ld",num);
            ChangeProductAmountBlock block = _amountChangeHandle;
            if (block) {
                block(num);
            }
        };
        [self.contentView addSubview:_numBtn];
        
        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_topLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_topLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_topLine autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_topLine autoSetDimension:ALDimensionHeight toSize:1];
        
        [_countLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_countLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_countLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
