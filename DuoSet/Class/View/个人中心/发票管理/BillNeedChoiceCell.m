//
//  BillNeedChoiceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BillNeedChoiceCell.h"

@interface BillNeedChoiceCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UILabel *tipsLable;
@property(nonatomic,strong) UIButton *needBtn;
@property(nonatomic,strong) UIButton *notNeedBtn;
@property(nonatomic,strong) UIButton *markNeedkBtn;
@property(nonatomic,strong) UIButton *markNotNeedkBtn;

@end

@implementation BillNeedChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _tipsLable = [UILabel newAutoLayoutView];
        _tipsLable.textColor = [UIColor colorFromHex:0x808080];
        _tipsLable.font = CUSFONT(12);
        _tipsLable.textAlignment = NSTextAlignmentLeft;
        _tipsLable.numberOfLines = 3;
        _tipsLable.text = @"非图书类商品";
        [self.contentView addSubview:_tipsLable];
        
        _needBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), FitHeight(30.0), FitWith(260.0), FitHeight(60.0))];
        _needBtn.titleLabel.font = CUSFONT(13);
        _needBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_needBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_needBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_needBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_needBtn setTitle:@"明细" forState:UIControlStateNormal];
        _needBtn.selected = false;
        _needBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [self.contentView addSubview:_needBtn];
        
        _notNeedBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), FitHeight(30.0), FitWith(260.0), FitHeight(60.0))];
        _notNeedBtn.titleLabel.font = CUSFONT(13);
        _notNeedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_notNeedBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_notNeedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_notNeedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_notNeedBtn setTitle:@"不开发票" forState:UIControlStateNormal];
        _notNeedBtn.selected = true;
        _notNeedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [self.contentView addSubview:_notNeedBtn];
        
        _markNeedkBtn = [UIButton newAutoLayoutView];
        _markNeedkBtn.selected = false;
        _markNeedkBtn.tag = 0 ;
        [_markNeedkBtn addTarget:self action:@selector(btnsActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_markNeedkBtn];
        
        _markNotNeedkBtn = [UIButton newAutoLayoutView];
        _markNotNeedkBtn.selected = true;
        _markNotNeedkBtn.tag = 1 ;
        [_markNotNeedkBtn addTarget:self action:@selector(btnsActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_markNotNeedkBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)setUpBtnSeletcedWithBillChoiceStyle:(BillChoiceStyle)billStatus{
    if (billStatus == BillChoiceStatusWithNoNeed) {
        _notNeedBtn.selected = true;
        _markNotNeedkBtn.selected = true;
        _needBtn.selected = false;
        _markNeedkBtn.selected = false;
    }else{
        _notNeedBtn.selected = false;
        _markNotNeedkBtn.selected = false;
        _needBtn.selected = true;
        _markNeedkBtn.selected = true;
    }
}

-(void)btnsActionHandle:(UIButton *)btn{
    if (btn.tag == 0) {
        _markNeedkBtn.selected = true;
        _needBtn.selected = true;
        _markNotNeedkBtn.selected = !_markNeedkBtn.selected;
        _notNeedBtn.selected = !_needBtn.selected;
    }
    if (btn.tag == 1) {
        _markNotNeedkBtn.selected = true;
        _notNeedBtn.selected = true;
        _markNeedkBtn.selected = !_markNotNeedkBtn.selected;
        _needBtn.selected = !_notNeedBtn.selected;
    }
    BillNeedChoiceBlock block = _choiceHanlde;
    if (block) {
        block(btn);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_tipsLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10)];
        
        [_needBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        [_needBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipsLable withOffset:FitHeight(10.0)];
        [_needBtn autoSetDimension:ALDimensionWidth toSize:FitWith(300.0)];
        [_needBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_notNeedBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_tipsLable];
        [_notNeedBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_needBtn withOffset:FitHeight(10.0)];
        [_notNeedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(400.0)];
        [_notNeedBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_markNeedkBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_tipsLable];
        [_markNeedkBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_markNeedkBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_markNeedkBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_markNotNeedkBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_markNeedkBtn];
        [_markNotNeedkBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [_markNotNeedkBtn autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [_markNotNeedkBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
