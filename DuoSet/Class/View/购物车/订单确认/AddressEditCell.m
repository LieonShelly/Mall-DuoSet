//
//  AddressEditCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "AddressEditCell.h"

@interface AddressEditCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *deletedBtn;

@end

@implementation AddressEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _defaultbtn = [UIButton newAutoLayoutView];
        _defaultbtn.titleLabel.font = CUSFONT(13);
        _defaultbtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
        _defaultbtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_defaultbtn setTitle:@"默认地址" forState:UIControlStateNormal];
        [_defaultbtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_defaultbtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_defaultbtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_defaultbtn addTarget:self action:@selector(setBtnAcitons:) forControlEvents:UIControlEventTouchUpInside];
        _defaultbtn.tag = 0;
        [self.contentView addSubview:_defaultbtn];
        
        _editBtn = [UIButton newAutoLayoutView];
        _editBtn.titleLabel.font = CUSFONT(13);
        _editBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -7);
        _editBtn.imageView.contentMode = UIViewContentModeCenter;
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"address_edit"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(setBtnAcitons:) forControlEvents:UIControlEventTouchUpInside];
        _editBtn.tag = 1;
        [self.contentView addSubview:_editBtn];
        
        _deletedBtn = [UIButton newAutoLayoutView];
        _deletedBtn.titleLabel.font = CUSFONT(13);
        _deletedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -7);
        _deletedBtn.imageView.contentMode = UIViewContentModeCenter;
        [_deletedBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deletedBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_deletedBtn setImage:[UIImage imageNamed:@"address_delete"] forState:UIControlStateNormal];
        [_deletedBtn addTarget:self action:@selector(setBtnAcitons:) forControlEvents:UIControlEventTouchUpInside];
        _deletedBtn.tag = 2;
        [self.contentView addSubview:_deletedBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        [_defaultbtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_defaultbtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_defaultbtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_defaultbtn autoSetDimension:ALDimensionWidth toSize:FitWith(150.0)];
        
        [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_editBtn autoSetDimension:ALDimensionWidth toSize:FitWith(100.0)];
        [_editBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(450.0)];
        
        [_deletedBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_deletedBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_deletedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(100.0)];
        [_deletedBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_editBtn withOffset:FitWith(40.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

-(void)setBtnAcitons:(UIButton *)btn{
    EditCellActionBlock block = _editBtnHandle;
    if (block) {
        block(btn);
    }
}


@end
