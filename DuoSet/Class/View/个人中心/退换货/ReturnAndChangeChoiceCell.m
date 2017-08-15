//
//  ReturnAndChangeChoiceCell.m
//  DuoSet
//
//  Created by mac on 2017/1/9.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "ReturnAndChangeChoiceCell.h"

@interface ReturnAndChangeChoiceCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIButton *returnBtn;
@property(nonatomic,strong) UIButton *changeBtn;
@property(nonatomic,strong) UIButton *refundBtn;

@end

@implementation ReturnAndChangeChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHex:0xffffff];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.text = @"服务类型";
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.textColor = [UIColor colorFromHex:0x333333];
        _tipsLable.font = CUSFONT(12);
        [self.contentView addSubview:_tipsLable];
        
        _returnBtn = [UIButton newAutoLayoutView];
        _returnBtn.tag = 0;
        _returnBtn.titleLabel.font = CUSFONT(11);
        _returnBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _returnBtn.layer.borderWidth = 0.5;
        _returnBtn.layer.cornerRadius = 2;
        [_returnBtn setTitle:@"申请退货" forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_returnBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_returnBtn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_returnBtn];
        
        _changeBtn = [UIButton newAutoLayoutView];
        _changeBtn.titleLabel.font = CUSFONT(11);
        _changeBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _changeBtn.layer.borderWidth = 0.5;
        _changeBtn.layer.cornerRadius = 2;
        [_changeBtn setTitle:@"申请换货" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_changeBtn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        _changeBtn.tag = 1;
        [self addSubview:_changeBtn];
        
        _refundBtn = [UIButton newAutoLayoutView];
        _refundBtn.titleLabel.font = CUSFONT(11);
        _refundBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _refundBtn.layer.borderWidth = 0.5;
        _refundBtn.layer.cornerRadius = 2;
        [_refundBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_refundBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_refundBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_refundBtn addTarget:self action:@selector(bottomBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        _refundBtn.tag = 2;
        [self addSubview:_refundBtn];
        
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setBtnShowWithDuojiOrderProductData:(DuojiOrderProductData *)product{
    if (product.productStatus == OrderStatesPaid) {
        _changeBtn.hidden = true;
        _refundBtn.hidden = true;
        [_returnBtn setTitle:@"申请退款" forState:UIControlStateNormal];
    }
    if (product.productStatus == OrderStatesRecive || product.productStatus == OrderStatesDiscussed) {
        _refundBtn.hidden = true;
        [_returnBtn setTitle:@"申请退款" forState:UIControlStateNormal];
        [_changeBtn setTitle:@"申请换货" forState:UIControlStateNormal];
    }
}

-(void)bottomBtnsAction:(UIButton *)btn{
    if (btn.tag == 0) {
        _returnBtn.selected = true;
        _returnBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _changeBtn.selected = false;
        _changeBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _refundBtn.selected = false;
        _refundBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
    }else if(btn.tag == 1){
        _returnBtn.selected = false;
        _returnBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _changeBtn.selected = true;
        _changeBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _refundBtn.selected = false;
        _refundBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
    }else{
        _returnBtn.selected = false;
        _returnBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _changeBtn.selected = false;
        _changeBtn.layer.borderColor = [UIColor colorFromHex:0x999999].CGColor;
        _refundBtn.selected = true;
        _refundBtn.layer.borderColor = [UIColor mainColor].CGColor;
    }
    CellChoiceBtnActionBlock block = _choiceHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(30.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        
        [_returnBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        [_returnBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipsLable withOffset:FitHeight(20.0)];
        [_returnBtn autoSetDimension:ALDimensionWidth toSize:FitWith(130.0)];
        [_returnBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(50.0)];
        
        [_changeBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_returnBtn];
        [_changeBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_returnBtn];
        [_changeBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_returnBtn];
        [_changeBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_returnBtn withOffset:FitWith(40.0)];
        
        [_refundBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:_returnBtn];
        [_refundBtn autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:_returnBtn];
        [_refundBtn autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:_returnBtn];
        [_refundBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_changeBtn withOffset:FitWith(40.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
