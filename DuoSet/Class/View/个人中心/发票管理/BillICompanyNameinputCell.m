//
//  BillICompanyNameinputCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BillICompanyNameinputCell.h"

@interface BillICompanyNameinputCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation BillICompanyNameinputCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _inputTF = [UITextField newAutoLayoutView];
        _inputTF.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        _inputTF.returnKeyType = UIReturnKeyDone;
        UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, FitWith(24.0), FitHeight(72.0))];
        _inputTF.leftViewMode = UITextFieldViewModeAlways;
        _inputTF.placeholder = @"请填写单位名称";
        _inputTF.font = CUSFONT(13);
        _inputTF.leftView = leftView;
        
        [self.contentView addSubview:_inputTF];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitWith(10.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitWith(26.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
