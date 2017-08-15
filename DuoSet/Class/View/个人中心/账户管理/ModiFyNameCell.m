//
//  ModiFyNameCell.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ModiFyNameCell.h"

@interface ModiFyNameCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;

@end
@implementation ModiFyNameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _inputTF = [UITextField newAutoLayoutView];
        _inputTF.font = CUSFONT(13);
        _inputTF.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_inputTF];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xf1f1f1];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(200)];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
