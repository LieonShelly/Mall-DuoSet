//
//  BillNameChoiceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BillNameChoiceCell.h"

@interface BillNameChoiceCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;
@property(nonatomic,strong) UIButton *persionBtn;
@property(nonatomic,strong) UIButton *companyBtn;

@end

@implementation BillNameChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _persionBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), FitHeight(30.0), FitWith(260.0), FitHeight(60.0))];
        _persionBtn.titleLabel.font = CUSFONT(13);
        _persionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_persionBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_persionBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_persionBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_persionBtn setTitle:@"个人" forState:UIControlStateNormal];
        _persionBtn.selected = true;
        _persionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _persionBtn.tag = 0;
        [_persionBtn addTarget:self action:@selector(btnsActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_persionBtn];
        
        _companyBtn = [[UIButton alloc]initWithFrame:CGRectMake(FitWith(20.0), FitHeight(30.0), FitWith(260.0), FitHeight(60.0))];
        _companyBtn.titleLabel.font = CUSFONT(13);
        _companyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_companyBtn setTitleColor:[UIColor colorFromHex:0x666666] forState:UIControlStateNormal];
        [_companyBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_companyBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        [_companyBtn setTitle:@"单位" forState:UIControlStateNormal];
        _companyBtn.tag = 1;
        [_companyBtn addTarget:self action:@selector(btnsActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        _companyBtn.selected = false;
        _companyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.contentView addSubview:_companyBtn];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


-(void)setUpBtnSeletcedWithBillChoiceStyle:(BillChoiceStyle)billStatus{
    if (billStatus == BillChoiceStatusWithPaperPersion || billStatus == BillChoiceStatusWithElectronicPersion) {
        _persionBtn.selected = true;
        _companyBtn.selected = false;
    }
    if (billStatus == BillChoiceStatusWithPaperCompany || billStatus == BillChoiceStatusWithElectronicCompany) {
        _persionBtn.selected = false;
        _companyBtn.selected = true;
    }
}


-(void)btnsActionHandle:(UIButton *)btn{
    if (btn.tag == 0) {
        _persionBtn.selected = true;
        _companyBtn.selected = false;
    }
    if (btn.tag == 1) {
        _persionBtn.selected = false;
        _companyBtn.selected = true;
    }
    BillNameChoiceBlock block = _nameChoiceHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_persionBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_persionBtn autoPinEdgeToSuperviewEdge:ALEdgeTop ];
        [_persionBtn autoSetDimension:ALDimensionWidth toSize:FitWith(200.0)];
        [_persionBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        [_companyBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_persionBtn withOffset:FitWith(20.0)];
        [_companyBtn autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_companyBtn autoSetDimension:ALDimensionWidth toSize:FitWith(200.0)];
        [_companyBtn autoSetDimension:ALDimensionHeight toSize:FitHeight(60.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}


@end
