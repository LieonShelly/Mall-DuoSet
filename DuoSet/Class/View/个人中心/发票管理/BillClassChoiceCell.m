//
//  BillClassChoiceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/3/22.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "BillClassChoiceCell.h"

@interface BillClassChoiceCell()

@property(nonatomic,assign) BOOL didUpdateConstraints;

@end

@implementation BillClassChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _paperBillBtn = [UIButton newAutoLayoutView];
        _paperBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _paperBillBtn.layer.borderWidth = 1;
        _paperBillBtn.layer.masksToBounds = true;
        _paperBillBtn.layer.cornerRadius = 3;
        _paperBillBtn.selected = true;
        _paperBillBtn.tag = 0;
        _paperBillBtn.titleLabel.font = CUSFONT(12);
        [_paperBillBtn setTitle:@"纸质发票" forState:UIControlStateNormal];
        [_paperBillBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_paperBillBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_paperBillBtn addTarget:self action:@selector(btnsActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_paperBillBtn];
        
        _electronBillBtn = [UIButton newAutoLayoutView];
        _electronBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _electronBillBtn.layer.borderWidth = 1;
        _electronBillBtn.layer.masksToBounds = true;
        _electronBillBtn.layer.cornerRadius = 3;
        _electronBillBtn.selected = false;
        _electronBillBtn.tag = 1;
        _electronBillBtn.titleLabel.font = CUSFONT(12);
        [_electronBillBtn setTitle:@"电子发票" forState:UIControlStateNormal];
        [_electronBillBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_electronBillBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_electronBillBtn addTarget:self action:@selector(btnsActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        _electronBillBtn.hidden = true;
        [self.contentView addSubview:_electronBillBtn];
        
        _moreBillBtn = [UIButton newAutoLayoutView];
        _moreBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        _moreBillBtn.layer.borderWidth = 1;
        _moreBillBtn.layer.masksToBounds = true;
        _moreBillBtn.selected = false;
        _moreBillBtn.layer.cornerRadius = 3;
        _moreBillBtn.tag = 2;
        _moreBillBtn.titleLabel.font = CUSFONT(12);
        [_moreBillBtn setTitle:@"增值发票" forState:UIControlStateNormal];
        [_moreBillBtn setTitleColor:[UIColor mainColor] forState:UIControlStateSelected];
        [_moreBillBtn setTitleColor:[UIColor colorFromHex:0x808080] forState:UIControlStateNormal];
        [_moreBillBtn addTarget:self action:@selector(btnsActionHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_moreBillBtn];
        
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}


-(void)setUpBtnSeletcedWithBillChoiceStyle:(BillChoiceStyle)billStatus{
    if (billStatus == BillChoiceStatusWithQualification) {
        _moreBillBtn.selected = true;
        _moreBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        
        _electronBillBtn.selected = false;
        _electronBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _paperBillBtn.selected = false;
        _paperBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }else if (billStatus == BillChoiceStatusWithPaperCompany || billStatus == BillChoiceStatusWithPaperPersion){//纸发票
        
        _moreBillBtn.selected = false;
        _moreBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _electronBillBtn.selected = false;
        _electronBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _paperBillBtn.selected = true;
        _paperBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        
    }else if (billStatus == BillChoiceStatusWithElectronicPersion || billStatus == BillChoiceStatusWithElectronicCompany){
        _moreBillBtn.selected = false;
        _moreBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _electronBillBtn.selected = true;
        _electronBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        
        _paperBillBtn.selected = false;
        _paperBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
}


-(void)btnsActionHandle:(UIButton *)btn{
    if (btn.tag == 0) {
        _moreBillBtn.selected = false;
        _moreBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _electronBillBtn.selected = false;
        _electronBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _paperBillBtn.selected = true;
        _paperBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
    }
    if (btn.tag == 1) {
        _moreBillBtn.selected = false;
        _moreBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _electronBillBtn.selected = true;
        _electronBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        
        _paperBillBtn.selected = false;
        _paperBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        _paperBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
    if (btn.tag == 2) {
        _moreBillBtn.selected = true;
        _moreBillBtn.layer.borderColor = [UIColor mainColor].CGColor;
        
        _electronBillBtn.selected = false;
        _electronBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
        
        _paperBillBtn.selected = false;
        _paperBillBtn.layer.borderColor = [UIColor colorFromHex:0x808080].CGColor;
    }
    BillChoiceClassBlock block = _choiceHandle;
    if (block) {
        block(btn.tag);
    }
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_paperBillBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_paperBillBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_paperBillBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(26.0)];
        [_paperBillBtn autoSetDimension:ALDimensionWidth toSize:FitWith(144.0)];
        
        [_electronBillBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_paperBillBtn withOffset:FitWith(20.0)];
        [_electronBillBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_electronBillBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(26.0)];
        [_electronBillBtn autoSetDimension:ALDimensionWidth toSize:FitWith(144.0)];
        
        [_moreBillBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_electronBillBtn withOffset:FitWith(20.0)];
        [_moreBillBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(10.0)];
        [_moreBillBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:FitHeight(26.0)];
        [_moreBillBtn autoSetDimension:ALDimensionWidth toSize:FitWith(144.0)];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}
@end
