//
//  ReturnAndChangeChoiceTypeCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeChoiceTypeCell.h"

@interface ReturnAndChangeChoiceTypeCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *choiceTypeLable;
@property (nonatomic,strong) UIButton *returnBtn;
@property (nonatomic,strong) UIButton *changeBtn;
@property (nonatomic,strong) UIView *line;

@end

@implementation ReturnAndChangeChoiceTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _choiceTypeLable = [UILabel newAutoLayoutView];
        _choiceTypeLable.text = @"服务类型";
        _choiceTypeLable.textColor = [UIColor colorFromHex:0x212121];
        _choiceTypeLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_choiceTypeLable];
        
        _returnBtn = [UIButton newAutoLayoutView];
        _returnBtn.titleLabel.font = CUSNEwFONT(16);
        _returnBtn.tag = 0;
        [_returnBtn setTitle:@"退货" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateDisabled];
        [_returnBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_returnBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _returnBtn.layer.borderWidth = 0.5;
        _returnBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        _returnBtn.layer.cornerRadius = 3;
        [self.contentView addSubview:_returnBtn];
        
        _changeBtn = [UIButton newAutoLayoutView];
        _changeBtn.titleLabel.font = CUSNEwFONT(16);
        _changeBtn.tag = 1;
        [_changeBtn setTitle:@"换货" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor colorFromHex:0x212121] forState:UIControlStateDisabled];
        [_changeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_changeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _changeBtn.layer.borderWidth = 0.5;
        _changeBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        _changeBtn.layer.cornerRadius = 3;
        [self.contentView addSubview:_changeBtn];
        
        _line = [UIView newAutoLayoutView];
        _line.backgroundColor = [UIColor colorFromHex:0xe5e5e5];
        [self.contentView addSubview:_line];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setupInfoWithNewReturnAndChangeData:(NewReturnAndChangeData *)item{
    _returnBtn.enabled = item.isReturn;
    _changeBtn.enabled = item.isChange;
}

-(void)setupBtnSeletcedWithIndex:(NSInteger)index{
    if (index == -1) {
        return;
    }
    if (index == 0) {
        _returnBtn.selected = true;
        _returnBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _changeBtn.selected = false;
        _changeBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
    if (index == 1) {
        _changeBtn.selected = true;
        _changeBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _returnBtn.selected = false;
        _returnBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
}

-(void)btnAction:(UIButton *)btn{
    if (btn.tag == 0) {
        _returnBtn.selected = true;
        _returnBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _changeBtn.selected = false;
        _changeBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
    if (btn.tag == 1) {
        _changeBtn.selected = true;
        _changeBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _returnBtn.selected = false;
        _returnBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
    CellButtonActionBlock block = _btnHandle;
    if (block) {
        block(btn.tag);
    }
}



- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_choiceTypeLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_choiceTypeLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_returnBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_choiceTypeLable];
        [_returnBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_choiceTypeLable withOffset:FitHeight(20.0)];
        [_returnBtn autoSetDimension:ALDimensionWidth toSize:FitWith(130.0)];
        [_returnBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_changeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_returnBtn];
        [_changeBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_returnBtn withOffset:FitWith(20.0)];
        [_changeBtn autoSetDimension:ALDimensionWidth toSize:FitWith(130.0)];
        [_changeBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_line autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_line autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_line autoSetDimension:ALDimensionHeight toSize:0.5];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
