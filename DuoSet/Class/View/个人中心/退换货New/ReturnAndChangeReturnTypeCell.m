//
//  ReturnAndChangeReturnTypeCell.m
//  DuoSet
//
//  Created by fanfans on 2017/5/12.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeReturnTypeCell.h"

@interface ReturnAndChangeReturnTypeCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *tipLable;
@property (nonatomic,strong) UIButton *returnBtn;
@property (nonatomic,strong) UILabel *desLable;

@end

@implementation ReturnAndChangeReturnTypeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorFromHex:0xf7f7f7];
        
        _bgView = [UIView newAutoLayoutView];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        
        _tipLable = [UILabel newAutoLayoutView];
        _tipLable.text = @"商品退回方式";
        _tipLable.textColor = [UIColor colorFromHex:0x212121];
        _tipLable.font = CUSNEwFONT(16);
        [_bgView addSubview:_tipLable];
        
        _returnBtn = [UIButton newAutoLayoutView];
        _returnBtn.titleLabel.font = CUSNEwFONT(16);
        [_returnBtn setTitle:@"快递至哆集" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor mainColor] forState:UIControlStateNormal];
        _returnBtn.layer.borderWidth = 0.5;
        _returnBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _returnBtn.layer.cornerRadius = 3;
        _returnBtn.userInteractionEnabled = false;
        [_bgView addSubview:_returnBtn];
        
        _desLable = [UILabel newAutoLayoutView];
        _desLable.textColor = [UIColor colorFromHex:0x808080];
        _desLable.text = @"注：商品寄回地址将在审核通过后以短信形式告知，或在查看申请进度-进度查询。寄回运费自理";
        _desLable.font = CUSNEwFONT(14);
        _desLable.numberOfLines = 2;
        [_bgView addSubview:_desLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_bgView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(16.0)];
        
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_tipLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(30.0)];
        
        [_returnBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipLable];
        [_returnBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipLable withOffset:FitHeight(20.0)];
        [_returnBtn autoSetDimension:ALDimensionWidth toSize:FitWith(200.0)];
        [_returnBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(26.0)];
        [_desLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(26.0)];
        [_desLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_returnBtn withOffset:FitHeight(20.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
