//
//  OrderSureGlobalInputCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureGlobalInputCell.h"

@interface OrderSureGlobalInputCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIButton *saveBtn;
@property (nonatomic,strong) UIView *line;

@end

@implementation OrderSureGlobalInputCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _nameInputTextFiled = [UITextField newAutoLayoutView];
        _nameInputTextFiled.placeholder = @"因海关清关需要，请填写收货人身份证上的姓名";
        _nameInputTextFiled.font = CUSNEwFONT(15);
        _nameInputTextFiled.textColor = [UIColor colorFromHex:0x222222];
        _nameInputTextFiled.tintColor = [UIColor mainColor];
        _nameInputTextFiled.tag = 0;
        [_nameInputTextFiled addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_nameInputTextFiled];
        
        _numInputTextFiled = [UITextField newAutoLayoutView];
        _numInputTextFiled.placeholder = @"因海关需要，请填写收货人二代身份证";
        _numInputTextFiled.font = CUSNEwFONT(15);
        _numInputTextFiled.textColor = [UIColor colorFromHex:0x222222];
        _numInputTextFiled.tintColor = [UIColor mainColor];
        _numInputTextFiled.tag = 0;
        [_numInputTextFiled addTarget:self action:@selector(textFiledDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.contentView addSubview:_numInputTextFiled];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        _saveBtn = [UIButton newAutoLayoutView];
        [_saveBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorFromHex:0xcccccc]] forState:UIControlStateDisabled];
        [_saveBtn setBackgroundImage:[UIImage imageWithColor:[UIColor mainColor]] forState:UIControlStateNormal];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitle:@"编辑" forState:UIControlStateSelected];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(identityInfoSave:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.titleLabel.font = CUSNEwFONT(16);
        _saveBtn.enabled = false;
        [self.contentView addSubview:_saveBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupRealName:(NSString *)realName AndIdentityCard:(NSString *)identityCard andIsEdit:(BOOL)isEdit{
    _nameInputTextFiled.text = realName;
    _numInputTextFiled.text = identityCard;
    if (_nameInputTextFiled.text.length > 0 && [Utils IsIdentityCard:_numInputTextFiled.text]) {
        _saveBtn.enabled = true;
        _saveBtn.selected = isEdit;
    }else{
        _saveBtn.enabled = false;
    }
    if (isEdit) {
        _nameInputTextFiled.userInteractionEnabled = false;
        _numInputTextFiled.userInteractionEnabled = false;
    }else{
        _nameInputTextFiled.userInteractionEnabled = true;
        _numInputTextFiled.userInteractionEnabled = true;
    }
}

-(void)textFiledDidChange:(UITextField *)textField{
    NSString *temp = [_nameInputTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    IdentityInfoChangeBlock block = _changeHandle;
    if (block) {
        block(temp,_numInputTextFiled.text);
    }
    if (temp.length > 0 && [Utils IsIdentityCard:_numInputTextFiled.text]) {
        _saveBtn.enabled = true;
    }else{
        _saveBtn.enabled = false;
    }
}

-(void)identityInfoSave:(UIButton *)btn{
    if (_saveBtn.selected) {
        _nameInputTextFiled.userInteractionEnabled = true;
        _numInputTextFiled.userInteractionEnabled = true;
        [_nameInputTextFiled becomeFirstResponder];
        _saveBtn.selected = false;
        EditSaveBlock block = _editHandle;
        if (block) {
            block(btn);
        }
        return;
    }
    [_nameInputTextFiled resignFirstResponder];
    [_numInputTextFiled resignFirstResponder];
    NSString *temp = [_nameInputTextFiled.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    IdentityInfoSaveBlock block = _saveHandle;
    if (block) {
        block(temp,_numInputTextFiled.text,btn);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_nameInputTextFiled autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(20.0)];
        [_nameInputTextFiled autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(20.0)];
        [_nameInputTextFiled autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_nameInputTextFiled autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_nameInputTextFiled];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        [_numInputTextFiled autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_nameInputTextFiled];
        [_numInputTextFiled autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line];
        [_numInputTextFiled autoSetDimension:ALDimensionHeight toSize:FitHeight(100.0)];
        [_numInputTextFiled autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(112.0)];
        
        [_saveBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_numInputTextFiled];
        [_saveBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_line];
        [_saveBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_saveBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
