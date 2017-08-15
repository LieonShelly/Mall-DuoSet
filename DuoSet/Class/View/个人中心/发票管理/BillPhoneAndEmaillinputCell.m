//
//  BillPhoneAndEmaillinputCell.m
//  DuoSet
//
//  Created by fanfans on 2017/4/19.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BillPhoneAndEmaillinputCell.h"

@interface BillPhoneAndEmaillinputCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *phoneLable;
@property(nonatomic,strong) UILabel *emailLable;

@end

@implementation BillPhoneAndEmaillinputCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.text = @"收票人信息";
        _tipsLable.font = CUSFONT(12);
        _tipsLable.textColor = [UIColor colorFromHex:0x222222];
        [self.contentView addSubview:_tipsLable];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        _phoneLable = [UILabel newAutoLayoutView];
        _phoneLable.font = CUSFONT(11);
        _phoneLable.textAlignment = NSTextAlignmentLeft;
        NSString *text = @"*收票人手机号：";
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
        if (text.length > 2) {
            [attributeString addAttribute:NSFontAttributeName value:CUSFONT(13) range:NSMakeRange(0, 1)];
            [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0, 1)];
        }
        _phoneLable.attributedText = attributeString;
        [self.contentView addSubview:_phoneLable];
        
        _phoneTF = [UITextField newAutoLayoutView];
        _phoneTF.placeholder = @"请输入收票人的手机号码";
        _phoneTF.textColor = [UIColor colorFromHex:0x222222];
        _phoneTF.font = CUSFONT(11);
        _phoneTF.returnKeyType = UIReturnKeyDone;
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        [self.contentView addSubview:_phoneTF];
        
        _emailLable = [UILabel newAutoLayoutView];
        _emailLable.text = @"收票人电子邮箱：";
        _emailLable.font = CUSFONT(11);
        _emailLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_emailLable];
        
        _emailTF = [UITextField newAutoLayoutView];
        _emailTF.placeholder = @"用来接收电子发票邮箱，可选填";
        _emailTF.textColor = [UIColor colorFromHex:0x222222];
        _emailTF.font = CUSFONT(11);
        _emailTF.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:_emailTF];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        
        [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(68.0)];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_phoneLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        [_phoneLable autoSetDimension:ALDimensionHeight toSize:FitHeight(70.0)];
        [_phoneLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line withOffset:FitHeight(15.0)];
        
        [_phoneTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_phoneLable];
        [_phoneTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_phoneTF autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_emailLable];
        [_phoneTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(240.0)];
        
        [_emailLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_phoneLable];
        [_emailLable autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_phoneLable];
        [_emailLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_phoneLable withOffset:FitHeight(10.0)];
        
        [_emailTF autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_emailLable];
        [_emailTF autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        [_emailTF autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_emailLable];
        [_emailTF autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(240.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
