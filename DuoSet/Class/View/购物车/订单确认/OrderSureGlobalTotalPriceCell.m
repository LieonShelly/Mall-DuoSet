//
//  OrderSureGlobalTotalPriceCell.m
//  DuoSet
//
//  Created by fanfans on 2017/6/5.
//  Copyright © 2017年 Seven-Augus. All rights reserved.
//

#import "OrderSureGlobalTotalPriceCell.h"

@interface OrderSureGlobalTotalPriceCell()

@property (nonatomic,assign) BOOL didUpdateConstraints;
@property (nonatomic,strong) UILabel *allPriceTipslable;
@property (nonatomic,strong) UILabel *postTipsLable;
@property (nonatomic,strong) UILabel *privilegeTipsLable;
@property (nonatomic,strong) UIButton *taxBtn;
@property (nonatomic,strong) UILabel *allPriceLable;
@property (nonatomic,strong) UILabel *postPriceLable;
@property (nonatomic,strong) UILabel *privilegePriceLable;
@property (nonatomic,strong) UILabel *taxPriceLable;
@property (nonatomic,strong) UIButton *seletcedBtn;
@property (nonatomic,strong) UILabel *protocolLable;

@end

@implementation OrderSureGlobalTotalPriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _allPriceTipslable = [UILabel newAutoLayoutView];
        _allPriceTipslable.textColor = [UIColor colorFromHex:0x222222];
        _allPriceTipslable.textAlignment = NSTextAlignmentLeft;
        _allPriceTipslable.text = @"商品总额";
        _allPriceTipslable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_allPriceTipslable];
        
        _allPriceLable = [UILabel newAutoLayoutView];
        _allPriceLable.textColor = [UIColor mainColor];
        _allPriceLable.textAlignment = NSTextAlignmentRight;
        _allPriceLable.font = CUSNEwFONT(18);
        [self.contentView addSubview:_allPriceLable];
        
        _postTipsLable = [UILabel newAutoLayoutView];
        _postTipsLable.textColor = [UIColor colorFromHex:0x222222];
        _postTipsLable.textAlignment = NSTextAlignmentLeft;
        _postTipsLable.font = CUSNEwFONT(15);
        _postTipsLable.text = @"运费";
        [self.contentView addSubview:_postTipsLable];
        
        _postPriceLable = [UILabel newAutoLayoutView];
        _postPriceLable.textColor = [UIColor mainColor];
        _postPriceLable.textAlignment = NSTextAlignmentRight;
        _postPriceLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_postPriceLable];
        
        _privilegeTipsLable = [UILabel newAutoLayoutView];
        _privilegeTipsLable.textColor = [UIColor colorFromHex:0x222222];
        _privilegeTipsLable.textAlignment = NSTextAlignmentLeft;
        _privilegeTipsLable.font = CUSNEwFONT(15);
        _privilegeTipsLable.text = @"优惠";
        [self.contentView addSubview:_privilegeTipsLable];
        
        _privilegePriceLable = [UILabel newAutoLayoutView];
        _privilegePriceLable.textColor = [UIColor mainColor];
        _privilegePriceLable.textAlignment = NSTextAlignmentRight;
        _privilegePriceLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_privilegePriceLable];
        
        _taxBtn = [UIButton newAutoLayoutView];
        _taxBtn.titleLabel.font = CUSNEwFONT(15);
        [_taxBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [_taxBtn setTitle:@"税费" forState:UIControlStateNormal];
        [_taxBtn setImage:[UIImage imageNamed:@"global_question_des_gary"] forState:UIControlStateNormal];
        _taxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -FitWith(60.0), 0, 0);
        _taxBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -FitWith(120.0));
        [_taxBtn addTarget:self action:@selector(taxDesBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_taxBtn];
        
        _taxPriceLable = [UILabel newAutoLayoutView];
        _taxPriceLable.textColor = [UIColor mainColor];
        _taxPriceLable.textAlignment = NSTextAlignmentRight;
        _taxPriceLable.font = CUSNEwFONT(16);
        [self.contentView addSubview:_taxPriceLable];
        
        _seletcedBtn = [UIButton newAutoLayoutView];
        _seletcedBtn.titleLabel.font = CUSNEwFONT(14);
        [_seletcedBtn setTitleColor:[UIColor colorFromHex:0x222222] forState:UIControlStateNormal];
        [_seletcedBtn setImage:[UIImage imageNamed:@"choose_default"] forState:UIControlStateNormal];
        [_seletcedBtn setImage:[UIImage imageNamed:@"choose_selected"] forState:UIControlStateSelected];
        _seletcedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _seletcedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, FitWith(20.0), 0, 0);
        [_seletcedBtn setTitle:@"我已阅读并遵守" forState:UIControlStateNormal];
        [_seletcedBtn addTarget:self action:@selector(seletcedProtocolBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_seletcedBtn];
        
        _protocolLable = [UILabel newAutoLayoutView];
        _protocolLable.font = CUSNEwFONT(14);
        _protocolLable.textColor = [UIColor mainColor];
        _protocolLable.text = @"《用户服务协议》";
        _protocolLable.textAlignment = NSTextAlignmentLeft;
        _protocolLable.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(protocolLableBtnAction)];
        [_protocolLable addGestureRecognizer:tap];
        [self.contentView addSubview:_protocolLable];
        
        [self.contentView setNeedsUpdateConstraints];
    }
    return self;
}

-(void)protocolLableBtnAction{
    ReadProtocolBlock block = _readProtocolHandle;
    if (block) {
        block();
    }
}

-(void)taxDesBtnAction{
    TaxDesBlock block = _taxDexHandle;
    if (block) {
        block();
    }
}

-(void)seletcedProtocolBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    AgreeProtocolBlock block = _agreeProtocolHandle;
    if (block) {
        block(btn);
    }
}

-(void)setupInfoWithShopCarSureData:(ShopCarSureData *)item{
    NSString *text = [NSString stringWithFormat:@"￥ %@",item.productPrice];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeString addAttribute:NSFontAttributeName value:CUSNEwFONT(16) range:NSMakeRange(0,1)];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _allPriceLable.attributedText = attributeString;
    
    NSString *postText = [NSString stringWithFormat:@"+￥%@",item.carrierPrice];
    NSMutableAttributedString *attributeString1 = [[NSMutableAttributedString alloc]initWithString:postText];
    [attributeString1 addAttribute:NSFontAttributeName value:CUSNEwFONT(14) range:NSMakeRange(0,1)];
    [attributeString1 addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _postPriceLable.attributedText = attributeString1;
    
    NSString *cutText = [NSString stringWithFormat:@"-￥%@",item.cutPrice];
    NSMutableAttributedString *attributeString2 = [[NSMutableAttributedString alloc]initWithString:cutText];
    [attributeString2 addAttribute:NSFontAttributeName value:CUSNEwFONT(14) range:NSMakeRange(0,1)];
    [attributeString2 addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _privilegePriceLable.attributedText = attributeString2;
    
    NSString *taxText = [NSString stringWithFormat:@"+￥%@",item.totalTaxPrice];
    NSMutableAttributedString *attributeString3 = [[NSMutableAttributedString alloc]initWithString:taxText];
    [attributeString3 addAttribute:NSFontAttributeName value:CUSNEwFONT(14) range:NSMakeRange(0,1)];
    [attributeString3 addAttribute:NSForegroundColorAttributeName value:[UIColor mainColor] range:NSMakeRange(0,1)];
    _taxPriceLable.attributedText = attributeString3;
    
    _seletcedBtn.selected = item.agreePropocol;
}

- (void)updateConstraints{
    if (!_didUpdateConstraints) {
        
        [_allPriceTipslable autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:FitWith(24.0)];
        [_allPriceTipslable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:FitHeight(22.0)];
        
        [_allPriceLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_allPriceTipslable];
        [_allPriceLable autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:FitWith(24.0)];
        
        [_postTipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_allPriceTipslable];
        [_postTipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_allPriceTipslable withOffset:FitHeight(10)];
        
        [_postPriceLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_postTipsLable];
        [_postPriceLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_allPriceLable];
        
        [_taxBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_allPriceTipslable];
        [_taxBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_postTipsLable withOffset:FitHeight(10)];
        [_taxBtn autoSetDimension:ALDimensionWidth toSize:FitWith(92.0)];
        
        [_taxPriceLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_postPriceLable];
        [_taxPriceLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_taxBtn];
        
        [_privilegeTipsLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_allPriceTipslable];
        [_privilegeTipsLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_taxBtn withOffset:FitHeight(10)];
        
        [_privilegePriceLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_privilegeTipsLable];
        [_privilegePriceLable autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:_allPriceLable];
        
        [_seletcedBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:_privilegeTipsLable];
        [_seletcedBtn autoSetDimension:ALDimensionWidth toSize:FitWith(250.0)];
        [_seletcedBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_privilegeTipsLable withOffset:FitHeight(30)];
        
        [_protocolLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_seletcedBtn];
        [_protocolLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:_seletcedBtn];
        
        _didUpdateConstraints = YES;
    }
    [super updateConstraints];
}

@end
