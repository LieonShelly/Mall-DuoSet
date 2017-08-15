//
//  AccountverifyCodeInputCell.m
//  DuoSet
//
//  Created by mac on 2017/1/11.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AccountverifyCodeInputCell.h"

@interface AccountverifyCodeInputCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *line;

@end

@implementation AccountverifyCodeInputCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xffffff];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textColor = [UIColor colorFromHex:0x333333];
        _tipsLable.font = CUSFONT(14);
        [self.contentView addSubview:_tipsLable];
        
        _inputTF = [UITextField newAutoLayoutView];
        _inputTF.font = CUSFONT(13);
        _inputTF.textAlignment = NSTextAlignmentLeft;
        _inputTF.tintColor = [UIColor mainColor];
        [self.contentView addSubview:_inputTF];
        
        _getVerifyCodeBtn = [UIButton newAutoLayoutView];
        _getVerifyCodeBtn.titleLabel.font = CUSFONT(10);
        _getVerifyCodeBtn.backgroundColor = [UIColor mainColor];
        [_getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVerifyCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getVerifyCodeBtn.layer.cornerRadius = 3;
        _getVerifyCodeBtn.layer.masksToBounds = true;
        [self.contentView addSubview:_getVerifyCodeBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
        
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(180.0)];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_inputTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(330.0)];
        
        [_getVerifyCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(30.0)];
        [_getVerifyCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(28.0)];
        [_getVerifyCodeBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(28.0)];
        [_getVerifyCodeBtn autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        
        [_line autoSetDimension:ALDimensionHeight toSize:1];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
