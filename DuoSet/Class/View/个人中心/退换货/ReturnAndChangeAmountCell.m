//
//  ReturnAndChangeAmountCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeAmountCell.h"
#import "PPNumberButton.h"

@interface ReturnAndChangeAmountCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *tipsLable;

@end

@implementation ReturnAndChangeAmountCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xffffff];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.text = @"申请数量";
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textColor = [UIColor colorFromHex:0x333333];
        _tipsLable.font = CUSFONT(12);
        [self.contentView addSubview:_tipsLable];
        
        _numBtn = [PPNumberButton numberButtonWithFrame:CGRectMake(FitWith(30.0), FitHeight(60.0), FitWith(140.0), FitHeight(40.0))];
        _numBtn.editing = false;
        _numBtn.borderColor = [UIColor grayColor];
        _numBtn.shakeAnimation = YES;
        _numBtn.minValue = 1;
        //        _numBtn.maxValue = 10;
        _numBtn.inputFieldFont = 10;
        _numBtn.increaseTitle = @"＋";
        _numBtn.decreaseTitle = @"－";
        _numBtn.currentNumber = 0;
        __weak typeof(self) weakSelf = self;
        _numBtn.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            NSLog(@"num:%ld",num);
            ChangeProductAmountBlock block = weakSelf.amountChangeHandle;
            if (block) {
                block(num);
            }
        };
        [self.contentView addSubview:_numBtn];
        
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
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
